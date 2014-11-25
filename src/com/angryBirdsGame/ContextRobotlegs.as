package com.angryBirdsGame{
	import com.angryBirdsGame.controller.CommandLoadMapData;
	import com.angryBirdsGame.model.IModel;
	import com.angryBirdsGame.model.Model;
	import com.angryBirdsGame.view.abstract.MediatorViewAbstract;
	import com.angryBirdsGame.view.abstract.ViewAbstract;
	import com.angryBirdsGame.view.main.EventViewMain;
	import com.angryBirdsGame.view.main.MediatorViewMain;
	import com.angryBirdsGame.view.main.ViewMain;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	
	public class ContextRobotlegs extends Context{
		
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
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function ContextRobotlegs(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true){
			super(contextView, autoStartup);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		override public function startup():void{
			
			// service & model				
			injector.mapSingletonOf(IModel, Model);
			
			// map View			
			mediatorMap.mapView(ViewAbstract, MediatorViewAbstract);
			mediatorMap.mapView(ViewMain, MediatorViewMain);
			
			// Command
			commandMap.mapEvent(EventViewMain.LOAD_MAP_DATA, CommandLoadMapData, EventViewMain);
					
			super.startup();
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