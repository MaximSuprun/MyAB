package com.razzmatazz.robotlegs.model.modelLoading {
	
	import flash.events.Event;
	
	
	public class EventActorLoader extends Event {

		
		public static var LOADING_STARTED:String = "LOADING_STARTED";
		public static var LOADING_FINISHED:String = "LOADING_FINISHED";
		
		
		private var _payload:VOLoading;
		public function get payload():VOLoading{
			return _payload; 
		}
		
		
		public function EventActorLoader(type:String, pPayload:VOLoading=null){
			super(type);
			this._payload = pPayload;
		}
		
		override public function clone():Event {
			return new EventActorLoader(type, _payload);
		}
	}
}