package com.razzmatazz.robotlegs.controller.loading {
	
	import com.razzmatazz.robotlegs.model.modelLoading.EventActorLoader;
	import com.razzmatazz.robotlegs.model.modelLoading.IModelLoading;
	import com.razzmatazz.robotlegs.model.modelLoading.VOLoading;
	
	import org.robotlegs.mvcs.StarlingCommand;
	
	
	public class CommandLoadingFinished extends StarlingCommand {
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------
		[Inject]
		public var event:EventActorLoader;
		
		[Inject]
		public var modelLoading:IModelLoading;
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function CommandLoadingFinished(){
			super();
		}
		
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function execute():void {
			var pData:VOLoading = VOLoading(event.payload);
			modelLoading.loadingFinished(pData);
		}

		
		/*
		override public function execute(notification:INotification):void {
			
			var pProxyPreloading:ProxyPreloading = ProxyPreloading(facade.retrieveProxy(ProxyPreloading.NAME));
			
			var pVOLoading:VOLoading = VOLoading(notification.getBody());
			
			trace("CursorManager.removeBusyCursor()");
			CursorManager.removeBusyCursor();
			if(CursorManager.currentCursorID == 0){
				FlexGlobals.topLevelApplication.mouseEnabled = true;
				FlexGlobals.topLevelApplication.mouseChildren = true;
			}
			
			
			pProxyPreloading.counterDecrease();
			
			trace("CommandLoadingFinished pVOLoading.caller: "+pVOLoading.caller + "   pProxyPreloading.isLoading: "+pProxyPreloading.isLoading);
			
			
			if(pProxyPreloading.isLoading == false){
				FlexGlobals.topLevelApplication.mouseEnabled = true;
				FlexGlobals.topLevelApplication.mouseChildren = true;
			}
			
			
		}
		*/
		
		
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
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		
		
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