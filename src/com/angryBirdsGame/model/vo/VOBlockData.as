package com.angryBirdsGame.model.vo{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import nape.space.Space;
	
	public class VOBlockData  extends VOAbstract{
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------
		public static const WOOD:String="WOOD";
		public static const STONE:String="STONE";
		public static const WOOD_PLANK:String="WOOD_PLANK";
		public static const STONE_PLANK:String="STONE_PLANK";
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		private var _width:Number;
		private var _height:Number;
		private var _skin:String="";
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function VOBlockData(){
			
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
		public function get width():Number{return _width;}
		public function set width(value:Number):void{
			_width = value;
		}
		
		public function get height():Number{return _height;}
		public function set height(value:Number):void{
			_height = value;
		}
		
		public function get skin():String{return _skin;}
		public function set skin(value:String):void{
			switch (value){
				case "stone":
					_skin=STONE;
					break;
				case "stone_plank":
					_skin=STONE_PLANK;					
					break;
				case "wood":
					_skin=WOOD;										
					break;
				case "wood_plank":
					_skin=WOOD_PLANK;															
					break;
			}			
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