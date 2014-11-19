package com.project.view.bird{
	
	import com.project.common.Constants;
	import com.project.view.abstract.ViewAbstract;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	
	public class ViewBird extends ViewAbstract{
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

		private var _birdSize:Number=15;		
		private var _startX:Number = 0;
		private var _startY:Number = 0;
		private var _gravMass:Number=0;
		private var _isActiveBird:Boolean=false;
		private var _isFlying:Boolean=false;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function ViewBird(){
			_actorCreateBody();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function set startPoint(pPoint:Point):void{
			if (pPoint.x==body.position.x&&pPoint.y==body.position.y)return;
			body.position=new Vec2(pPoint.x,pPoint.y)
			_startX=pPoint.x;
			_startY=pPoint.y;
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
		private function _actorCreateBody():void{			
			body=new Body(BodyType.DYNAMIC);
			body.position.set(new Vec2(0, 0));		
			
			material=new Material(0,5,2,10);
			shape=new Circle(_birdSize,null,material);			
			body.shapes.add(shape);			

			skin = new BirdSkin();	
			skin.width=_birdSize*2;
			skin.height=_birdSize*2;
			body.userData.sprite=skin;			
			body.userData.sprite.x=body.position.x;
			body.userData.sprite.y=body.position.y;
			body.userData.sprite.rotation=body.rotation*57.2957795;
			addChild(skin);	
			
			_gravMassUpdate();
			
			addEventListener(Event.ENTER_FRAME,_handlerUpdate);
			addEventListener(MouseEvent.MOUSE_DOWN,_handlerBirdMoveStart);
		}
		
		private function _skinCreate():DisplayObject{
			var pSprite:Sprite=new Sprite();
			
			pSprite.graphics.beginFill(0xff0000);
			pSprite.graphics.drawCircle(0,0,_birdSize);
			pSprite.graphics.endFill();
			pSprite.graphics.beginFill(0xffffff);
			pSprite.graphics.drawCircle(-7.5,4,5);
			pSprite.graphics.drawCircle(7.5,4,5);
			pSprite.graphics.endFill();
			
			return pSprite;
		}
		
		private function _gravMassUpdate():void{
			if(_gravMass==0){_gravMass=body.gravMass;}			
			body.gravMass!=0 ? body.gravMass=0 : body.gravMass=_gravMass;
			
		}
		
		private function _birdMove():void{
			var mouse:Point = new Point(stage.mouseX,stage.mouseY);			
			var pDistanceX: Number = _startX - mouse.x;
			var pDistanceY: Number = _startY - mouse.y;
			var pCubeAngle: Number = Math.atan2(pDistanceY, pDistanceX); 
			var pDistance:Number=Math.sqrt(pDistanceX*pDistanceX+pDistanceY*pDistanceY);
			
			body.rotation=pCubeAngle;
			
			if (pDistance> Constants.MAX_BIRD_DISTANCE) {
				pCubeAngle= Math.atan2(pDistanceY, pDistanceX); 
				body.position.x = _startX - Constants.MAX_BIRD_DISTANCE * Math.cos(pCubeAngle);
				body.position.y = _startY - Constants.MAX_BIRD_DISTANCE * Math.sin(pCubeAngle);
			} else {
				body.position.x = mouse.x;
				body.position.y = mouse.y;
			}
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerBirdMoveStart(event:MouseEvent):void{
	    stage.addEventListener(MouseEvent.MOUSE_MOVE,_handlerMove);
		stage.addEventListener(MouseEvent.MOUSE_UP,_handlerStartFly);
		removeEventListener(MouseEvent.MOUSE_DOWN,_handlerBirdMoveStart);			
		}
		
		private function _handlerMove(event:MouseEvent=null):void{
			_isActiveBird=true;			
		}
		
		private function _handlerUpdate(event:Event):void{
			if(_isActiveBird){
				_birdMove();
			}
			if(_isFlying){
				body.gravMass+=0.5;
				if(body.velocity.x>-.1&&body.velocity.x<.1 && body.velocity.y>-.1&&body.velocity.y<.1){
					body.gravMass=0;
					_gravMassUpdate();
					_isFlying=false;
				}
			}
		}
		
		private function _handlerStartFly(event:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,_handlerMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP,_handlerStartFly);
			_isActiveBird=false;
			_isFlying=true;
			
			_gravMassUpdate()
				
			var pDistanceX:Number=body.position.x-_startX;
			var pDistanceY:Number=body.position.y-_startY;
			var pDistance:Number=Math.sqrt(pDistanceX*pDistanceX+pDistanceY*pDistanceY);
			var pCubeAngle:Number=Math.atan2(pDistanceY,pDistanceX);			
			var pPowerX:Number =  -pDistance*Math.cos(pCubeAngle)*(Constants.GRAVITY*.45);
			var pPowerY:Number =  -pDistance*Math.sin(pCubeAngle)*(Constants.GRAVITY*.45);
			
		
			body.applyImpulse( new Vec2(pPowerX,pPowerY));		
		}
		
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