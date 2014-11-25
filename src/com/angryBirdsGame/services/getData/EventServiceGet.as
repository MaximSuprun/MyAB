package com.angryBirdsGame.services.getData{
	import flash.events.Event;
	
	public class EventServiceGet extends Event{
		
		public static var RESULT:String = "RESULT";
		
		private var _payload:Object; 
		public function get payload():Object{
			return _payload;
		}
		
		public function EventServiceGet(type:String, pPayload:Object){
			super(type, false, false);
			this._payload = pPayload;
		}
	}
}