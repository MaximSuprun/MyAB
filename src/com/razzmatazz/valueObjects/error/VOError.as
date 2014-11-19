package com.razzmatazz.valueObjects.error {
	
	
	public class VOError {
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
		private var _errorCode:String = "";
		private var _errorDescription:String = "";
		private var _isCritical:Boolean = true;
		private var _debugObject:*;
		private var _id:String = "";				
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function VOError() {
			super();
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
		public function get errorCode():String {
			return _errorCode;
		}
		public function set errorCode(value:String):void {
			_errorCode = value;
		}				
		
		public function get errorDescription():String {
			return _errorDescription;
		}
		public function set errorDescription(value:String):void {
			if(value == "500" || value == "400" || value == "internal server error" || value == "200"){
				_errorDescription = "unable to complete the operation due to connectivity issue with myplex servers. please try again later. if the problem persists, please reach out to support@myplex.com"
			}else{
				_errorDescription = value;
			}
		}

		
		public function get isCritical():Boolean {
			return _isCritical;
		}
		public function set isCritical(value:Boolean):void {
			_isCritical = value;
		}

		
		public function get debugObject():* {
			return _debugObject;
		}
		public function set debugObject(value:*):void {
			_debugObject = value;
		}

		
		public function get id():String {
			return _id;
		}
		public function set id(value:String):void {
			_id = value;
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