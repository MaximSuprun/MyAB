package com.razzmatazz.utils.logger {
	
	import com.razzmatazz.valueObjects.log.VOLogMessage;
	
	
	public interface ILogger {
		
		function logMessageSet(pData:VOLogMessage):void;
		
		
	}
}