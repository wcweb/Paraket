package org.libra.ui {
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import org.libra.geom.IntDimension;
	import org.libra.ui.interfaces.IButtonState;
	import org.libra.ui.interfaces.IScrollPanelState;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public class BasicScrollPanelState implements IScrollPanelState {
		
		private var upArrowState:IButtonState;
		private var downArrowState:IButtonState;
		private var thumnState:IButtonState;
		private var state:Shape;
		private var size:IntDimension;
		
		public function BasicScrollPanelState() {
			state = new Shape();
			upArrowState = new BasicButtonState();
			downArrowState = new BasicButtonState();
			thumnState = new BasicButtonState();
			this.size = new IntDimension(1, 1);
		}
		
		/* INTERFACE org.libra.ui.interfaces.IScrollPanelState */
		
		public function getUpArrowState():IButtonState {
			return this.upArrowState;
		}
		
		public function getDownArrowState():IButtonState {
			return this.downArrowState;
		}
		
		public function getThunmState():IButtonState {
			return this.thumnState;
		}
		
		public function changeToNormal():void {
			this.state.graphics.clear();
			this.state.graphics.beginFill(0x234567);
			this.state.graphics.drawRect(0, 0, size.getWidth(), size.getHeight());
			this.state.graphics.endFill();
		}
		
		public function changeToOver():void {
			this.state.graphics.clear();
			this.state.graphics.beginFill(0x765432);
			this.state.graphics.drawRect(0, 0, size.getWidth(), size.getHeight());
			this.state.graphics.endFill();
		}
		
		public function changeToAllNormal():void {
			this.changeToNormal();
			this.upArrowState.changeToNormal();
			this.downArrowState.changeToNormal();
			this.thumnState.changeToNormal();
		}
		
		public function getDisplayObject():DisplayObject {
			return this.state;
		}
		
		public function update(size:IntDimension):void {
			this.size = size;
		}
		
		public function dispose():void {
			
		}
		
	}

}