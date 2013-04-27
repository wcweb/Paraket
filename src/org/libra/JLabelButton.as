package org.libra {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.libra.events.LibraEvent;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public class JLabelButton extends JLabel {
		
		private var enable:Boolean;
		
		public function JLabelButton(text:String = "") {
			super(text);
			this.mouseChildren = this.mouseEnabled = true;
			enable = false;
			setEnable(true);
		}
		
		override protected function onAddToStageHandler(e:Event):void {
			super.onAddToStageHandler(e);
			this.addEventListener(MouseEvent.CLICK, onClickHandler);
		}
		
		override protected function onRemoveFromStageHandler(e:Event):void {
			super.onRemoveFromStageHandler(e);
			this.removeEventListener(MouseEvent.CLICK, onClickHandler);
		}
		
		public function addActionListener(listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void { 
			this.addEventListener(LibraEvent.BTN_CLICKRD, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeActionListener(listener:Function, useCapture:Boolean = false):void { 
			this.removeEventListener(LibraEvent.BTN_CLICKRD, listener, useCapture);
		}
		
		public function isEnable():Boolean {
			return this.enable;
		}
		
		public function setEnable(b:Boolean):void {
			if (this.enable != b) {
				this.enable = b;
				if (b) {
					this.buttonMode = true;
				}else {
					this.buttonMode = false;
				}
			}
		}
		
		private function onClickHandler(e:MouseEvent):void {
			if (enable) {
				dispatchEvent(new LibraEvent(LibraEvent.BTN_CLICKRD));
			}
		}
		
		override public function dispose():void {
			super.dispose();
			if (this.hasEventListener(MouseEvent.CLICK)) {
				this.removeEventListener(MouseEvent.CLICK, onClickHandler);
			}
		}
		
		override public function toString():String {
			return "JLabelButton:text = " + getText();
		}
		
	}

}