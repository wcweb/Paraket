package org.libra {
	import flash.display.DisplayObjectContainer;
	import org.libra.basic.Container;
	import org.libra.managers.LibraManager;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public class JWindow extends Container {
		
		protected var active:Boolean;
		protected var activeable:Boolean;
		private var owner:DisplayObjectContainer;
		protected var showing:Boolean;
		
		public function JWindow(owner:DisplayObjectContainer = null) {
			super();
			if (owner) {
				this.owner = owner;
			}else {
				this.owner = LibraManager.getInstance().getMain();
			}
			showing = false;
			active = false;
			activeable = true;
		}
		
		public function isShowing():Boolean {
			return this.showing;
		}
		
		public function show():void {
			if (showing) {
				return;
			}
			this.owner.addChild(this);
			showing = true;
		}
		
		public function tryToClose():void {
			if (showing) {
				this.owner.removeChild(this);
				showing = false;
			}
		}
		
		public function isActiveable():Boolean {
			return this.activeable;
		}
		
		public function setActiveable(b:Boolean):void {
			this.activeable = b;
		}
		
		public function isActive():Boolean {
			if (!isActiveable()) {
				return false;
			}
			return this.active;
		}
		
		public function setActive(b:Boolean):void {
			if (active != b) {
				if (isActiveable()) {
					this.active = b;
				}else {
					this.active = false;
				}
			}
		}
		
		override public function toString():String {
			return "JWindow";
		}
		
	}

}