package com.razzmatazz.utils.logger {
	
	import com.razzmatazz.valueObjects.log.VOLogMessage;
	
	import flash.events.Event;
	
	public class EventLogger extends Event {
		
		
		public static var MESSAGE:String = "MESSAGE";
		
		
		private var _payload:VOLogMessage; 
		
		public function get payload():VOLogMessage{
			return _payload;
		}
		
		
		public function EventLogger(type:String, pPayload:VOLogMessage){
			super(type, false, false);
			this._payload = pPayload;
		}
		
		override public function clone():Event {
			return new EventLogger(type, _payload);
		}
	}
}