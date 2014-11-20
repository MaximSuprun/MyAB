package com.project.view.abstract{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import nape.callbacks.CbType;
	import nape.geom.Vec2;
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
		
		protected function set startPoint(pPoint:Point):void{
			if (pPoint.x==body.position.x&&pPoint.y==body.position.y)return;
			body.position=new Vec2(pPoint.x,pPoint.y)			
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		protected function skinSetUP():void{
			
			body.userData.skin=skin;			
			body.userData.skin.x=body.position.x;
			body.userData.skin.y=body.position.y;
			body.userData.skin.rotation=body.rotation*57.2957795;
			addChild(skin);	
		}
		
		protected function clear():void{
			body.space=null;
			
			if(skin is Sprite){
				Sprite(skin).graphics.clear();
			}
			skin=null;
		}
		
		
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