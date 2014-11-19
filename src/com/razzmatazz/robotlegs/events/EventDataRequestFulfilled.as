package com.razzmatazz.robotlegs.events {
	
	import flash.events.Event;
	
	
	public class EventDataRequestFulfilled extends Event {
		
		//public static var DATA_REQUEST:String = "DATA_REQUEST";
		
		
		protected var _callbackFunction:Function;
		public function get callbackFunction():Function {
			return _callbackFunction;
		}
		
		
		public function EventDataRequestFulfilled(type:String, pCallbackFunction:Function){
			super(type, false, false);
			this._callbackFunction = pCallbackFunction;
		}
		
		override public function clone():Event {
			return new EventDataRequestFulfilled(type, _callbackFunction);
		}
	}
}