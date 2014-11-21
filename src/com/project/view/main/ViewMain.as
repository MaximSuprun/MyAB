package com.project.view.main{
	import com.greensock.TweenLite;
	import com.project.common.Constants;
	import com.project.model.vo.VOBirdData;
	import com.project.model.vo.VOBlockData;
	import com.project.model.vo.VOPigData;
	import com.project.view.abstract.ViewAbstract;
	import com.project.view.bird.ViewBird;
	import com.project.view.block.EventViewBlocks;
	import com.project.view.block.ViewBlock;
	import com.project.view.initNape.NapeInit;
	import com.project.view.pig.EventViewPig;
	import com.project.view.pig.ViewPig;
	
	import flash.events.Event;
	import flash.utils.setTimeout;
	
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
		private var _birdIterator:int=0;
		private var _birdAmount:int=0;
		
		//---------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function ViewMain(){
			
			_nape2dWorld = new NapeInit(Constants.APPLICATION_WIDTH, Constants.APPLICATION_HEIGHT, Constants.APPLICATION_FRAME_RATE,10);
			addChild(_nape2dWorld);
			_space=_nape2dWorld.space;
			_space.worldLinearDrag=0.25;
			
			_hand=new PivotJoint(_nape2dWorld.space.world,null,Vec2.weak(),Vec2.weak());
			_hand.stiff=false;
			_hand.space=_nape2dWorld.space;
			_hand.active=false;
			_cbTypeCreate();
			setTimeout(_cbListenerCreate,1000);
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
				_blockCreate(pArrayBlokcsData[i]);				
			}			
		}
		public function pigsCreate(pArrayBlokcsData:Array):void{
			var pArrayLength:int=pArrayBlokcsData.length;
			
			for(var i:int=0;i<pArrayLength;i++){
				_pigCreate(pArrayBlokcsData[i]);				
			}	
			
		}
		public function birdsCreate(pArrayBlokcsData:Array):void{
			if(_birdAmount==0){
				_birdAmount=pArrayBlokcsData.length;
			}
			
			_actorCreate(pArrayBlokcsData[_birdIterator]);				
			_birdIterator++;
		
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
			
			addEventListener(Event.ENTER_FRAME, _handlerWorldUpdate);
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
		
		private function _actorCreate(pVOBirdData:VOBirdData):void	{
			pVOBirdData.space=_space;
			
			_actor=new ViewBird();
			_actor.actorCreateBody(pVOBirdData);
			addChild(_actor);
			
			_bird=_actor.body;
			_bird.cbTypes.add(_cbTypeActor);
		}
		
		private function _blockCreate(pVOBlockData:VOBlockData):void	{
			pVOBlockData.space=_space;
			
			var pBlock:ViewBlock=new ViewBlock();				
			pBlock.createObject(VOBlockData(pVOBlockData));
			pBlock.body.cbTypes.add(_cbTypeBlock);			
			pBlock.addEventListener(EventViewBlocks.REMOVE_BLOCK,_handlerBlockRemove);
			addChild(pBlock);
		}
		
		private function _pigCreate(pVOPigData:VOPigData):void	{
			pVOPigData.space=_space;
			
			var pPig:ViewPig=new ViewPig();				
			pPig.pigBodyCreate(VOPigData(pVOPigData));
			pPig.body.cbTypes.add(_cbTypePig);			
			pPig.addEventListener(EventViewPig.REMOVE_PIG,_handlerPigRemove);
			addChild(pPig);
		}
		
		
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
		private function _handlerBlockRemove(event:EventViewBlocks):void{
			event.currentTarget.removeEventListener(EventViewBlocks.REMOVE_BLOCK,_handlerBlockRemove);
			removeChild(ViewBlock(event.currentTarget));
		}
		
		private function _handlerPigRemove(event:EventViewPig):void{
			event.currentTarget.removeEventListener(EventViewPig.REMOVE_PIG,_handlerPigRemove);
			removeChild(ViewPig(event.currentTarget));
		}
		
				
		private function _handlerWorldUpdate(event:Event):void{
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
				if(pBody.userData.skin!=null){
					pBody.userData.skin.x=pBody.position.x
					pBody.userData.skin.y=pBody.position.y
					pBody.userData.skin.rotation=pBody.rotation*57.2957795;
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