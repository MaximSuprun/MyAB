/**
 * 
 * Generic async request, provides timeout functionality and responder implementation
 *
 */

package com.razzmatazz.net {
	
	//import com.demonsters.debugger.MonsterDebugger;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	//import flash.net.URLRequestDefaults;
	import flash.net.URLVariables;
	
	
	public class HTTPRequest extends AbstractRequest{
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		protected var _urlLoader:URLLoader;
		protected var _urlRequest:URLRequest;
		protected var _postData:URLVariables;
		protected var _httpStatus:int;
		
		public static const REQUESTS_TIME_OUT:int = 300; // 6minutes
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//--------------------------------------------------------------------------------------------------------- 
		public function HTTPRequest(pURLRequest:URLRequest) {
			_urlRequest = pURLRequest;
			/*_urlRequest.cacheResponse = false;
			_urlRequest.useCache = false;
			URLRequestDefaults.idleTimeout = REQUESTS_TIME_OUT*1000; //this is the important line that you need
			if(CONFIG::useClientKey){
				URLRequestDefaults.manageCookies = false;
				URLRequestDefaults.useCache = false;
				URLRequestDefaults.cacheResponse = false;				
			}*/
						
		}  		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		/**
		 * Request as a string for debugging
		 */
		override public function toString():String {
			return '[HTTPRequest] (' + _urlRequest.url + ') ';
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		/**
		 * The urlRequest we are wrapping
		 */
		public function get urlRequest():URLRequest {
			return _urlRequest;
		}
		
		public function set urlRequest(urlRequest:URLRequest):void {
			_urlRequest = urlRequest;
		}
		
		/**
		 * The latest HTTP Status code (ex: 404, 500, etc.)
		 */
		public function get httpStatus():int {
			return _httpStatus;
		}
		
		public function get urlLoader():URLLoader{
			return _urlLoader;
		}
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		/**
		 * Creates the URLLoader, starts listening to URLLoader events, and loads the URLRequest
		 */
		override protected function _initRequest():void {
			_urlLoader = new URLLoader();
			_urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			_addLoaderEventListeners(_urlLoader);
			_urlLoader.load(_urlRequest); 	
			
			/*if(CONFIG::useDebugger){				
				MonsterDebugger.trace("Request " + _urlRequest.url,_urlRequest.data);
			}*/
		}
		
		/**
		 * closes the URLLoader and stops listening to URLLoader events
		 */
		override protected function _killRequest():void {                        
			if(_urlLoader==null){
				return;
			}
			_removeLoaderEventListeners(_urlLoader);
			try {
				_urlLoader.close();
			} catch (error:Error) {
			}       
		}
		
		protected function _addLoaderEventListeners(target:IEventDispatcher) : void {
			target.addEventListener(ProgressEvent.PROGRESS, _handleProgressEvent);
			target.addEventListener(IOErrorEvent.IO_ERROR, _handleIOError);
			target.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _handleSecurityError);   
			target.addEventListener(Event.COMPLETE, _handleCompleteEvent);    
			target.addEventListener(HTTPStatusEvent.HTTP_STATUS, _handleHttpStatusEvent);
		}
		
		protected function _removeLoaderEventListeners(target:IEventDispatcher ) : void {
			target.removeEventListener(ProgressEvent.PROGRESS, _handleProgressEvent);
			target.removeEventListener(IOErrorEvent.IO_ERROR, _handleIOError);
			target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _handleSecurityError);   
			target.removeEventListener(Event.COMPLETE, _handleCompleteEvent);    
			target.removeEventListener(HTTPStatusEvent.HTTP_STATUS, _handleHttpStatusEvent); 
		}
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		protected function _handleIOError(event:IOErrorEvent):void {
			/*if(CONFIG::useDebugger){
				MonsterDebugger.trace("IOError " + _urlRequest.url,event.target,"","",0xff0000);				
			}*/
			
			var pCanTryAgain:Boolean = _tryAgain(); 
			if(!pCanTryAgain){
				_errorHandle();
				dispatchEvent(event);
			}
		}
		
		
		protected function _handleSecurityError(event:SecurityErrorEvent):void {
			/*if(CONFIG::useDebugger){				
				MonsterDebugger.trace("SecurityError " + _urlRequest.url,event.target,"","",0xff0000);		
			}*/
			var pCanTryAgain:Boolean = _tryAgain(); 
			if(!pCanTryAgain){
				_errorHandle();
				dispatchEvent(event);
			}
		}   
		
		
		protected function _handleProgressEvent(event:ProgressEvent):void{
			//dispatchEvent(event);
		}
		
		private function _handleHttpStatusEvent(event:HTTPStatusEvent):void {
			_httpStatus = event.status;
			//dispatchEvent(event);
		}
		
		
		protected function _handleCompleteEvent(event:Event):void {
		    /*if(CONFIG::useDebugger){
				//MonsterDebugger.trace(this,event.target.data);
				MonsterDebugger.trace("Response " + _urlRequest.url,event.target.data);
			}*/
			_finishCompletedRequest(event.target.data);
		}
		
	}
}
