package com.angryBirdsGame.view.main{
	import com.angryBirdsGame.common.Constants;
	import com.angryBirdsGame.model.vo.VOBirdData;
	import com.angryBirdsGame.model.vo.VOBlockData;
	import com.angryBirdsGame.model.vo.VOPigData;
	import com.angryBirdsGame.view.abstract.ViewAbstract;
	import com.angryBirdsGame.view.bird.EventViewBird;
	import com.angryBirdsGame.view.bird.ViewBird;
	import com.angryBirdsGame.view.block.EventViewBlocks;
	import com.angryBirdsGame.view.block.ViewBlock;
	import com.angryBirdsGame.view.initNape.NapeInit;
	import com.angryBirdsGame.view.pig.EventViewPig;
	import com.angryBirdsGame.view.pig.ViewPig;
	import com.angryBirdsGame.view.utils.ParticleEffect;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyList;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import nape.space.Space;
	
	import org.flintparticles.common.events.EmitterEvent;

	
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
		private var _bodyBird:Body;
		private var _space:Space;
		private var _cbTypeBlock:CbType=new CbType();;
		private var _cbTypeActor:CbType=new CbType();;
		private var _cbTypePig:CbType=new CbType();;
		private var _cbTypeFloor:CbType=new CbType();;
		private var _birdIterator:int=0;
		private var _birdAmount:int=0;
		private var _particleEffect:ParticleEffect;
		private var _pigAmount:int=0;
		private var _gameConteiner:Sprite;
		private var _actorIsSleep:Boolean=false;
		private var _startButton:SimpleButton;
		private var _birdsArray:Array=[];
		
		//---------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function ViewMain(){
			addChild(new Background());
			
			_nape2dWorld = new NapeInit(Constants.APPLICATION_WIDTH, Constants.APPLICATION_HEIGHT, Constants.APPLICATION_FRAME_RATE,10);
			addChild(_nape2dWorld);
			
			_space=_nape2dWorld.space;
			_space.worldLinearDrag=0.25;
			_space.gravity.setxy(0, Constants.GRAVITY);	
			
			_startButton=new StartButton();
			_startButton.addEventListener(MouseEvent.CLICK,_handlerGameStart);
			_startButton.x=640/2;
			_startButton.y=Constants.APPLICATION_HEIGHT/2;
			addChild(_startButton);
					
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
		
		public function pigsCreate(pArrayPigssData:Array):void{
			var pArrayLength:int=pArrayPigssData.length;
			_pigAmount=pArrayLength;
			for(var i:int=0;i<pArrayLength;i++){
				_pigCreate(pArrayPigssData[i]);				
			}	
			
		}
		
		public function birdsCreate(pArrayBirdsData:Array):void{
			_birdsArray=pArrayBirdsData;
	
			if(_birdAmount==0){
				_birdAmount=_birdsArray.length;
			}
			
			_actorCreate(_birdsArray[_birdIterator]);				
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
			removeChild(_startButton);
			_createWalls();
			
			_gameConteiner=new Sprite();
			addChild(_gameConteiner);
			
			var pCatapulta:MovieClip=new Catapulta();
			pCatapulta.height=96;
			pCatapulta.width=32;
			pCatapulta.y=Constants.APPLICATION_HEIGHT-Constants.GROUND_HEIGHT-pCatapulta.height/2;
			pCatapulta.x=Constants.BEGIN_BIRD_POSITION_X;
			_gameConteiner.addChild(pCatapulta);
			setTimeout(_cbListenerCreate,2000);
			addEventListener(Event.ENTER_FRAME, _handlerWorldUpdate);
		}
		
				
		private function _cbListenerCreate():void{
			var pCollisionActorBlock:InteractionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _cbTypeActor, _cbTypeBlock, _handlerCollisionSecondBodySetDamage);
			_nape2dWorld.space.listeners.add(pCollisionActorBlock);
			
			var pCollisionActorPig:InteractionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _cbTypeActor, _cbTypePig, _handlerCollisionSecondBodySetDamage);
			_nape2dWorld.space.listeners.add(pCollisionActorPig);
			
			var pCollisionBlockBLock:InteractionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _cbTypeBlock, _cbTypeBlock, _handlerCollisionTwoBodySetDamage);
			_nape2dWorld.space.listeners.add(pCollisionBlockBLock);
			
			var pCollisionBlockPig:InteractionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _cbTypeBlock, _cbTypePig, _handlerCollisionTwoBodySetDamage);
			_nape2dWorld.space.listeners.add(pCollisionBlockPig);
			
			var pCollisionPigFloor:InteractionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _cbTypeFloor, _cbTypePig, _handlerCollisionSecondBodySetDamage);
			_nape2dWorld.space.listeners.add(pCollisionPigFloor);
			
			var pCollisionBlockFloor:InteractionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _cbTypeFloor, _cbTypeBlock, _handlerCollisionSecondBodySetDamage);
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
			
			var leftWall:Body = new Body(BodyType.STATIC, new Vec2(- 12.5, Constants.APPLICATION_HEIGHT / 2));
			leftWall.shapes.add(new Polygon(Polygon.box(25, Constants.APPLICATION_HEIGHT)));			
			leftWall.cbTypes.add(_cbTypeFloor);
			leftWall.space = _space;
		}
		
		private function _actorCreate(pVOBirdData:VOBirdData):void	{
			pVOBirdData.space=_space;
			_actorIsSleep=false;
			
			_actor=new ViewBird();
			_actor.actorCreateBody(pVOBirdData);
			_actor.cbType=_cbTypeActor;
			_actor.addEventListener(EventViewBird.ACTOR_SLEEP,_handlerActorSleep);
			_gameConteiner.addChild(_actor);
			
			_bodyBird=_actor.body;
			
		}
		
		private function _blockCreate(pVOBlockData:VOBlockData):void	{
			pVOBlockData.space=_space;
			
			var pBlock:ViewBlock=new ViewBlock();				
			pBlock.createObject(VOBlockData(pVOBlockData));
			pBlock.cbType=_cbTypeBlock;		
			pBlock.addEventListener(EventViewBlocks.REMOVE_BLOCK,_handlerBlockRemove);
			_gameConteiner.addChild(pBlock);
		}
		
		private function _pigCreate(pVOPigData:VOPigData):void	{
			pVOPigData.space=_space;
			
			var pPig:ViewPig=new ViewPig();				
			pPig.pigBodyCreate(VOPigData(pVOPigData));
			pPig.cbType=_cbTypePig;		
			pPig.addEventListener(EventViewPig.REMOVE_PIG,_handlerPigRemove);
			_gameConteiner.addChild(pPig);
		}
		
		
		private function _damagParseAndCalculate(pPhysObject:Object):Number{
			var pXDamage:Number = pPhysObject.x;
			var pYDamage:Number = pPhysObject.y;
			
			if(pXDamage<0)pXDamage*=-1;
			if(pYDamage<0)pYDamage*=-1;
			
			return pXDamage+pYDamage;
		}
		private function _checEndGame():void{
			
			if(_birdIterator==_birdAmount){
				setTimeout(_endGameAndClearWorld,1000);
			}else{
				_actorCreate(_birdsArray[_birdIterator]);				
				_birdIterator++;	
			}
		}
		
		private function _endGameAndClearWorld():void{		
			removeEventListener(Event.ENTER_FRAME, _handlerWorldUpdate);
			_space.clear();			
			removeChild(_gameConteiner);
			addChild(_startButton);
			x=0;
			_birdIterator=0;
			_birdAmount=0;
			_birdsArray=[];
			_startButton.addEventListener(MouseEvent.CLICK,_handlerGameStart);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		
		private function _handlerGameStart(event:MouseEvent):void{
			_startButton.removeEventListener(MouseEvent.CLICK,_handlerGameStart);
			_initialize();
			dispatchEvent(new EventViewMain(EventViewMain.LOAD_MAP_DATA));
		}
		
		private function _handlerBlockRemove(event:EventViewBlocks):void{
			event.currentTarget.removeEventListener(EventViewBlocks.REMOVE_BLOCK,_handlerBlockRemove);
			setParticleEffectData(ViewAbstract(event.currentTarget));
		}
		
		private function _handlerPigRemove(event:EventViewPig):void{
			event.currentTarget.removeEventListener(EventViewPig.REMOVE_PIG,_handlerPigRemove);
			setParticleEffectData(ViewAbstract(event.currentTarget));
			_pigAmount-=1;
			if(_pigAmount==0){
				setTimeout(_endGameAndClearWorld,1500);
			}
		}
		
		private function setParticleEffectData(pPhysicsObject:ViewAbstract):void{
			var pType:String=pPhysicsObject.type;
			var pBodyBlock:Body=pPhysicsObject.body;
			var pParticleEffect:ParticleEffect=new ParticleEffect();
			pParticleEffect.addEventListener(EmitterEvent.EMITTER_EMPTY,_handlerRemoveCurrentEffect);
			addChild(pParticleEffect);			
			pParticleEffect.startEmitter(pBodyBlock.userData.skin,pType);
		}
				
		private function _handlerWorldUpdate(event:Event):void{
			var pPosX:Number=_bodyBird.position.x;
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
			
				if(_actorIsSleep){
					pBody.rotation=0;
				}
				if(pBody.userData.skin!=null){					
					pBody.userData.skin.x=pBody.position.x;
					pBody.userData.skin.y=pBody.position.y;			
					pBody.userData.skin.rotation=pBody.rotation*57.2957795;
				}
				
			}
			
		}	
		
		private function _handlerCollisionSecondBodySetDamage(pCallBack:InteractionCallback):void{
			pCallBack.int2.userData.damage(_damagParseAndCalculate(pCallBack.int2.castBody.totalContactsImpulse()));
		}
		
		private function _handlerCollisionTwoBodySetDamage(pCallBack:InteractionCallback):void{
			pCallBack.int1.userData.damage(_damagParseAndCalculate(pCallBack.int1.castBody.totalContactsImpulse()));
			pCallBack.int2.userData.damage(_damagParseAndCalculate(pCallBack.int2.castBody.totalContactsImpulse()));
		} 
		
		private function _handlerRemoveCurrentEffect(event:EmitterEvent):void{
			event.currentTarget.removeEventListener(EmitterEvent.EMITTER_EMPTY,_handlerRemoveCurrentEffect);
			removeChild(ParticleEffect(event.currentTarget));
		}
		
		private function _handlerActorSleep(event:EventViewBird):void{		
			_checEndGame();	
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