package com.project.view.main{
	import com.project.common.Constants;
	import com.project.model.vo.VOBlockData;
	import com.project.view.abstract.EventViewAbstract;
	import com.project.view.abstract.ViewAbstract;
	import com.project.view.bird.ViewBird;
	import com.project.view.block.EventViewBlocks;
	import com.project.view.block.ViewBlock;
	import com.project.view.initNape.NapeInit;
	import com.project.view.pig.EventViewPig;
	import com.project.view.pig.ViewPig;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	import nape.callbacks.BodyListener;
	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.constraint.PivotJoint;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyList;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import nape.space.Space;

	
	public class ViewMain extends ViewAbstract{
		
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
		private var _nape2dWorld:NapeInit;
		private var _actor:ViewBird;
		private var _bird:Body;
		private var _space:Space;
		private var _gravity:Number=100;
		private var _hand:PivotJoint;
		private var _cbTypeBlock:CbType;
		private var _cbTypeActor:CbType;
		private var _cbTypePig:CbType;
		private var _cbTypeFloor:CbType;
		
		//---------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function ViewMain(){
			
			_nape2dWorld = new NapeInit(Constants.APPLICATION_WIDTH, Constants.APPLICATION_HEIGHT, Constants.APPLICATION_FRAME_RATE,10);
			addChild(_nape2dWorld);
			_space=_nape2dWorld.space;
			
			_hand=new PivotJoint(_nape2dWorld.space.world,null,Vec2.weak(),Vec2.weak());
			_hand.stiff=false;
			_hand.space=_nape2dWorld.space;
			_hand.active=false;
			_cbTypeCreate();
			_cbListenerCreate();
			
			_initialize();
			
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function mapCreate(pArrayBlokcsData:Array):void{
			var pArrayLength:int=pArrayBlokcsData.length;
			for(var i:int=0;i<pArrayLength;i++){
				//dispatchEvent(new EventViewMain(EventViewMain.NEW_BLOCK_CREATE));
				var pBlocks:ViewBlock=new ViewBlock();
				pBlocks.createObject(VOBlockData(pArrayBlokcsData[i]));
				pBlocks.body.space=_space;
				pBlocks.body.cbTypes.add(_cbTypeBlock);
				pBlocks.addEventListener(EventViewBlocks.REMOVE_BLOCK,_handlerBlocsRemove);
				addChild(pBlocks);
				trace(pBlocks.y,pBlocks.body.position.y);
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
		private function _initialize():void{
			
			_nape2dWorld.space.gravity.setxy(0, _gravity);
			
			_createWalls();
			_createActor();
			//_createBlocks();
			
			addEventListener(Event.ENTER_FRAME, _update);
		}
		
		private function _cbTypeCreate():void{
			_cbTypeBlock=new CbType();
			_cbTypeActor=new CbType();
			_cbTypePig=new CbType();
			_cbTypeFloor=new CbType();
		}
		
		private function _cbListenerCreate():void{
			var pCollisionActorBlock:InteractionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _cbTypeActor, _cbTypeBlock, _handlerCollisionActorBlock);
			_nape2dWorld.space.listeners.add(pCollisionActorBlock);
			
			var pCollisionActorPig:InteractionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _cbTypeActor, _cbTypePig, _handlerCollisionActorPig);
			_nape2dWorld.space.listeners.add(pCollisionActorPig);
			
			var pCollisionBlockBLock:InteractionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _cbTypeBlock, _cbTypeBlock, _handlerCollisionBlockBlock);
			_nape2dWorld.space.listeners.add(pCollisionBlockBLock);
			
			var pCollisionBlockPig:InteractionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _cbTypeBlock, _cbTypePig, _handlerCollisionBlockPig);
			_nape2dWorld.space.listeners.add(pCollisionBlockPig);
			
			var pCollisionPigFloor:InteractionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _cbTypePig, _cbTypeFloor, _handlerCollisionPigFloor);
			_nape2dWorld.space.listeners.add(pCollisionPigFloor);
			
			var pCollisionBlockFloor:InteractionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _cbTypeBlock, _cbTypeFloor, _handlerCollisionBlockFloor);
			_nape2dWorld.space.listeners.add(pCollisionBlockFloor);
				
		}
		
		private function _createWalls():void{
			
			var bottomWall:Body = new Body(BodyType.STATIC, new Vec2(Constants.APPLICATION_WIDTH / 2, Constants.APPLICATION_HEIGHT - 12.5));
			bottomWall.shapes.add(new Polygon(Polygon.box(Constants.APPLICATION_WIDTH ,25)));
			bottomWall.cbTypes.add(_cbTypeFloor);
			bottomWall.space = _space;
			
		
			var rightWall:Body = new Body(BodyType.STATIC, new Vec2(Constants.APPLICATION_WIDTH - 12.5, Constants.APPLICATION_HEIGHT / 2));
			rightWall.shapes.add(new Polygon(Polygon.box(25, Constants.APPLICATION_HEIGHT)));			
			rightWall.cbTypes.add(_cbTypeFloor);
			rightWall.space = _space;
		}
		
		private function _createActor():void	{
			
			_actor=new ViewBird();
			_actor.startPoint=new Point(Constants.BEGIN_BIRD_POSITION_X,Constants.BEGIN_BIRD_POSITION_Y)
			addChild(_actor);
			
			_bird=_actor.body;
			_bird.cbTypes.add(_cbTypeActor);
			_bird.space = _space; 
		}
		
		/*private var _map:Array=[[1,1,1,1,1],
								[1,5,6,5,1],
								[1,0,3,0,1],
								[4,2,0,2,4],
								[0,0,4,0,0]];
		
				
		private function _createBlocks():void{
			var pPosX:Number=0;
			var pPosY:Number=0;
			
			for (var i:int=0;i<5;i++){
				for(var j:int=0;j<5;j++){
					pPosX=700+50*j;
					
					if(_map[i][j]==0)continue;
					if(_map[i][j]==4){
						var pPig:ViewPig=new ViewPig();
						pPosY=Constants.APPLICATION_HEIGHT-50*(i+1);
						pPig.pigCreate(25);
						pPig.body.position=new Vec2(pPosX,pPosY);
						pPig.body.space=_space;
						pPig.body.cbTypes.add(_cbTypePig);
						pPig.addEventListener(EventViewPig.REMOVE_PIG,_handlerPigRemove);						
						addChild(pPig);
						continue;
					}
					var pBlocks:ViewBlock=new ViewBlock();
					
					
					if(_map[i][j]==1){		
						pPosY=Constants.APPLICATION_HEIGHT-25*(i+1);
						pBlocks.blockCreate(50,50);
						pBlocks.body.position=new Vec2(pPosX,pPosY);
						
					}
					if(_map[i][j]==6){		
						pPosY=Constants.APPLICATION_HEIGHT-25*(i+1);
						pBlocks.blockCreate(50,50,"stone");
						pBlocks.body.position=new Vec2(pPosX,pPosY);
						
					}
					
					if(_map[i][j]==2){
						pPosY=Constants.APPLICATION_HEIGHT-45*(i+1);
						pBlocks.blockCreate(25,100);
						pBlocks.body.position=new Vec2(pPosX,pPosY);
					}
					
					if(_map[i][j]==5){
						pPosY=Constants.APPLICATION_HEIGHT-45*(i+1);
						pBlocks.blockCreate(25,100,"stone");
						pBlocks.body.position=new Vec2(pPosX,pPosY);
					}
					
					if(_map[i][j]==3){
						pPosY=Constants.APPLICATION_HEIGHT-112.5*(i);
						pBlocks.blockCreate(200,25);						
						pBlocks.body.position=new Vec2(pPosX,pPosY);							
					}
					
					pBlocks.body.space=_space;
					pBlocks.body.cbTypes.add(_cbTypeBlock);
					pBlocks.addEventListener(EventViewBlocks.REMOVE_BLOCK,_handlerBlocsRemove);
					
					addChild(pBlocks);			
				}			
			}
		}*/
		
		private function _damagParseAndCalculate(pPhysObject:Object):Number{
			var pXDamage:Number = pPhysObject.x;
			var pYDamage:Number = pPhysObject.y;
			
			if(pXDamage<0)pXDamage*=-1;
			if(pYDamage<0)pYDamage*=-1;
			
			return pXDamage+pYDamage;
		}
				
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerBlocsRemove(event:EventViewBlocks):void{
			event.currentTarget.removeEventListener(EventViewBlocks.REMOVE_BLOCK,_handlerBlocsRemove);
			removeChild(ViewBlock(event.currentTarget));
		}
		
		private function _handlerPigRemove(event:EventViewPig):void{
			event.currentTarget.removeEventListener(EventViewPig.REMOVE_PIG,_handlerPigRemove);
			removeChild(ViewPig(event.currentTarget));
		}
		
				
		private function _update(event:Event):void{
			var pPosX:Number=_bird.position.x;
			pPosX=stage.stageWidth/2-pPosX;
			if (pPosX>0) {
				pPosX=0;
			}
			if (pPosX<-(Constants.APPLICATION_WIDTH-stage.stageWidth)) {
				pPosX=-(Constants.APPLICATION_WIDTH-stage.stageWidth);
			}
			this.x=pPosX;
			
			var pBodies:BodyList=_nape2dWorld.space.bodies;
			var pBodiesLength:int=pBodies.length;
			for (var i:int = 0; i < pBodiesLength; i++) {
				var pBody:Body=pBodies.at(i);
				if(pBody.userData.sprite!=null){
					pBody.userData.sprite.x=pBody.position.x
					pBody.userData.sprite.y=pBody.position.y
					pBody.userData.sprite.rotation=pBody.rotation*57.2957795;
				}
			}
			
		}
	
		private function _handlerCollisionActorBlock(pCallBack:InteractionCallback):void{
			pCallBack.int2.userData.damage(_damagParseAndCalculate(pCallBack.int2.castBody.totalContactsImpulse()));
			
		}
		
		private function _handlerCollisionActorPig(pCallBack:InteractionCallback):void{
			pCallBack.int2.userData.damage(_damagParseAndCalculate(pCallBack.int2.castBody.totalContactsImpulse()));
			trace("_handlerCollisionActorPig:"+pCallBack.int2.castBody.totalContactsImpulse());
		}
		
		private function _handlerCollisionBlockPig(pCallBack:InteractionCallback):void{
			pCallBack.int1.userData.damage(_damagParseAndCalculate(pCallBack.int1.castBody.totalContactsImpulse()));
			pCallBack.int2.userData.damage(_damagParseAndCalculate(pCallBack.int2.castBody.totalContactsImpulse()));
			trace("_handlerCollisionBlockPig(BLOCK_1):"+pCallBack.int1.castBody.totalContactsImpulse());
			trace("_handlerCollisionBlockPig(PIG):"+pCallBack.int2.castBody.totalContactsImpulse());
		}
		
		private function _handlerCollisionBlockBlock(pCallBack:InteractionCallback):void{
			pCallBack.int1.userData.damage(_damagParseAndCalculate(pCallBack.int1.castBody.totalContactsImpulse()));
			pCallBack.int2.userData.damage(_damagParseAndCalculate(pCallBack.int2.castBody.totalContactsImpulse()));
			trace("_handlerCollisionBlockBlock(BLOCK_1):  "+pCallBack.int1.castBody.totalContactsImpulse());
			trace("_handlerCollisionBlockBlock(BLOCK_2):  "+pCallBack.int2.castBody.totalContactsImpulse());
		}
		
		private function _handlerCollisionPigFloor(pCallBack:InteractionCallback):void{
			pCallBack.int1.userData.damage(_damagParseAndCalculate(pCallBack.int1.castBody.totalContactsImpulse()));
			trace("_handlerCollisionPigFloor(PIG):  "+pCallBack.int2.castBody.totalContactsImpulse());
		}
		
		private function _handlerCollisionBlockFloor(pCallBack:InteractionCallback):void{
			pCallBack.int1.userData.damage(_damagParseAndCalculate(pCallBack.int1.castBody.totalContactsImpulse()));
			trace("_handlerCollisionBlockFloor(BLOCK_1):  "+pCallBack.int2.castBody.totalContactsImpulse());
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