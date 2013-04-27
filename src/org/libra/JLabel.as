package org.libra {
	import org.libra.basic.BasicTextComponent;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public class JLabel extends BasicTextComponent {
		
		public function JLabel(text:String = "") {
			super(text);
			this.mouseChildren = this.mouseEnabled = false;
		}
		
		override protected function initTextField(text:String):void {
			super.initTextField(text);
			textField.mouseEnabled = false;
			textField.selectable = false;
		}
		
		override public function toString():String {
			return "JLabel:text = " + getText();
		}
		
	}

}