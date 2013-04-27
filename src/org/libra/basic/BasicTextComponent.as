package org.libra.basic {
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import org.libra.geom.IntDimension;
	import org.libra.geom.IntPoint;
	import org.libra.utils.JColor;
	import org.libra.utils.JFont;
	
	/**
	 * Text文本父类
	 * @author Eddie
	 */
	public class BasicTextComponent extends Component {
		
		/**
		 * 文本组件，flash自带的
		 */
		protected var textField:TextField;
		
		/**
		 * 构造函数
		 * @param	text 文本内容 String
		 */
		public function BasicTextComponent(text:String = "") {
			super();
			initTextField(text);
			this.addChild(textField);
		}
		
		/**
		 * 初始化TextField组件，子类可重写该方法，进行个性化初始化
		 * @param	text 文本内容 String
		 */
		protected function initTextField(text:String):void {
			if (!textField) {
				textField = new TextField();
				textField.multiline = false;
			}
			textField.text = text;
		}
		
		/**
		 * 设置文本内容
		 * @param	text String
		 */
		public function setText(text:String):void {
			textField.text = text;
		}
		
		/**
		 * 获取文本内容
		 * @return String
		 */
		public function getText():String {
			return this.textField.text;
		}
		
		/**
		 * 增加文本内容，效率上比setText()要好
		 * @param	text String
		 */
		public function appendText(text:String):void {
			this.textField.appendText(text);
		}
		
		/**
		 * 设置HTML文本
		 * @param	text String
		 */
		public function setHtmlText(text:String):void {
			this.textField.htmlText = text;
		}
		
		/**
		 * 获取HTML文本
		 * @return String
		 */
		public function getHtmlText():String {
			return this.textField.htmlText;
		}
		
		/**
		 * 重写setSize()，在设置组件大小时，将TextField也设置其宽高。
		 * @param	size IntDimension
		 * @see org.libra.geom.IntDimension
		 */
		override public function setSize(size:IntDimension):void {
			super.setSize(size);
			this.textField.width = size.getWidth();
			this.textField.height = size.getHeight();
		}
		
		/**
		 * 获取文本长度
		 * @return int
		 */
		public function getLength():int{
			return textField.length;
		}
		
		/**
		 * 设置文本最长长度
		 * @param	n int
		 */
		public function setMaxChars(n:int):void{
			textField.maxChars = n;
		}
		
		/**
		 * 获取文本最长长度
		 * @return int
		 */
		public function getMaxChars():int{
			return textField.maxChars;
		}
		
		/**
		 * 设置文本是否自动换行
		 * @param	b true：自动换行；flase：不自动换行
		 */
		public function setWordWrap(b:Boolean):void{
			textField.wordWrap = b;
		}
		
		/**
		 * 获取文本是否自动换行
		 * @return true or false
		 */
		public function isWordWrap():Boolean{
			return textField.wordWrap;
		}
		
		/**
		 * 设置文本字体，每次将Textfield的text重置时，Textfield都会将其TextFormat设置为默认的TextFormat，
		 * 所以该方法修改的不仅仅是Textfield的TextFormat，还有defaultTextFormat
		 * @param	font
		 */
		public function setFont(font:JFont):void {
			this.textField.setTextFormat(font.getTextFormat());
			this.textField.defaultTextFormat = font.getTextFormat();
		}
		
		/**
		 * 获取文本控件
		 * @return flash.text.TextField
		 */
		public function getTextField():TextField {
			return this.textField;
		}
		
		/**
		 * 设置前景色，即文本字体颜色
		 * @param	c JColor
		 * @see org.libra.utils.JColor
		 */
		override public function setForeground(c:JColor):void {
			super.setForeground(c);
			this.textField.textColor = c.getRGB();
			this.textField.alpha = c.getAlpha();
		}
		
		/**
		 * 设置文本滤镜
		 * @param	fs 滤镜数组
		 */
		public function setTextFilters(fs:Array):void{
			this.textField.filters = fs;
		}
		
		/**
		 * 获取文本滤镜
		 * @return Array，滤镜数组
		 */
		public function getTextFilters():Array {
			return this.textField.filters;
		}
		
		/**
		 * 设置文本坐标
		 * @param	offset IntPoint类型 相对于组件左上角顶点的偏移坐标，实际上也就是Textfield的坐标
		 * @see org.libra.geom.IntPoint
		 */
		public function setTextOffset(offset:IntPoint):void {
			this.textField.x = offset.getX();
			this.textField.y = offset.getY();
		}
		
		/**
		 * 获取文本坐标
		 * @return IntPoint类型
		 * @see org.libra.geom.IntPoint
		 */
		public function getTextOffset():IntPoint {
			return new IntPoint(textField.x, textField.y);
		}
		
		override public function pack():void {
			this.textField.autoSize = TextFieldAutoSize.LEFT;
			super.setSize(new IntDimension(textField.width, textField.height));
		}
		
		override public function toString():String {
			return "BasicTextComponent";
		}
	}

}