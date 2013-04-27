package org.libra.ui {
	import flash.display.Shape;
	import org.libra.basic.Component;
	import org.libra.geom.IntDimension;
	import org.libra.JLabel;
	import org.libra.ui.interfaces.IListItem;
	import org.libra.utils.JColor;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public class BasicListItem extends JLabel implements IListItem {
		
		private var state:Shape;
		
		public function BasicListItem(text:String) {
			super(text);
			//this.setSize(new IntDimension(320, 18));
			state = new Shape();
			this.setBackgroundChild(state);
			changeToNormal();
		}
		
		private function createState(color:JColor):void {
			this.state.graphics.clear();
			this.state.graphics.beginFill(color.getRGB());
			this.state.graphics.drawRect(0, 0, this.getWidth(), this.getHeight());
			this.state.graphics.endFill();
		}
		
		/* INTERFACE org.libra.interfaces.IListItem */
		
		public function getCell():Component {
			return this;
		}
		
		public function changeToNormal():void {
			createState(JColor.HALO_ORANGE);
		}
		
		public function changeToOver():void {
			createState(JColor.LIGHT_GRAY)
		}
		
		public function changeToDown():void {
			
		}
		
		public function changeToUp():void {
			
		}
		
		public function changeToSelected():void {
			
		}
		
		public function update(size:IntDimension):void {
			this.setSize(size);
		}
		
		public function getData():String {
			return getText();
		}
		
	}

}