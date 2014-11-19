package com.project{
	import com.project.controller.CommandLoadMapData;
	import com.project.controller.CommandRequestFullfieldSetSomeData;
	import com.project.controller.CommandStartupComplete;
	import com.project.model.IModel;
	import com.project.model.Model;
	import com.project.services.getData.IServiceGet;
	import com.project.services.getData.ServiceGet;
	import com.project.view.abstract.EventViewAbstract;
	import com.project.view.abstract.MediatorViewAbstract;
	import com.project.view.abstract.ViewAbstract;
	import com.project.view.bird.MediatorViewBird;
	import com.project.view.bird.ViewBird;
	import com.project.view.block.MediatorViewBlock;
	import com.project.view.block.ViewBlock;
	import com.project.view.main.EventViewMain;
	import com.project.view.main.MediatorViewMain;
	import com.project.view.main.ViewMain;
	import com.project.view.pig.MediatorViewPig;
	import com.project.view.pig.ViewPig;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.base.ContextEvent;
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
			//injector.mapSingletonOf(IServiceGet,ServiceGet);
			
			// map View			
			mediatorMap.mapView(ViewAbstract, MediatorViewAbstract);
			mediatorMap.mapView(ViewMain, MediatorViewMain);
			mediatorMap.mapView(ViewBird, MediatorViewBird);
			mediatorMap.mapView(ViewPig, MediatorViewPig);
			mediatorMap.mapView(ViewBlock, MediatorViewBlock);
			
			// Command
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, CommandStartupComplete, ContextEvent, true);
			commandMap.mapEvent(EventViewAbstract.SET_DATA, CommandRequestFullfieldSetSomeData, EventViewAbstract);
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