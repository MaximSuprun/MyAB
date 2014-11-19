package com.razzmatazz.robotlegs.services.serviceHTTPAbstract {

	import com.razzmatazz.net.EventNetwork;
	import com.razzmatazz.net.HTTPRequest;
	import com.razzmatazz.robotlegs.services.ServiceAbstract;
	import com.razzmatazz.service.EventService;
	import com.razzmatazz.valueObjects.log.VOLogMessage;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	//import mx.logging.ILogger;
	//import mx.logging.Log;
	
	public class ServiceHTTPAbstract extends ServiceAbstract {
		//--------------------------------------------------------------------щ------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------

		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		protected var _serviceURL:String = "";
		
		protected var _requestURL:String = "";
		protected var _urlRequest:URLRequest;
		protected var _httpRequest:HTTPRequest;
		
		protected var _result:Object;		
		
		//protected var _logger:ILogger = Log.getLogger("_logApp");
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ServiceHTTPAbstract() {
			
		}
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		

		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		/**
		 * The urlRequest we are wrapping
		 */
		public function get urlRequest():URLRequest {
			return _httpRequest.urlRequest;
		}
		
		/**
		 * The latest HTTP Status code (ex: 404, 500, etc.)
		 */
		public function get httpStatus():int {
			return _httpRequest.httpStatus;
		}	
		
		public function get requestURL():String {
			return _requestURL;
		}

		public function get result():Object{
			return _result;
		}

		public function get serviceResponseIsValid():Boolean{
			return _serviceResponseIsValid;
		}
		
		

		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		/**
		 * Starts listening to load events and start the loading process
		 */
		protected function _getRequestURL():String {
			throw new Error('_getRequestURL() must be implemented in a subclass');
		}
		
		protected function _initRequest():void{
			_loadStartedHandler();
			_requestURL = _getRequestURL();
			_urlRequest = new URLRequest(_requestURL);
			_urlRequest.method = URLRequestMethod.GET;
			_httpRequest = new HTTPRequest(_urlRequest);
			_addLoaderEventListeners(_httpRequest);
			_httpRequest.load();			
		}
		
		protected function _killRequest():void{
			if (_httpRequest){
				_removeLoaderEventListeners(_httpRequest);
				_httpRequest.cancel();
			}
		}
		
		protected function _addLoaderEventListeners(target:IEventDispatcher) : void {
			target.addEventListener(ProgressEvent.PROGRESS, _progressEventHandler);
			target.addEventListener(IOErrorEvent.IO_ERROR, _IOErrorHandler);
			target.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _securityErrorHandler);   
			target.addEventListener(EventNetwork.REQUEST_COMPLETE, _completeEventHandler);    
			target.addEventListener(HTTPStatusEvent.HTTP_STATUS, _httpStatusEventHandler);
			//target.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, _httpResponseStatusEventHandler);
		}
		
		protected function _removeLoaderEventListeners(target:IEventDispatcher ) : void {
			target.removeEventListener(ProgressEvent.PROGRESS, _progressEventHandler);
			target.removeEventListener(IOErrorEvent.IO_ERROR, _IOErrorHandler);
			target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _securityErrorHandler);   
			target.removeEventListener(Event.COMPLETE, _completeEventHandler);    
			target.removeEventListener(HTTPStatusEvent.HTTP_STATUS, _httpStatusEventHandler); 
			//target.removeEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, _httpResponseStatusEventHandler); 
		}
		
		protected function _parseResponse():void{
			throw new Error('_parseResponse() must be implemented in a subclass');
		}
		
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS
		// 
		//---------------------------------------------------------------------------------------------------------
		protected function _IOErrorHandler(event:IOErrorEvent):void {
			//_logger.error("_IOErrorHandler "+event.text);
			
			var pDebug:VOLogMessage = new VOLogMessage(this, "_IOErrorHandler", event);
			_logSend(pDebug);					
			
			_errorHandler(event);
			event.stopImmediatePropagation();
		}
		
		
		protected function _securityErrorHandler(event:SecurityErrorEvent):void {
			//_logger.error("SecurityErrorEvent "+event.text);
			
			var pDebug:VOLogMessage = new VOLogMessage(this, "_securityErrorHandler", event);
			_logSend(pDebug);
			
			_errorHandler(event);
			event.stopImmediatePropagation();
		}   
		
		
		protected function _progressEventHandler(event:ProgressEvent):void{
			event.stopImmediatePropagation();
		}
		
		protected function _httpStatusEventHandler(event:HTTPStatusEvent):void {
			//_logger.error("_httpStatusEventHandler "+event.status);
			
			var pDebug:VOLogMessage = new VOLogMessage(this, "_httpStatusEventHandler", event);
			_logSend(pDebug);
			
			event.stopImmediatePropagation();
			_handleStatusEvent(event);
		}
		
		protected function _httpResponseStatusEventHandler(event:HTTPStatusEvent):void {
			//_logger.error("_httpStatusEventHandler "+event.status);
			
			var pDebug:VOLogMessage = new VOLogMessage(this, "_httpResponseStatusEventHandler", event);
			_logSend(pDebug);
			
			event.stopImmediatePropagation();
			_handleStatusEvent(event);
		}
		
		

		protected function _completeEventHandler(event:EventNetwork):void {						
			
			var pDebug:VOLogMessage = new VOLogMessage(this, "_httpStatusEventHandler", event);
			_logSend(pDebug);
			
			event.stopImmediatePropagation();
			try{
				_result = _httpRequest.result;
				_parseResponse();
				_serviceResponseIsValid = true;
			}catch(error:Error){
				_serviceResponseIsValid = false;
			}
			
			if (!_serviceResponseIsValid){
				_errorHandler();
			}
		}
		
		protected function _successEventHandler():void {
			throw new Error('_successEventHandler() must be implemented in a subclass');
		}
		
		protected function _handleStatusEvent(event:HTTPStatusEvent):void {
			dispatch(new EventService(EventService.STATUS, false, false));
		}

		override protected function _errorHandler(pEvent:* = null):void{
			_loadCompletedHandler();			
			
			dispatch(new EventService(EventService.ERROR, false, false, pEvent));
		}				
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  HELPERS  
		// 
		//---------------------------------------------------------------------------------------------------------
			
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//---------------------------------------------------------------------------------------------------------
			
	}
}