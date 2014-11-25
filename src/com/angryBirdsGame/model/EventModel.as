package com.angryBirdsGame.model{
	import flash.events.Event;

	public class EventModel extends Event {
		
		public static const MAP_LOADED:String = "MAP_LOADED";
		public static const PIGS_LOADED:String = "PIGS_LOADED";
		public static const BIRDS_LOADED:String = "BIRDS_LOADED";
			
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