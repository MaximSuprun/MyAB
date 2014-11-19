/**
 * Debug messages interaction object
 * 
 * 
 * 
 */ 
package com.razzmatazz.valueObjects.log {
	
	public class VOLogMessage {
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
		private var _caller:*;
		private var _object:*; 
		private var _person:String = ""; 
		private var _label:String = ""; 
		private var _color:uint = 0x000000; 
		private var _depth:int = 5; 


		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function VOLogMessage(pCaller:*, pLabel:String, pObject:*, pPerson:String="", pColor:uint=0x000000, pDepth:int=5) {
			this._caller = pCaller;
			this._object = pObject;
			this._person = pPerson;
			this._label = pLabel;
			this._color = pColor;
			this._depth = pDepth;
			
		}


		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------


		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function get caller():*{
			return _caller;
		}
		public function set caller(value:*):void{
			_caller = value;
		}
		
		
		public function get object():* {
			return _object;
		}
		public function set object(value:*):void{
			_object = value;
		}
		
		
		public function get person():String {
			return _person;
		}
		public function set person(value:String):void{
			_person = value;
		}
		
		
		public function get label():String {
			return _label;
		}
		public function set label(value:String):void {
			_label = value;
		}

		
		
		public function get color():uint {
			return _color;
		}
		public function set color(value:uint):void{
			_color = value;
		}

		
		
		public function get depth():int {
			return _depth;
		}
		public function set depth(value:int):void{
			_depth = value;
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