package org.libra.ui {
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import org.libra.geom.IntDimension;
	import org.libra.ui.interfaces.IButtonState;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public class BasicCheckState implements IButtonState {
		
		private var state:Shape;
		private var size:IntDimension;
		
		public function BasicCheckState() {
			state = new Shape();
			size = new IntDimension(1, 1);
		}
		
		/* INTERFACE org.libra.ui.interfaces.IButtonState */
		
		public function changeToNormal():void {
			state.graphics.clear();
			state.graphics.beginFill(0xff0000);
			state.graphics.drawRect(0, 0, size.getWidth(), size.getHeight());
			state.graphics.endFill();
		}
		
		public function changeToOver():void {
			
		}
		
		public function changeToUp():void {
			
		}
		
		public function changeToDown():void {
			
		}
		
		public function changeToDisable():void {
			state.graphics.clear();
			state.graphics.beginFill(0x000000);
			state.graphics.drawRect(0, 0, size.getWidth(), size.getHeight());
			state.graphics.endFill();
		}
		
		public function changeToSelected():void {
			state.graphics.clear();
			state.graphics.beginFill(0x0000ff);
			state.graphics.drawRect(0, 0, size.getWidth(), size.getHeight());
			state.graphics.endFill();
		}
		
		public function update(size:IntDimension):void {
			this.size = size;
		}
		
		public function getDisplayObject():DisplayObject {
			return this.state;
		}
		
		public function dispose():void {
			
		}
		
	}

}