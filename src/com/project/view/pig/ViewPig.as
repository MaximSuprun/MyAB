package com.project.view.pig{
	
	import com.project.model.vo.VOPigData;
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
		private var _health:Number=0;
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
		public function pigBodyCreate(pVOPig:VOPigData):void{
			_pigRadius=pVOPig.radius;	
			_health=pVOPig.health;
			
			material=new Material(0,pVOPig.friction,2,pVOPig.density);
			
			shape=new Circle(_pigRadius,null,material);
			
			body = new Body(BodyType.DYNAMIC);
			startPoint=pVOPig.position;
			body.shapes.add(shape);
			
			skin=new PigSkin();
			skin.width=_pigRadius*2;
			skin.height=_pigRadius*2;
			skinSetUP();
			addChild(skin);
			body.space=pVOPig.space;
			body.userData.damage=setDamage;
			
		}
		
		private function setDamage(pDamage:Number):void{
			_health-=pDamage;
			if(_health<=0){
				clear();				
				dispatchEvent(new EventViewPig(EventViewPig.REMOVE_PIG));
			}
		}
		
		
		/*private function _skinCreate():DisplayObject{
			var pSprite:Sprite=new Sprite();
			pSprite.graphics.beginFill(0x00ff00);
			pSprite.graphics.drawCircle(0,0,_pigRadius);
			pSprite.graphics.endFill();
			return pSprite;
		}*/
		
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