package com.project.view.pig{
	
	import com.project.view.abstract.ViewAbstract;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	
	public class ViewPig extends ViewAbstract{
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
		private var _damage:Number;
		private var _damageMax:Number=500;
		private var _pigRadius:Number;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function ViewPig()
		{
			super();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function set radius(pRadius:Number):void{
			if(pRadius&&_pigRadius!=pRadius){
				_pigRadius=pRadius;
			}
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		public function pigCreate(pSize:Number):void{
			_pigRadius=pSize;
			
		
			
			body = new Body(BodyType.DYNAMIC, new Vec2(0,0));
			
			material=new Material(0,2,2,10);
			shape=new Circle(_pigRadius,null,material);
			body.shapes.add(shape);
			
			skin=new PigSkin();
			skin.width=_pigRadius*2;
			skin.height=_pigRadius*2;
			body.userData.sprite=skin;			
			body.userData.sprite.x=body.position.x
			body.userData.sprite.y=body.position.y
			body.userData.sprite.rotation=body.rotation*57.2957795;
			addChild(skin);
			
			body.userData.damage=setDamage;
			
		}
		
		private function setDamage(pDamage:Number):void{
			_damageMax-=pDamage;
			if(_damageMax<=0){
				_clear();				
			}
		}
		
		
		private function _clear():void{
			body.space=null;
			
			if(skin is Sprite){
				Sprite(skin).graphics.clear();
			}
			skin=null;
			dispatchEvent(new EventViewPig(EventViewPig.REMOVE_PIG));
		}
		
		private function _skinCreate():DisplayObject{
			var pSprite:Sprite=new Sprite();
			pSprite.graphics.beginFill(0x00ff00);
			pSprite.graphics.drawCircle(0,0,_pigRadius);
			pSprite.graphics.endFill();
			return pSprite;
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