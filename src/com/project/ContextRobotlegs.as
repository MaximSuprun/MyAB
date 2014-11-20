package com.project{
	import com.project.controller.CommandLoadMapData;
	import com.project.model.IModel;
	import com.project.model.Model;
	import com.project.view.abstract.MediatorViewAbstract;
	import com.project.view.abstract.ViewAbstract;
	import com.project.view.main.EventViewMain;
	import com.project.view.main.MediatorViewMain;
	import com.project.view.main.ViewMain;
	
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