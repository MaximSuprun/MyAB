package com.project.model{
	import flash.events.Event;

	public class EventModel extends Event {
		
		public static const MAP_LOADED:String = "MAP_LOADED";
		//public static const SET_:String = "SET_";
		
		
		
		private var _payload:Object;
		public function get payload():Object {
			return _payload;
		}
		
		public function EventModel(type:String, pPayload:Object=null) {
			super(type);
			this._payload = pPayload;
		}
		
		override public function clone():Event {
			return new EventModel(type, _payload);
		}
	}
}