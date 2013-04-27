package org.libra {
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import org.libra.geom.IntDimension;
	import org.libra.managers.LibraManager;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public class JFrameTitleBar extends JPanel {
		
		private var frame:JFrame;
		private var dragBounds:Rectangle;
		
		public function JFrameTitleBar(f:JFrame) {
			super(f);
			this.frame = f;
			activeable = false;
		}
		
		public function setFrame(f:JFrame):void {
			if (f == frame) {
				return;
			}
			this.frame = f;
		}
		
		public function addDragListener():void {
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
		}
		
		public function removeDragListener():void {
			this.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
		}
		
		private function onMouseUpHandler(e:MouseEvent):void {
			this.frame.stopDrag();
		}
		
		private function onMouseDownHandler(e:MouseEvent):void {
			this.frame.startDrag(false, dragBounds);
		}
		
		override public function setSize(size:IntDimension):void {
			super.setSize(size);
			
			if (!this.dragBounds) {
				this.dragBounds = new Rectangle();
			}
			dragBounds.x = 20 - size.getWidth();
			dragBounds.y = 0;
			var stage:Stage = owner.stage ? owner.stage : LibraManager.getInstance().getStage();
			dragBounds.width = stage.stageWidth + (size.getWidth() << 1) - 40;
			dragBounds.height = stage.stageHeight - 20;
			this.graphics.beginFill(0x000000, 0);
			this.graphics.drawRect(0, 0, getWidth(), getHeight());
			this.graphics.endFill();
		}
		
		override public function paint():void {
			this.graphics.clear();
			this.graphics.beginFill(0x000000, 1);
			this.graphics.drawRect(0, 0, getWidth(), getHeight());
			this.graphics.endFill();
		}
		
		override public function toString():String {
			return "JFrameTitleBar";
		}
		
	}

}