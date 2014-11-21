package com.project.view.block{
	
	import com.project.model.vo.VOBlockData;
	import com.project.view.abstract.ViewAbstract;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Polygon;
	
	public class ViewBlock extends ViewAbstract{
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
		private var _health:Number=1000;
		private var _height:Number;
		private var _width:Number;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function ViewBlock()
		{
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
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		public function createObject(pVOBlock:VOBlockData):void{			
			_health=pVOBlock.health;
			
			
			material=new Material(0,pVOBlock.friction,2,pVOBlock.density);			
			shape=new Polygon(Polygon.box(pVOBlock.width,pVOBlock.height),material);
			
			body = new Body(BodyType.DYNAMIC);
			startPoint=pVOBlock.position;
			body.shapes.add(shape);		
			body.userData.damage=setDamage;
			
			switch (pVOBlock.skin){
				case VOBlockData.STONE:
					skin=new StoneSkin();
					break;
				case VOBlockData.STONE_PLANK:
					skin=new StonePlankSkin();				
					break;
				case VOBlockData.WOOD:
					skin=new BoxSkin();								
					break;
				case VOBlockData.WOOD_PLANK:
					skin=new PlankSkin();														
					break;
			}	
			
			if (pVOBlock.width>pVOBlock.height){
				skin.rotation=180;
			}
			
			skin.width=pVOBlock.width/2;
			skin.height=pVOBlock.height/2;
			skinSetUP();
			addChild(skin);
			
			body.space=pVOBlock.space;
		}

		private function setDamage(pDamage:Number):void{
			_health-=pDamage;
			if(_health<=0){
				clear();	
				dispatchEvent(new EventViewBlocks(EventViewBlocks.REMOVE_BLOCK));
			}
		}
		
		private function _skinCreate():DisplayObject{
			var pSprite:Sprite=new Sprite();
			pSprite.graphics.beginFill(Math.random()*(0xffffff));
			pSprite.graphics.drawRect(-_width/2,-_height/2,_width,_height);
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