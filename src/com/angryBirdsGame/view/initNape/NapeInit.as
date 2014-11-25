package com.angryBirdsGame.view.initNape{
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import nape.geom.Vec2;
	import nape.space.Broadphase;
	import nape.space.Space;
	import nape.util.BitmapDebug;
	
	public class NapeInit extends Sprite{
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
		private var _space:Space;
		private var _timeStep:Number = 0;
		private var _velocityIterations:int = 0;
		private var _positionIterations:int = 0;
		
		private var _appWidth:int = 0;
		private var _appHeight:int = 0;
		
		private var _debug:BitmapDebug;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function NapeInit(appWidth:int = 800, appHeight:int = 600, timeStep:Number = 30, iterations:int = 10){
			_appWidth = appWidth;
			_appHeight = appHeight;
			_timeStep = 1/timeStep;
			_velocityIterations = _positionIterations = iterations;	
			
			 _init();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function clear():void{_space.clear();}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function get space():Space{return _space;}
		public function get debug():BitmapDebug{return _debug;}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		private function _init(event:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE, _init);
			
			_space = new Space(new Vec2(0, 400), Broadphase.SWEEP_AND_PRUNE);
			
			//_initDebugDraw();
			
			addEventListener(Event.ENTER_FRAME, _handlerEnterFrame)
		}
		
		private function _initDebugDraw():void{
			_debug = new BitmapDebug(_appWidth, _appHeight, 0xdddddd);
			_debug.drawCollisionArbiters = true;
			_debug.drawConstraints=true;
			addChild(_debug.display);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerEnterFrame(event:Event):void
		{
			_space.step(_timeStep, _velocityIterations, _positionIterations);
			
			/*_debug.clear();
			_debug.draw(_space);
			_debug.flush();*/
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