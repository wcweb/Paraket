package org.libra.ui {
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import org.libra.geom.IntDimension;
	import org.libra.ui.interfaces.IButtonState;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public class BasicButtonState implements IButtonState {
		
		protected var state:Shape;
		protected var stateSize:IntDimension;
		
		public function BasicButtonState() {
			state = new Shape();
		}
		
		/* INTERFACE org.libra.ui.interfaces.IButtonState */
		
		public function changeToNormal():void {
			drawState(0xff0000);
		}
		
		public function changeToOver():void {
			drawState(0x00ff00);
		}
		
		public function changeToUp():void {
			changeToOver();
		}
		
		public function changeToDown():void {
			changeToNormal();
		}
		
		public function changeToDisable():void {
			drawState(0x000000);
		}
		
		public function changeToSelected():void {
			changeToOver();
		}
		
		public function getDisplayObject():DisplayObject {
			return this.state;
		}
		
		public function update(size:IntDimension):void {
			this.stateSize = size;
		}
		
		private function drawState(color:int):void { 
			state.graphics.clear();
			state.graphics.beginFill(color);
			state.graphics.drawRect(0, 0, this.stateSize.getWidth(), this.stateSize.getHeight());
			state.graphics.endFill();
		}
		
		public function dispose():void {
			
		}
		
	}

}