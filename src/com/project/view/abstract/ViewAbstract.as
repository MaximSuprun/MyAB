package com.project.view.abstract{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import nape.callbacks.CbType;
	import nape.phys.Body;
	import nape.phys.Material;
	import nape.shape.Shape;
	import nape.space.Space;
	
	public class ViewAbstract extends Sprite{
		
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
		private var _body:Body;
		private var _shape:Shape;
		private var _skin:DisplayObject;
		private var _material:Material;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function ViewAbstract(){
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

		public function get material():Material{return _material;}
		public function set material(pMaterial:Material):void{_material = pMaterial;}

		public function get skin():DisplayObject{return _skin;}
		public function set skin(pSkin:DisplayObject):void{_skin = pSkin;}

		public function get shape():Shape{return _shape;}
		public function set shape(pShape:Shape):void{_shape = pShape;}

		public function get body():Body{return _body;}
		public function set body(pBody:Body):void{_body = pBody;}
		
		
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