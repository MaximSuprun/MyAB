package com.angryBirdsGame.model.vo{
	import flash.geom.Point;
	import flash.net.drm.AddToDeviceGroupSetting;
	
	import nape.space.Space;
	
	public class VOAbstract{
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
		private var _friction:Number;
		private var _density:Number;
		private var _health:Number;
		private var _position:Point;
		private var _type:String;
		private var _space:Space;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function VOAbstract()
		{
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

		public function get health():Number{return _health;}
		public function set health(value:Number):void{
			_health = value;
		}

		public function get position():Point{	return _position;}		
		public function set position(value:Point):void{
			_position = value;
		}
		
		public function get density():Number{return _density;}		
		public function set density(value:Number):void{
			_density = value;
		}		
		
		public function get friction():Number{return _friction;}		
		public function set friction(value:Number):void{
			_friction = value;
		}

		public function get space():Space{return _space;}
		public function set space(value:Space):void{
			_space = value;
		}
		
		public function set type(pType:String):void{_type=pType;}
		public function get type():String{
			return _type;
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