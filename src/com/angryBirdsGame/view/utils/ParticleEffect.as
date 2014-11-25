package com.angryBirdsGame.view.utils{
	
	import com.angryBirdsGame.common.Constants;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import org.flintparticles.common.counters.Blast;
	import org.flintparticles.common.events.EmitterEvent;
	import org.flintparticles.common.initializers.ImageClass;
	import org.flintparticles.twoD.actions.DeathZone;
	import org.flintparticles.twoD.actions.Explosion;
	import org.flintparticles.twoD.actions.Move;
	import org.flintparticles.twoD.actions.SpeedLimit;
	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.initializers.Position;
	import org.flintparticles.twoD.initializers.Velocity;
	import org.flintparticles.twoD.renderers.DisplayObjectRenderer;
	import org.flintparticles.twoD.zones.DiscZone;
	import org.flintparticles.twoD.zones.DisplayObjectZone;
	import org.flintparticles.twoD.zones.RectangleZone;
	
	public class ParticleEffect extends Sprite{
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
		private var _emitter:Emitter2D;
		private var _particleWood:ParticleWood;
		private var _renderer:DisplayObjectRenderer;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function ParticleEffect()
		{
			super();
			_particleWood=new ParticleWood();
			_initialize();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function startEmitter(pSkin:DisplayObject,pType:String):void{
			switch(pType){
				case Constants.WOOD:
					_emitter.addInitializer(new ImageClass(ParticleWood));			
					break;
				case Constants.STONE:
					_emitter.addInitializer(new ImageClass(ParticleStone));			
					break;
				case Constants.BLOOD:
					_emitter.addInitializer(new ImageClass(ParticleBlood));			
					break;
			}
			_emitter.addInitializer(new Position(new DisplayObjectZone(pSkin,_renderer))); 			
			_emitter.addAction(new Explosion (50,pSkin.x,pSkin.y,300));			
			_emitter.addInitializer(new Velocity(new DiscZone(new Point(0,0),150,100)));			
			_emitter.addAction(new SpeedLimit(150, true));
			_emitter.addAction(new SpeedLimit(200));		
			_emitter.addAction(new DeathZone(new RectangleZone(pSkin.x-pSkin.width,pSkin.y-pSkin.height,pSkin.x+pSkin.width,pSkin.y+pSkin.height),true)); 
			_emitter.addAction(new Move());
			_emitter.start();
			
			pSkin.parent.removeChild(pSkin);
			_emitter.addEventListener(EmitterEvent.EMITTER_EMPTY,_handlerParticleExplosion);
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
			_emitter=new Emitter2D();
			_emitter.counter = new Blast(Math.random()*25+10); 
			
			
			_renderer = new DisplayObjectRenderer(); 
			_renderer.addEmitter(_emitter); 
			addChild(_renderer); 			
			
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerParticleExplosion(event:EmitterEvent):void{
			_emitter.removeEventListener(EmitterEvent.EMITTER_EMPTY,_handlerParticleExplosion);
			dispatchEvent(new EmitterEvent(EmitterEvent.EMITTER_EMPTY));
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