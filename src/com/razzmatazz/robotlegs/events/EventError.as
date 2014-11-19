package com.razzmatazz.robotlegs.events {
	
	import com.razzmatazz.valueObjects.error.VOError;
	
	import flash.events.Event;
	
	public class EventError extends Event {

		
		public static var ERROR:String = "ERROR";
		
		
		private var _data:VOError;
		public function get data():VOError {
			return _data;
		}
		
		
		public function EventError(type:String, bubbles:Boolean=false, cancelable:Boolean=false, pArgument:VOError=null){
			super(type, bubbles, cancelable);
			_data = pArgument;
		}
		
		override public function clone():Event {
			return new EventError(type, bubbles, cancelable, _data);
		}
	}
}