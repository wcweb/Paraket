package org.libra.events {
	import flash.events.Event;
	
	/**
	 * 滚动条事件，当滚动条移动时，响应该事件
	 * @author Eddie
	 */
	public class ScrollEvent extends Event {
		
		/**
		 * 滚动条移动事件
		 */
		public static const MOVE:String = "move";
		
		/**
		 * 滚动条当前所在的行数
		 */
		private var curLine:int;
		
		public function ScrollEvent(type:String, curLine:int, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
			this.curLine = curLine;
		} 
		
		public function getCurLine():int {
			return this.curLine;
		}
		
		public override function clone():Event { 
			return new ScrollEvent(type, curLine, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("ScrollEvent", "curLine", "type", "bubbles", "cancelable", "eventPhase");
		}
		
	}
	
}