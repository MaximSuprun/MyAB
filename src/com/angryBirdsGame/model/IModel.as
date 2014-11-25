package com.angryBirdsGame.model {
	
	

	public interface IModel {
		
		function set arrayVOBirdData(pData:Array):void
		function set arrayVOBlockData(pData:Array):void
		function set arrayVOPigData(pData:Array):void
		
		function get arrayVOBirdData():Array;
		function get arrayVOBlockData():Array;
		function get arrayVOPigData():Array;
		
		function createData():void

	}
}