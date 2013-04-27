package org.libra.managers {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.libra.basic.Component;
	import org.libra.basic.Container;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public final class DragManager {
		
		public static var isDraging:Boolean = false;
		
		/**
		 * 文档类
		 */
		private static var main:DisplayObjectContainer;
		
		private static var dragSprite:Sprite;
		private static var dragBitmap:Bitmap;
		private static var dragInitiator:Component;
		private static var dropable:Boolean;
		private static var startPoint:Point;
		private static var speed:Number = .25;
		
		public function DragManager() {
			throw new Error("DragManager can not be instance!");
		}
		
		public static function setMain(main:DisplayObjectContainer):void {
			DragManager.main = main;
			dragSprite = new Sprite();
			dragSprite.mouseEnabled = false;
			dragBitmap = new Bitmap();
			dragSprite.addChild(dragBitmap);
		}
		
		public static function startDrag(dragInitiator:Component):void {
			if (isDraging) {
				return;
			}
			DragManager.dragInitiator = dragInitiator;
			isDraging = true;
			dragBitmap.bitmapData = dragInitiator.getDragBmd();
			dropable = true;
			setDropable(false);
			startPoint = dragInitiator.localToGlobal(new Point());
			dragSprite.x = startPoint.x;
			dragSprite.y = startPoint.y;
			main.addChild(dragSprite);
			dragSprite.startDrag();
			main.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			main.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
		}
		
		public static function stopDrag():void {
			if (isDraging) {
				main.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
				main.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
				dragSprite.stopDrag();
				playMotion();
			}
		}
		
		static private function playMotion():void {
			if (dropable) {
				main.removeChild(dragSprite);
				isDraging = false;
			}else {
				dragSprite.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			}
		}
		
		static private function onEnterFrameHandler(e:Event):void {
			var p:Point = main.localToGlobal(new Point(dragSprite.x, dragSprite.y));
			p.x += (startPoint.x - p.x) * speed;
			p.y += (startPoint.y - p.y) * speed;
			if (Point.distance(p, startPoint) < 2) { 
				dragSprite.removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
				dragSprite.alpha = 1;
				main.removeChild(dragSprite);
				isDraging = false;
				return;
			}
			dragSprite.x = p.x;
			dragSprite.y = p.y;
		}
		
		static private function onMouseUpHandler(e:MouseEvent):void {
			stopDrag();
		}
		
		static private function onMouseMoveHandler(e:MouseEvent):void {
			var container:Container = getAcceptContainer(new Point(e.stageX, e.stageY));
			if (container) {
				setDropable(true);
			}else {
				setDropable(false);
			}
		}
		
		private static function getAcceptContainer(pos:Point):Container {
			var targets:Array = main.stage.getObjectsUnderPoint(pos);
			var n:int = targets.length;
			for (var i:int = n - 1; i >= 0; i--) { 
				var tar:DisplayObject = targets[i];
				if (tar is Container) { 
					var con:Container = tar as Container;
					if (con.isDragAcceptableInitiator(dragInitiator)) {
						return con;
					}
				}
			}
			return null;
		}
		
		private static function setDropable(b:Boolean):void { 
			if (dropable != b) {
				dropable = b;
				if (b) {
					dragSprite.alpha = 1;
				}else {
					dragSprite.alpha = .5;
				}
			}
		}
		
	}

}