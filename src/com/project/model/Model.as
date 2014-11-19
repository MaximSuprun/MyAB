package com.project.model{
	import com.project.common.Constants;
	import com.project.model.vo.VOBirdData;
	import com.project.model.vo.VOBlockData;
	import com.project.model.vo.VOPigData;
	import com.razzmatazz.robotlegs.model.modelLoading.EventActorLoader;
	import com.razzmatazz.robotlegs.model.modelLoading.VOLoading;
	
	import flash.geom.Point;
	
	import org.robotlegs.mvcs.Actor;
	
	public class Model extends Actor implements IModel{		
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
		private var _birdDataContainer:Array=[];						
		private var _pigDataContainer:Array=[];							
		private var _blocksDataContainer:Array=[];
		private var _cellSize:Number=50;
		private var _amountBirds:int=3;
		private var _amountPig:int=0;
		private var _amountWoodPlank:int=0;
		private var _amountWoodBlock:int=0;
		private var _amountStonePlank:int=0;
		private var _amountStoneBlock:int=0;
		private var _map:Array=[];
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function Model() {
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
		public function set arrayVOBirdData(pVectorVOBirdData:Array):void{
			_birdDataContainer = pVectorVOBirdData;
		}
		public function get arrayVOBirdData():Array{
			return _birdDataContainer;
		}		
		
		public function set arrayVOPigData(pVectorVOBirdData:Array):void{
			_pigDataContainer = pVectorVOBirdData;
		}
		public function get arrayVOPigData():Array{
			return _pigDataContainer;
		}		
		
		public function set arrayVOBlockData(pVectorVOBlockData:Array):void{
			_blocksDataContainer = pVectorVOBlockData;
		}
		public function get arrayVOBlockData():Array{
			return _blocksDataContainer;
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		public function createData():void{
			var pPosX:Number=0;
			var pPosY:Number=0;			
			var pVOBlockData:VOBlockData;
			var pVOPigData:VOPigData;
			
			_map=[[1,2,2,2,1],
				  [0,0,0,0,0],
				  [0,0,0,0,0],
				  [0,0,0,0,0]];
			
			var pMapLength:int=_map.length;
			
			for (var i:int=0;i<pMapLength;i++){				
				for(var j:int=0;j<pMapLength;j++){					
					if(_map[i][j]==0)continue;
					pPosX=Constants.BEGIN_BUILDINGS_POSITION_Y+j*50;
					
					if (_map[i][j]==7){
						pVOPigData=new VOPigData();
						pVOPigData.friction=3;
						pVOPigData.density=2;
						pVOPigData.health=750;
						pVOPigData.radius=20;
						pPosY=Constants.APPLICATION_HEIGHT-Constants.GROUND_HEIGHT-_cellSize*i+pVOPigData.radius;
						if((i>=1&&j>=1&&j<=pMapLength)&&(_map[i-1][j]==3||_map[i-1][j-1]==3||_map[i-1][j+1]==3||_map[i-1][j]==4||_map[i-1][j-1]==4||_map[i-1][j+1]==4)){pPosY-=_cellSize;}
						if((i>=1&&j>=1&&j<=pMapLength)&&(_map[i-1][j]==5||_map[i-1][j]==6)){pPosY+=_cellSize}
						pVOPigData.position=new Point(pPosX,pPosY);
						_pigDataContainer.push(pVOPigData);
						continue;
					}
					
					if(_map[i][j]==1){
						
						pVOBlockData = new VOBlockData();
						pVOBlockData.width=_cellSize;
						pVOBlockData.height=_cellSize;
						pVOBlockData.friction=3;
						pVOBlockData.density=10;
						pVOBlockData.health=2500;
						pVOBlockData.skin="wood";
						pPosY=Constants.APPLICATION_HEIGHT-Constants.GROUND_HEIGHT-_cellSize*i-pVOBlockData.height/2;
						if((i>=1&&j>=1&&j<=pMapLength)&&(_map[i-1][j]==3||_map[i-1][j-1]==3||_map[i-1][j+1]==3||_map[i-1][j]==4||_map[i-1][j-1]==4||_map[i-1][j+1]==4)){pPosY+=_cellSize;}
						if((i>=1&&j>=1&&j<=pMapLength)&&(_map[i-1][j]==5||_map[i-1][j]==6)){pPosY-=_cellSize}
						pVOBlockData.position=new Point(pPosX,pPosY)						
					}
					if(_map[i][j]==2){
						
						pVOBlockData = new VOBlockData();
						pVOBlockData.width=_cellSize;
						pVOBlockData.height=_cellSize;
						pVOBlockData.friction=3;
						pVOBlockData.density=15;
						pVOBlockData.health=3000;
						pVOBlockData.skin="stone";
						pPosY=Constants.APPLICATION_HEIGHT-Constants.GROUND_HEIGHT-_cellSize*i-pVOBlockData.height/2;
						if((i>=1&&j>=1&&j<=pMapLength)&&(_map[i-1][j]==3||_map[i-1][j-1]==3||_map[i-1][j+1]==3||_map[i-1][j]==4||_map[i-1][j-1]==4||_map[i-1][j+1]==4)){pPosY+=_cellSize;}
						if((i>=1&&j>=1&&j<=pMapLength)&&(_map[i-1][j]==5||_map[i-1][j]==6)){pPosY-=_cellSize}
						pVOBlockData.position=new Point(pPosX,pPosY)
						
					}
					if(_map[i][j]==3){
						
						pVOBlockData = new VOBlockData();
						pVOBlockData.width=_cellSize*3;
						pVOBlockData.height=_cellSize/2;
						pVOBlockData.friction=3;
						pVOBlockData.density=10;
						pVOBlockData.health=2500;
						pVOBlockData.skin="wood_plank";
						pPosY=Constants.APPLICATION_HEIGHT-Constants.GROUND_HEIGHT-_cellSize*i-pVOBlockData.height/2;
						if((i>=1&&j>=1&&j<=pMapLength)&&(_map[i-1][j]==3||_map[i-1][j-1]==3||_map[i-1][j+1]==3||_map[i-1][j]==4||_map[i-1][j-1]==4||_map[i-1][j+1]==4)){pPosY+=_cellSize;}
						if((i>=1&&j>=1&&j<=pMapLength)&&(_map[i-1][j]==5||_map[i-1][j]==6)){pPosY-=_cellSize}
						pVOBlockData.position=new Point(pPosX,pPosY)
						
					}
					if(_map[i][j]==4){
						
						pVOBlockData = new VOBlockData();
						pVOBlockData.width=_cellSize*3;
						pVOBlockData.height=_cellSize/2;
						pVOBlockData.friction=3;
						pVOBlockData.density=15;
						pVOBlockData.health=3000;
						pVOBlockData.skin="stone_plank";
						pPosY=Constants.APPLICATION_HEIGHT-Constants.GROUND_HEIGHT-_cellSize*i-pVOBlockData.height/2;
						if((i>=1&&j>=1&&j<=pMapLength)&&(_map[i-1][j]==3||_map[i-1][j-1]==3||_map[i-1][j+1]==3||_map[i-1][j]==4||_map[i-1][j-1]==4||_map[i-1][j+1]==4)){pPosY+=_cellSize;}
						if((i>=1&&j>=1&&j<=pMapLength)&&(_map[i-1][j]==5||_map[i-1][j]==6)){pPosY-=_cellSize}
						pVOBlockData.position=new Point(pPosX,pPosY)
						
					}
					
					if(_map[i][j]==5){
						
					    pVOBlockData = new VOBlockData();
						pVOBlockData.width=_cellSize/2;
						pVOBlockData.height=_cellSize*2;
						pVOBlockData.friction=3;
						pVOBlockData.density=10;
						pVOBlockData.health=2500;
						pVOBlockData.skin="wood_plank";
						pPosX+=pVOBlockData.height/2;
						pPosY=Constants.APPLICATION_HEIGHT-Constants.GROUND_HEIGHT-_cellSize*i-_cellSize;
						if((i>=1&&j>=1&&j<=pMapLength)&&(_map[i-1][j]==3||_map[i-1][j-1]==3||_map[i-1][j+1]==3||_map[i-1][j]==4||_map[i-1][j-1]==4||_map[i-1][j+1]==4)){pPosY+=_cellSize;}
						if((i>=1&&j>=1&&j<=pMapLength)&&(_map[i-1][j]==5||_map[i-1][j]==6)){pPosY-=_cellSize}
						pVOBlockData.position=new Point(pPosX,pPosY);				
					}	
					
					if(_map[i][j]==6){
						
						pVOBlockData = new VOBlockData();
						pVOBlockData.width=_cellSize/2;
						pVOBlockData.height=_cellSize*2;
						pVOBlockData.friction=3;
						pVOBlockData.density=15;
						pVOBlockData.health=3000;
						pVOBlockData.skin="stone_plank";
						pPosX+=pVOBlockData.height/2;
						pPosY=Constants.APPLICATION_HEIGHT-Constants.GROUND_HEIGHT-_cellSize*i-_cellSize;
						if((i>=1&&j>=1&&j<=pMapLength)&&(_map[i-1][j]==3||_map[i-1][j-1]==3||_map[i-1][j+1]==3||_map[i-1][j]==4||_map[i-1][j-1]==4||_map[i-1][j+1]==4)){pPosY+=_cellSize;}
						if((i>=1&&j>=1&&j<=pMapLength)&&(_map[i-1][j]==5||_map[i-1][j]==6)){pPosY-=_cellSize}
						pVOBlockData.position=new Point(pPosX,pPosY);				
					}		
					
					_blocksDataContainer.push(pVOBlockData);
					//pVOBlockData=null;
					
				}
			}
			dispatch(new EventModel(EventModel.MAP_LOADED,_blocksDataContainer));
			//_birdDataLoaded();
		}
		
		private function _birdDataLoaded():void{
			var pVOBirdData:VOBirdData;
			for(var i:int=0;i<_amountBirds;i++){
				pVOBirdData=new VOBirdData();
				pVOBirdData.friction=5;
				pVOBirdData.density=15;
			}
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
		
		protected function _loadStartedHandler():void {
			var pData:VOLoading = new VOLoading(this, VOLoading.STATUS__START);
			dispatch(new EventActorLoader(EventActorLoader.LOADING_STARTED, pData));
		}
		
		
		protected function _loadCompletedHandler():void {
			var pData:VOLoading = new VOLoading(this, VOLoading.STATUS__FINISH);
			dispatch(new EventActorLoader(EventActorLoader.LOADING_FINISHED, pData));
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
	}
}