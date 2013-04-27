package org.libra.managers {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.utils.Dictionary;
	import org.libra.basic.Component;
	import org.libra.utils.DepthUtil;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public final class CursorManager {
		
		private static var instance:CursorManager = null;
		private var main:DisplayObjectContainer;
		private var tiggerCursorMap:Dictionary;
		private var currentCursor:DisplayObject;
		private var cursorHolder:Sprite;
		
		public function CursorManager() {
			this.main = LibraManager.getInstance().getMain();
			tiggerCursorMap = new Dictionary(true);
		}
		
		public function setCursor(component:Component, cursor:DisplayObject = null):void {
			if (cursor) {
				if (!tiggerCursorMap[component]) {
					component.addEventListener(MouseEvent.ROLL_OVER, onTriggerOverHandler, false, 0, true);
					component.addEventListener(MouseEvent.ROLL_OUT, onTriggerOutHandler, false, 0, true);
					//component.addEventListener(MouseEvent.MOUSE_UP, onTriggerUpHandler, false, 0, true);
				}
				tiggerCursorMap[component] = cursor;
			}else {
				if (tiggerCursorMap[component]) {
					component.removeEventListener(MouseEvent.ROLL_OVER, onTriggerOverHandler, false);
					component.removeEventListener(MouseEvent.ROLL_OUT, onTriggerOutHandler, false);
					//component.removeEventListener(MouseEvent.MOUSE_UP, onTriggerUpHandler, false);
					delete tiggerCursorMap[component];
				}
			}
		}
		
		//private function onTriggerUpHandler(e:MouseEvent):void {
			//
		//}
		
		private function onTriggerOutHandler(e:MouseEvent):void {
			var com:Component = e.currentTarget as Component;
			var cursor:DisplayObject = tiggerCursorMap[com] as DisplayObject;
			if(cursor){
				hideCustomCursor(cursor);
			}
		}
		
		private function onTriggerOverHandler(e:MouseEvent):void {
			var com:Component = e.currentTarget as Component;
			if (com) {
				var cursor:DisplayObject = tiggerCursorMap[com] as DisplayObject;
				if(cursor && !e.buttonDown){
					showCustomCursor(cursor);
				}
			}
		}
		
		private function showCustomCursor(cursor:DisplayObject):void{
			Mouse.hide();
			if(!cursorHolder){
				cursorHolder = new Sprite();
				cursorHolder.mouseEnabled = cursorHolder.tabEnabled = cursorHolder.mouseChildren = false;
				this.main.addChild(cursorHolder);
			}
			if(currentCursor != cursor){
				if(currentCursor){
					cursorHolder.removeChild(currentCursor);
				}
				currentCursor = cursor;
				cursorHolder.addChild(currentCursor);
			}
			DepthUtil.bringToTop(cursorHolder);
			onMouseMoveHandler(null);
			this.main.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler, false, 0, true);
		}
		
		private function hideCustomCursor(cursor:DisplayObject):void{
			if (cursor == currentCursor) { 
				if (cursorHolder) { 
					if (currentCursor) { 
						cursorHolder.removeChild(currentCursor);
					}
				}
				currentCursor = null;
				Mouse.show();
				this.main.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
			}
		}
		
		private function onMouseMoveHandler(e:MouseEvent):void {
			cursorHolder.x = cursorHolder.parent.mouseX;
			cursorHolder.y = cursorHolder.parent.mouseY;
			DepthUtil.bringToTop(cursorHolder);
		}
		
		public static function getInstance():CursorManager {
			if (instance) {
				return instance;
			}
			instance = new CursorManager();
			return instance;
		}
		
	}

}