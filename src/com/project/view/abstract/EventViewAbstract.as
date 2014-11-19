package com.project.view.abstract{
	import flash.events.Event;
	
	public class EventViewAbstract extends Event{
		
		public static var SET_DATA:String = "SET_DATA";
		
		
		
		private var _payload:Object;
		public function get payload():Object {
			return _payload;
		}
		
		
		private var _functionCallback:Function;
		public function get functionCallback():Function {
			return _functionCallback;
		}	
		
		
		public function EventViewAbstract(type:String, pPayload:Object=null,pFunctionCallback:Function = null) {
			super(type);
			this._payload = pPayload;
			this._functionCallback = pFunctionCallback;
		}
		
		override public function clone():Event {
			return new EventViewAbstract(type, _payload,_functionCallback);
		}
		
	}
}