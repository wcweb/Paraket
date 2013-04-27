package org.libra.events {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public class LibraEvent extends Event {
		
		public static const BTN_CLICKRD:String = "btnClicked";
		public static const GET_FOCUS:String = "getFocus";
		public static const LOST_FOCUS:String = "lostFocus";
		
		public function LibraEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event { 
			return new LibraEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("LibraEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}