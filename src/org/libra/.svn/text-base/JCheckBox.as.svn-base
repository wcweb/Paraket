package org.libra {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.libra.basic.BasicButton;
	import org.libra.geom.IntDimension;
	import org.libra.ui.BasicCheckState;
	import org.libra.ui.interfaces.IButtonState;
	import org.libra.utils.CheckBoxGroup;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public class JCheckBox extends BasicButton {
		
		protected var selected:Boolean;
		protected var checkBoxGroup:CheckBoxGroup;
		
		public function JCheckBox(text:String = "", selected:Boolean = false) { 
			super(text);
			this.selected = selected;
		}
		
		override protected function initState():void {
			this.setState(new BasicCheckState());
		}
		
		override public function addActionListener(listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			this.addEventListener(MouseEvent.CLICK, listener, useCapture, priority, useWeakReference);
		}
		
		override public function removeActionListener(listener:Function, useCapture:Boolean = false):void {
			this.removeEventListener(MouseEvent.CLICK, listener, useCapture);
		}
		
		override protected function onAddToStageHandler(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStageHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStageHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseHandler);
			updateState();
		}
		
		override protected function onRemoveFromStageHandler(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStageHandler);
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStageHandler);
			this.removeEventListener(MouseEvent.MOUSE_UP, onMouseHandler);
		}
		
		override protected function onMouseHandler(e:MouseEvent):void {
			if (isEnable()) {
				changeSelected();
			}
		}
		
		protected function updateState():void {
			if (isEnable()) {
				if (selected) {
					this.stateModel.changeToSelected();
				}else {
					this.stateModel.changeToNormal();
				}
				if (hasCheckBoxGroup()) {
					this.checkBoxGroup.setOtherSelected(!selected, this);
				}
			}else {
				this.stateModel.changeToDisable();
			}
		}
		
		public function setSelectedAlone(selected:Boolean):void {
			if (this.selected != selected) {
				if (selected) {
					this.stateModel.changeToSelected();
				}else {
					this.stateModel.changeToNormal();
				}
				this.selected = selected;
			}
		}
		
		override public function setState(state:IButtonState):void {
			if (this.stateModel) {
				this.stateModel.dispose();
			}
			this.stateModel = state;
			this.stateModel.update(this.getSize());
			this.setBackgroundChild(this.stateModel.getDisplayObject());
			if (isEnable()) {
				if (this.selected) {
					this.stateModel.changeToSelected();
				}else {
					this.stateModel.changeToNormal();
				}
			}else {
				this.stateModel.changeToDisable();
			}
		}
		
		private function changeSelected():void {
			if (hasCheckBoxGroup()) {
				if (this.selected) {
					return;
				}
			}
			this.selected = !this.selected;
			updateState();
		}
		
		public function setTfOffset(x:int, y:int):void {
			this.textField.x = x;
			this.textField.y = y;
		}
		
		public function setSelected(selected:Boolean):void {
			if (this.selected == selected) {
				return;
			}
			this.selected = selected;
			this.updateState();
		}
		
		public function isSelected():Boolean {
			return this.selected;
		}
		
		public function setCheckBoxGroup(bg:CheckBoxGroup):void {
			this.checkBoxGroup = bg;
		}
		
		public function getCheckBoxGroup():CheckBoxGroup {
			return this.checkBoxGroup;
		}
		
		public function hasCheckBoxGroup():Boolean {
			return this.checkBoxGroup != null;
		}
		
		override public function toString():String {
			return "JCheckBox";
		}
		
	}

}