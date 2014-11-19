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
		private var _damageMax:Number=1000;
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
/*		public function blockCreate(pWidth:Number,pHeight:Number,pMaterial:String="wood"):void{
			_width=pWidth;
			_height=pHeight;			
			
			body = new Body(BodyType.DYNAMIC, new Vec2(0,0));		
			if(pMaterial=="wood"){
				material=new Material(0,2,2,10);
				if(pHeight==pWidth){
					skin=new BoxSkin();
				}else{					
					skin=new PlankSkin();
					if(pWidth>pHeight){
						skin.rotation=180;
					}
				}
			}else{
				_damageMax=2500;
				material=new Material(0,1.5,2,15);
				if(pHeight==pWidth){
					skin=new StoneSkin();
				}else{
					skin=new StonePlankSkin();
					if(pWidth>pHeight){
						skin.rotation=180;
					}
				}
			}
			
			shape=new Polygon(Polygon.box(pWidth,pHeight),material);
			body.shapes.add(shape);		
			body.userData.damage=setDamage;
			
			//skin=_skinCreate();
			skin.width=pWidth;
			skin.height=pHeight;
			body.userData.sprite=skin;			
			body.userData.sprite.x=body.position.x
			body.userData.sprite.y=body.position.y
			body.userData.sprite.rotation=body.rotation*57.2957795;
			addChild(skin);
			
		}*/
		public function createObject(pVOBlock:VOBlockData):void{			
			_damageMax=pVOBlock.health;
			
			body = new Body(BodyType.DYNAMIC, new Vec2(pVOBlock.position.x,pVOBlock.position.y));
			material=new Material(0,pVOBlock.friction,2,pVOBlock.density);
			shape=new Polygon(Polygon.box(pVOBlock.width,pVOBlock.height),material);
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
			skin.width=pVOBlock.width;
			skin.height=pVOBlock.height;
			body.userData.sprite=skin;			
			body.userData.sprite.x=body.position.x
			body.userData.sprite.y=body.position.y
			body.userData.sprite.rotation=body.rotation*57.2957795;
			addChild(skin);
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
			dispatchEvent(new EventViewBlocks(EventViewBlocks.REMOVE_BLOCK));
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