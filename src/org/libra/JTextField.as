package org.libra {
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextFieldType;
	import org.libra.basic.BasicTextComponent;
	import org.libra.events.LibraEvent;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public class JTextField extends BasicTextComponent {
		
		/**
		 * 绘制焦边框的Shape
		 */
		private var focusShape:Shape;
		
		public function JTextField(text:String = "") {
			super(text);
			focusShape = new Shape();
			this.addChild(focusShape);
		}
		
		override protected function initTextField(text:String):void {
			super.initTextField(text);
			textField.type = TextFieldType.INPUT;
		}
		
		/**
		 * 重写添加到舞台后的方法
		 * @param	e
		 */
		override protected function onAddToStageHandler(e:Event):void {
			super.onAddToStageHandler(e);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			textField.addEventListener(FocusEvent.FOCUS_IN, onFocusInHandler);
			textField.addEventListener(FocusEvent.FOCUS_OUT,onFocusOutHandler);
		}
		
		/**
		 * 重写从舞台上移除后的方法
		 * @param	e
		 */
		override protected function onRemoveFromStageHandler(e:Event):void {
			super.onRemoveFromStageHandler(e);
			removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			textField.removeEventListener(FocusEvent.FOCUS_IN, onFocusInHandler);
			textField.removeEventListener(FocusEvent.FOCUS_OUT,onFocusOutHandler);
		}
		
		/**
		 * 鼠标按下时，取消因获得焦点而生成的焦点边框，
		 * 即调用onFocusOutHandler()
		 * @param	e
		 * @see onFocusOutHandler
		 */
		protected function onMouseDownHandler(e:MouseEvent):void {
			onFocusOutHandler(null);
		}
		
		/**
		 * 当失去焦点后，取消因获得焦点而生成的焦点边框。
		 * @param	e
		 */
		private function onFocusOutHandler(e:FocusEvent):void {
			focusShape.graphics.clear();
			dispatchEvent(new LibraEvent(LibraEvent.LOST_FOCUS));
		}
		
		/**
		 * 当获得焦点后，绘制焦点边框。
		 * @param	e
		 */
		private function onFocusInHandler(e:FocusEvent):void {
			focusShape.graphics.clear();
			focusShape.graphics.lineStyle(.5, 0xff0000);
			focusShape.graphics.moveTo(0, 0);
			focusShape.graphics.lineTo(getWidth(), 0);
			focusShape.graphics.lineTo(getWidth(), getHeight());
			focusShape.graphics.lineTo(0, getHeight());
			focusShape.graphics.lineTo(0, 0);
			dispatchEvent(new LibraEvent(LibraEvent.GET_FOCUS));
		}
		
		public function setDisplayAsPassword(b:Boolean):void{
			textField.displayAsPassword = b;
		}
		
		public function isDisplayAsPassword():Boolean{
			return textField.displayAsPassword;
		}
		
		public function addInputListener(listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void { 
			this.textField.addEventListener(TextEvent.TEXT_INPUT, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeInputListener(listener:Function, useCapture:Boolean = false):void { 
			this.textField.removeEventListener(TextEvent.TEXT_INPUT, listener, useCapture);
		}
		
		override public function toString():String {
			return "JTextField:text = " + getText();
		}
		
	}

}