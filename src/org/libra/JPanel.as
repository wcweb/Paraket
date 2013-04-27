package org.libra {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.libra.basic.Container;
	import org.libra.managers.LibraManager;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public class JPanel extends JWindow {
		
		public static const CLICKED:String = "clicked";
		protected var owner:Container;
		private var defaultButton:JButton;
		private var modal:Boolean;
		
		public function JPanel(owner:Container, modal:Boolean = false) { 
			super();
			this.owner = owner;
			this.modal = modal;
			this.setMasked(true);
		}
		
		override public function show():void {
			if (!showing) {
				this.showing = this.owner.append(this);
				if (this.showing) {
					this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
					LibraManager.getInstance().addPanel(this);
					if (!isDrawedMe()) {
						drawMe();
					}
				}
			}
		}
		
		override public function tryToClose():void {
			if (showing) {
				this.showing = !this.owner.remove(this);
				if (!this.showing) {
					this.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
					LibraManager.getInstance().removePanel(this);
				}
			}
		}
		
		private function onMouseDownHandler(e:MouseEvent):void {
			if (e.currentTarget == this) {
				dispatchEvent(new Event(CLICKED));
			}
		}
		
		public function setDefaultButton(b:JButton):void {
			if (this.hasComponent(b)) {
				this.defaultButton = b;
			}
		}
		
		public function getDefaultButton():JButton {
			return this.defaultButton;
		}
		
		override public function setActiveable(b:Boolean):void {
			super.setActiveable(b);
			LibraManager.getInstance().addPanel(this);
		}
		
		public function isModal():Boolean {
			return this.modal;
		}
		
		public function setModal(b:Boolean):void {
			if (this.modal != b) {
				this.modal = b;
			}
		}
		
		override public function toString():String {
			return "JPanel";
		}
		
	}

}