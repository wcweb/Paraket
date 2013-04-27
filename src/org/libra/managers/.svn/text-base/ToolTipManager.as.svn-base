package org.libra.managers {
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import org.libra.basic.Component;
	import org.libra.utils.DepthUtil;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public final class ToolTipManager {
		
		private static var instance:ToolTipManager = null;
		private var main:DisplayObjectContainer;
		private var tiggerToolTipMap:Dictionary;
		private var currentToolTip:Component;
		private var timer:Timer;
		
		/**
		 * 鼠标进入组件后，间隔一段时间后，显示toolTip
		 */
		private var interval:int;
		
		public function ToolTipManager() {
			this.main = LibraManager.getInstance().getMain();
			tiggerToolTipMap = new Dictionary(true);
			interval = 600;
			timer = new Timer(interval, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerCompleted);
		}
		
		private function onTimerCompleted(e:TimerEvent):void {
			this.showCustomToolTip();
		}
		
		public function setToolTip(com:Component, toolTip:Component):void { 
			if (toolTip) {
				if (!tiggerToolTipMap[com]) {
					com.addEventListener(MouseEvent.ROLL_OVER, onTriggerOverHandler, false, 0, true);
					com.addEventListener(MouseEvent.ROLL_OUT, onTriggerOutHandler, false, 0, true);
					com.addEventListener(MouseEvent.MOUSE_DOWN, onTriggerOutHandler, false, 0, true);
				}
				tiggerToolTipMap[com] = toolTip;
			}else {
				if (tiggerToolTipMap[com]) {
					com.removeEventListener(MouseEvent.ROLL_OVER, onTriggerOverHandler, false);
					com.removeEventListener(MouseEvent.ROLL_OUT, onTriggerOutHandler, false);
					com.removeEventListener(MouseEvent.MOUSE_DOWN, onTriggerOutHandler, false);
					delete tiggerToolTipMap[com];
				}
			}
		}
		
		private function onTriggerOutHandler(e:MouseEvent):void {
			var com:Component = e.currentTarget as Component;
			var toolTip:Component = tiggerToolTipMap[com] as Component;
			if(toolTip){
				if (toolTip == currentToolTip) {
					hideCustomToolTip();
				}
			}
		}
		
		private function onTriggerOverHandler(e:MouseEvent):void {
			var com:Component = e.currentTarget as Component;
			if (com) {
				var toolTip:Component = tiggerToolTipMap[com] as Component;
				if (toolTip) { 
					if (currentToolTip) {
						if (currentToolTip != toolTip) {
							this.main.removeChild(currentToolTip);
						}
					}
					currentToolTip = toolTip;
					this.timer.start();
				}
			}
		}
		
		private function showCustomToolTip():void{
			this.main.addChild(currentToolTip);
			DepthUtil.bringToTop(currentToolTip);
			currentToolTip.x = main.mouseX;
			currentToolTip.y = main.mouseY;
		}
		
		private function hideCustomToolTip():void {
			if (!this.timer.running) {
				this.main.removeChild(currentToolTip);
			}
			this.timer.reset();
			currentToolTip = null;
		}
		
		public static function getInstance():ToolTipManager {
			if (instance) {
				return instance;
			}
			instance = new ToolTipManager();
			return instance;
		}
		
	}

}