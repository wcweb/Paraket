package org.libra {
	import org.libra.basic.BasicButton;
	
	/**
	 * 按钮
	 * @example
	 * var b:JButton = new JButton("btn");
	 * b.setSize(new IntDimension(56,23));
	 * b.setLocation(new intPoint(50,50));
	 * b.addActionListener(onClicked);
	 * jpanel.append(b);
	 * 
	 * private function onClicked(evt:LibraEvent):void{
	 * 	trace("b is be clicked");
	 * }
	 * 
	 * @author Eddie
	 */
	public class JButton extends BasicButton {
		
		/**
		 * 构造方法
		 * @param	text 按钮上的文字
		 */
		public function JButton(text:String = "") {
			super(text);
		}
		
		override public function toString():String {
			return "JButton";
		}
		
	}

}