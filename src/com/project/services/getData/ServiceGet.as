package com.project.services.getData{
	
	import com.razzmatazz.net.EventNetwork;
	import com.razzmatazz.net.HTTPRequest;
	import com.razzmatazz.robotlegs.model.modelLoading.EventActorLoader;
	import com.razzmatazz.robotlegs.services.serviceHTTPAbstract.ServiceHTTPAbstract;
	import com.razzmatazz.valueObjects.error.VOError;
	
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	public class ServiceGet extends ServiceHTTPAbstract implements IServiceGet{						
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		private var _dataResult:VOResponseGet;
		private var _dataRequest:VORequestGet;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ServiceGet(){
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function load(pData:VORequestGet):void {
			_dataRequest = pData;
			_dataResult = new VOResponseGet();
			_killRequest();
			_initRequest();
		}		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		override protected function _loadStartedHandler():void {			
			dispatch(new EventActorLoader(EventActorLoader.LOADING_STARTED));
		}
		
		override protected function _initRequest():void{
			_loadStartedHandler();
			
			//_requestURL = Constants.URL_GET_IMAGE_PARAMS;
			
			_urlRequest = new URLRequest(_requestURL);
			_urlRequest.method = URLRequestMethod.POST;
			
			
			var pDataRequest:URLVariables = new URLVariables();
			pDataRequest.request = JSON.stringify(_dataRequest); 
			
			_urlRequest.data = pDataRequest;
			
			_httpRequest = new HTTPRequest(_urlRequest);
			_addLoaderEventListeners(_httpRequest);
			_httpRequest.load();
			
		}
		
		/**
		 * overriding to handle 3 variants of response instead of two basic
		 * 
		 */
		override protected function _completeEventHandler(event:EventNetwork):void {			
			
			event.stopImmediatePropagation();
			try{
				_result = _httpRequest.result;
				_parseResponse();
				if(_serviceResponseIsValid) {
					_successEventHandler();
				} else {
					_errorHandler();
				}
			} catch(error:Error) {
				_errorHandler();
			}
		}
		
		
		override protected function _parseResponse():void{
			try{
				var pResponseJSON:Object = JSON.parse(_result.toString());
				var pStatus:String = pResponseJSON.status;
				
				// Validation
				if(pStatus == "SUCCESS"){
					_serviceResponseIsValid = true;
					
					try{
						/*var pFilm:Vector.<VOFilm> = new Vector.<VOFilm>();
						
						for(var i:int=0;i<pResponseJSON.results.length; i++){
							var pDataTrending:VOFilm = new VOFilm();
							pDataTrending.parseData(pResponseJSON.results[i]);
							pDataTrending.isGenre = "1";
							pFilm.push(pDataTrending);
						}		
						
						
						_dataResult.filmArr = pFilm;*/						
					} catch (error:Error){
						
					}
					
				} else {
					_serviceResponseIsValid = false;
				}			
				
			} catch (error:Error){
				_serviceResponseIsValid = false;
			}
		}		
		
		override protected function _successEventHandler():void {			
			
			_loadCompletedHandler();
			
			// Sending data to be stored in the Model
			dispatch(new EventServiceGet(EventServiceGet.RESULT, _dataResult));
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		override protected function _errorHandler(pEvent:*=null):void {
			
			//////////////////////////////////////////////////////
			//    you can optimize for yourself incoming errors //
			//////////////////////////////////////////////////////
			
			/*var pErrorCode:String="";
			var pErrorDescription:String="";
			
			if(_result){
				var pResponseJSON:Object = JSON.parse(_result.toString());
				pErrorCode = pResponseJSON.code;
				pErrorDescription = Utils.cutBr(pResponseJSON.message);
			}
			var pError:VOError = new VOError();
			
			if(pErrorDescription && pErrorDescription.length > 0){
				pError.errorDescription = pErrorDescription;
			} else {
				pError.errorDescription = MessageKey.ERROR_SERVICE__GENRE;
			}			
			
			if(pErrorCode && pErrorCode.length > 0){
				pError.errorDescription = pErrorCode;
			}
			
			pError.isCritical = false;
			pError.debugObject = this;  
			_errorSend(pError);*/
			
			_loadCompletedHandler();
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