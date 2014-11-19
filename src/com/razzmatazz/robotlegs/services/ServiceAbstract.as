package com.razzmatazz.robotlegs.services {

	import com.razzmatazz.robotlegs.events.EventError;
	import com.razzmatazz.robotlegs.model.modelLoading.EventActorLoader;
	import com.razzmatazz.robotlegs.model.modelLoading.VOLoading;
	import com.razzmatazz.service.EventService;
	import com.razzmatazz.utils.logger.EventLogger;
	import com.razzmatazz.valueObjects.error.VOError;
	import com.razzmatazz.valueObjects.log.VOLogMessage;
	
	import org.robotlegs.mvcs.Actor;
	
	public class ServiceAbstract extends Actor {
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
		protected var _serviceResponseIsValid:Boolean = false;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ServiceAbstract() {
			
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
		

		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		protected function _loadStartedHandler():void {
			var pData:VOLoading = new VOLoading(this, VOLoading.STATUS__START);
			dispatch(new EventActorLoader(EventActorLoader.LOADING_STARTED, pData));
		}
		
		
		protected function _loadCompletedHandler():void {
			var pData:VOLoading = new VOLoading(this, VOLoading.STATUS__FINISH);
			dispatch(new EventActorLoader(EventActorLoader.LOADING_FINISHED, pData));
		}
		

		protected function _errorSend(pError:VOError):void{
			var pDebug:VOLogMessage = new VOLogMessage(this, "SERVICE ERROR: ", pError);
			_logSend(pDebug);
			
			dispatch(new EventError(EventError.ERROR, false, false, pError));
		}

		
		protected function _logSend(pMessage:VOLogMessage):void {							
			dispatch(new EventLogger(EventLogger.MESSAGE, pMessage));
		}
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS
		// 
		//---------------------------------------------------------------------------------------------------------
		protected function _errorHandler(pEvent:*=null):void {
			dispatch(new EventService(EventService.ERROR, false, false,pEvent));
		}
		
		protected function _successHandler():void{
			dispatch(new EventService(EventService.SUCCESS, false, false));
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