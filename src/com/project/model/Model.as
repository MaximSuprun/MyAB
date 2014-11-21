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
			
			_map=[[1,2,1,2,1],
				  [1,2,1,2,1],
				  [7,5,2,5,7],
				  [0,0,4,0,0],
				  [0,0,7,0,0]];
			
			var pRowLength:int=_map.length;
			
			for (var i:int=0;i<pRowLength;i++){	
				var pColumnLength:int=_map[i].length;
				for(var j:int=0;j<pColumnLength;j++){	
					var pTempDataArray:Object={};
					if(_map[i][j]==0)continue;
					
					pPosX=Constants.BEGIN_BUILDINGS_POSITION_Y+j*_cellSize;
					pPosY=Constants.APPLICATION_HEIGHT-Constants.GROUND_HEIGHT;	
					
					switch (_map[i][j]){
						case 7:
							pVOPigData=new VOPigData();
							pVOPigData.friction=3;
							pVOPigData.density=2;
							pVOPigData.health=500;
							pVOPigData.radius=20;
							if((i>=1)){
								if(_map[i-1][j]!=0){
									pPosY=_map[i-1][j].y-_map[i-1][j].height/2-pVOPigData.radius;
								}
							}else{
								pPosY-=pVOPigData.radius;
							}
							
							pVOPigData.position=new Point(pPosX,pPosY);
							arrayVOPigData.push(pVOPigData);
							
							pTempDataArray.y=pPosY;
							pTempDataArray.height=pVOPigData.radius*2;
							_map[i][j]=pTempDataArray;						
							continue;
							break;
						case 1:
							pVOBlockData = createBodyBlock(_cellSize,_cellSize,3,10,1500,Constants.WOOD);
							break;
						case 2:
							pVOBlockData = createBodyBlock(_cellSize,_cellSize,3,15,1750,Constants.STONE);
							break;
						case 3:
							pVOBlockData = createBodyBlock(_cellSize*3,_cellSize/2,3,10,1000,Constants.WOOD_PLANK);
							break;
						case 4:
							pVOBlockData = createBodyBlock(_cellSize*3,_cellSize/2,3,15,1250,Constants.STONE_PLANK);
							break;
						case 5:
							pVOBlockData = createBodyBlock(_cellSize/3,_cellSize*2,3,10,1000,Constants.WOOD_PLANK);	
							break;
						case 6:
							pVOBlockData = createBodyBlock(_cellSize/2,_cellSize*2,3,15,1250,Constants.STONE_PLANK);
							break;
					}
					
					if(pVOBlockData==null)continue;
					
					if((i>=1)){
						
					    if(_map[i-1][j]!=0){
							pPosY=_map[i-1][j].y-_map[i-1][j].height/2-pVOBlockData.height/2;
						}
					
						if(_map[i][j]==3||_map[i][j]==4){
							if(j-1>=0 && j+1<pRowLength){
								if(_map[i-1][j-1].height>_cellSize||_map[i-1][j+1].height>_cellSize){								
									pPosY-=_cellSize;
								}
							}
						}
					}else{
						pPosY-=pVOBlockData.height/2;
					}
					
					pTempDataArray.y=pPosY;
					pTempDataArray.height=pVOBlockData.height;	
					
					if(_map[i][j]==3||_map[i][j]==4){
						if(j-1>=0 && j+1<pRowLength){
							_map[i][j-1]=pTempDataArray;
							_map[i][j+1]=pTempDataArray;
						}
					}
					
					_map[i][j]=pTempDataArray;
					pVOBlockData.position=new Point(pPosX,pPosY);					
					arrayVOBlockData.push(pVOBlockData);
					
					pVOBlockData=null;	
				}
			}
			dispatch(new EventModel(EventModel.MAP_LOADED,arrayVOBlockData));
			dispatch(new EventModel(EventModel.PIGS_LOADED,arrayVOPigData));
			_birdDataLoaded();
		}
		
		private function createBodyBlock(pWidth:Number,pHeight:Number,pFriction:Number,pDensity:Number,pHealth:Number,pSkin:String):VOBlockData{			
			var pVOBlockData:VOBlockData;
			
			pVOBlockData = new VOBlockData();
			pVOBlockData.width=pWidth;
			pVOBlockData.height=pHeight;
			pVOBlockData.friction=pFriction;
			pVOBlockData.density=pDensity;
			pVOBlockData.health=pHealth;
			pVOBlockData.skin=pSkin;	
			
			return 	pVOBlockData;	
		}
		
		private function _birdDataLoaded():void{
			var pVOBirdData:VOBirdData;
			for(var i:int=0;i<_amountBirds;i++){
				pVOBirdData=new VOBirdData();
				pVOBirdData.friction=5;
				pVOBirdData.density=15;
				pVOBirdData.radius=15;
				pVOBirdData.position=new Point(Constants.BEGIN_BIRD_POSITION_X,Constants.BEGIN_BIRD_POSITION_Y);
				arrayVOBirdData.push(pVOBirdData);
			}
			dispatch(new EventModel(EventModel.BIRDS_LOADED,arrayVOBirdData));
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