package org.libra {
	import org.libra.basic.Component;
	import org.libra.basic.Container;
	import org.libra.geom.IntDimension;
	import org.libra.utils.JColor;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public class JFrame extends JPanel {
		
		private var titleBar:JFrameTitleBar;
		private var titleBarHeight:int;
		
		public function JFrame(owner:Container, modal:Boolean = false, titleBarHeight:int = 20) { 
			super(owner, modal);
			this.titleBarHeight = titleBarHeight;
			titleBar = new JFrameTitleBar(this);
		}
		
		override public function append(c:Component):Boolean {
			if (c is JFrame) {
				throw new Error("A JFrame can't be the other JFrame's parent!");
				return false;
			}
			return super.append(c);
		}
		
		override public function show():void {
			super.show();
			if (showing) {
				this.titleBar.show();
				this.titleBar.addDragListener();
			}
		}
		
		override public function tryToClose():void {
			super.tryToClose();
			if (!showing) {
				this.titleBar.removeDragListener();
			}
		}
		
		override public function setOpaque(b:Boolean):void {
			super.setOpaque(b);
			this.titleBar.setOpaque(b);
		}
		
		override public function setSize(size:IntDimension):void {
			super.setSize(size);
			this.titleBar.setSize(new IntDimension(size.getWidth(), titleBarHeight));
			if (isOpaque()) {
				paint();
			}
		}
		
		override public function paint():void {
			this.titleBar.paint();
			this.graphics.clear();
			this.addBorder(JColor.RED);
			this.graphics.beginFill(JColor.MAGENTA.getRGB());
			this.graphics.drawRect(0, 0, getWidth(), getHeight());
			this.graphics.endFill();
		}
		
		override public function toString():String {
			return "JFrame";
		}
		
	}

}