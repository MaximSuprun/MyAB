package com.project.view.main{
	import com.project.model.EventModel;
	import com.project.view.abstract.MediatorViewAbstract;
	
	public class MediatorViewMain extends MediatorViewAbstract{
		
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
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function MediatorViewMain(){
			super();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		override public function onRegister():void {
			super.onRegister();
			addContextListener(EventModel.MAP_LOADED,_handlerDataLoaded);
			addContextListener(EventModel.PIGS_LOADED,_handlerDataLoaded);
			addContextListener(EventModel.BIRDS_LOADED,_handlerDataLoaded);
			dispatch(new EventViewMain(EventViewMain.LOAD_MAP_DATA));
			
		}
		
		
		override public function onRemove():void {
			super.onRemove();
			removeContextListener(EventModel.MAP_LOADED,_handlerDataLoaded);
			removeContextListener(EventModel.PIGS_LOADED,_handlerDataLoaded);
			removeContextListener(EventModel.BIRDS_LOADED,_handlerDataLoaded);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		
		private function get _view():ViewMain {
			return ViewMain(viewComponent); 
		}
		
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
		private function _handlerDataLoaded(event:EventModel):void{
			switch(event.type){
				case EventModel.MAP_LOADED:
					_view.mapCreate(event.payload as Array);
					break;
				case EventModel.PIGS_LOADED:
					_view.pigsCreate(event.payload as Array);
					break;
				case EventModel.BIRDS_LOADED:
					_view.birdsCreate(event.payload as Array);
					break;
			}
			
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