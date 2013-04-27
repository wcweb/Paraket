package org.libra.basic {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import org.libra.events.LibraEvent;
	import org.libra.geom.IntDimension;
	import org.libra.geom.IntPoint;
	import org.libra.ui.BasicButtonState;
	import org.libra.ui.interfaces.IButtonState;
	import org.libra.utils.JColor;
	import org.libra.utils.JFont;
	
	/**
	 * 按钮的父类
	 * @author Eddie
	 */
	public class BasicButton extends Component {
		
		/**
		 * 按钮状态
		 * @see org.libra.ui.interfaces.IButtonState
		 */
		protected var stateModel:IButtonState;
		
		/**
		 * 按钮文字，TextField组件
		 */
		protected var textField:TextField;
		
		/**
		 * 按钮按下时响应的事件
		 */
		private var clickFun:Function;
		
		/**
		 * 是否可用
		 */
		private var enable:Boolean;
		
		private var action:Boolean;
		
		public function BasicButton(text:String) {
			super();
			enable = true;
			initState();
			initTextField(text);
			this.addChild(textField);
			action = false;
		}
		
		/**
		 * 初始化按钮文字组件
		 * 子类可以重写该方法，进行个性初始化
		 * @param	text 按钮内容
		 */
		protected function initTextField(text:String):void {
			if (!this.textField) {
				this.textField = new TextField();
			}
			textField.text = text;
			textField.mouseEnabled = false;
			textField.selectable = false;
			textField.tabEnabled = false;
			textField.multiline = false;
		}
		
		/**
		 * 初始化按钮状态
		 * 子类可以重写该方法，进行自定义初始化
		 * 状态类必须继承IButtonState接口，实现接口内所有方法
		 * @see org.libra.ui.interfaces.IButtonState
		 */
		protected function initState():void {
			this.setState(new BasicButtonState());
		}
		
		/**
		 * 重写添加到舞台后的方法
		 * @param	e
		 */
		override protected function onAddToStageHandler(e:Event):void {
			super.onAddToStageHandler(e);
			this.addEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
			this.addEventListener(MouseEvent.ROLL_OVER, onRollOverHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseHandler);
			this.addEventListener(MouseEvent.CLICK, onClickHandler);
			if (enable) {
				this.stateModel.changeToNormal();
			}else {
				this.stateModel.changeToDisable();
			}
		}
		
		/**
		 * 重写从舞台上移除的方法
		 * @param	e
		 */
		override protected function onRemoveFromStageHandler(e:Event):void {
			super.onRemoveFromStageHandler(e);
			this.removeEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
			this.removeEventListener(MouseEvent.ROLL_OVER, onRollOverHandler);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseHandler);
			this.removeEventListener(MouseEvent.MOUSE_UP, onMouseHandler);
			this.removeEventListener(MouseEvent.CLICK, onClickHandler);
		}
		
		/**
		 * 添加鼠标按下、鼠标弹起和鼠标点击事件
		 * @param	listener 鼠标点击后响应的方法，该方法有一个类型为MouseEvent的参数
		 * @param	useCapture 默认为false。 确定侦听器是运行于捕获阶段、目标阶段还是冒泡阶段。 
		 * 如果将 useCapture 设置为 true，则侦听器只在捕获阶段处理事件，而不在目标或冒泡阶段处理事件。 
		 * 如果 useCapture 为 false，则侦听器只在目标或冒泡阶段处理事件。 
		 * 要在所有三个阶段都侦听事件，请调用两次 addEventListener，一次将 useCapture 设置为 true，
		 * 第二次再将 useCapture 设置为 false。
		 * @param	priority 事件侦听器的优先级。 优先级由一个带符号的 32 位整数指定。 
		 * 数字越大，优先级越高。 优先级为 n 的所有侦听器会在优先级为 n -1 的侦听器之前得到处理。 
		 * 如果两个或更多个侦听器共享相同的优先级，则按照它们的添加顺序进行处理。 默认优先级为 0。 
		 * @param	useWeakReference 确定对侦听器的引用是强引用，还是弱引用。 
		 * 强引用（默认值）可防止您的侦听器被当作垃圾回收。 弱引用则没有此作用。
		 */
		public function addActionListener(listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void { 
			if (!action) {
				this.addEventListener(LibraEvent.BTN_CLICKRD, listener, useCapture, priority, useWeakReference);
				this.clickFun = listener;
				action = true;
			}
		}
		
		/**
		 * 移除鼠标按下、鼠标弹起和鼠标点击事件
		 * @param	listener 鼠标点击响应的事件
		 * @param	useCapture @see addActionListener
		 */
		public function removeActionListener(listener:Function, useCapture:Boolean = false):void { 
			if (action) {
				this.removeEventListener(LibraEvent.BTN_CLICKRD, listener, useCapture);
				this.clickFun = null;
				action = false;
			}
		}
		
		public function hasActionListener():Boolean {
			return this.action;
		}
		
		/**
		 * 响应鼠标Click事件，发出自定义事件LibraEvent.BTN_CLICKRD
		 * @param	e
		 */
		private function onClickHandler(e:MouseEvent):void {
			if (enable) {
				dispatchEvent(new LibraEvent(LibraEvent.BTN_CLICKRD));
			}
		}
		
		/**
		 * 处理鼠标按下和鼠标弹起的事件
		 * @param	e MouseEvent
		 */
		protected function onMouseHandler(e:MouseEvent):void {
			if (enable) {
				switch(e.type) {
					case MouseEvent.MOUSE_UP:
						this.stateModel.changeToUp();
					break;
					case MouseEvent.MOUSE_DOWN:
						this.stateModel.changeToDown();
					break;
				}
			}else {
				this.stateModel.changeToDisable();
			}
		}
		
		/**
		 * 鼠标从组件外移动到组件内的事件
		 * @param	e MouseEvent
		 */
		protected function onRollOverHandler(e:MouseEvent):void {
			if (enable) {
				this.stateModel.changeToOver();
			}else {
				this.stateModel.changeToDisable();
			}
		}
		
		/**
		 * 鼠标从组件内移动组件外的事件 
		 * @param	e MouseEvent
		 */
		protected function onRollOutHandler(e:MouseEvent):void {
			if (enable) {
				this.stateModel.changeToNormal();
			}else {
				this.stateModel.changeToDisable();
			}
		}
		
		/**
		 * 重写设置大小的方法
		 * @param	size IntDimension
		 * @see org.libra.geom.IntDimension
		 */
		override public function setSize(size:IntDimension):void {
			super.setSize(size);
			this.stateModel.update(size);
			this.textField.width = size.getWidth();
			this.textField.height = size.getHeight();
		}
		
		/**
		 * 设置鼠标状态
		 * @param	state IButtonState，该类必须继承IButtonState接口
		 * @see org.libra.ui.interfaces.IButtonState
		 */
		public function setState(state:IButtonState):void {
			if (this.stateModel) {
				this.stateModel.dispose();
			}
			this.stateModel = state;
			this.stateModel.update(this.getSize());
			this.setBackgroundChild(this.stateModel.getDisplayObject());
			if (enable) {
				this.stateModel.changeToNormal();
			}else {
				this.stateModel.changeToDisable();
			}
		}
		
		/**
		 * 获取鼠标状态方法
		 * @return IButtonState
		 * @see org.libra.ui.interfaces.IButtonState
		 */
		public function getState():IButtonState {
			return this.stateModel;
		}
		
		/**
		 * 设置按钮文字字体
		 * @param	font JFont
		 * @see org.libra.utils.JFont
		 */
		public function setFont(font:JFont):void {
			this.textField.setTextFormat(font.getTextFormat());
			this.textField.defaultTextFormat = font.getTextFormat();
		}
		
		/**
		 * 获取按钮文字组件
		 * @return TextField
		 */
		public function getTextField():TextField {
			return this.textField;
		}
		
		/**
		 * 设置按钮文字
		 * @param	text String
		 */
		public function setText(text:String):void {
			this.textField.text = text;
		}
		
		/**
		 * 获取按钮文字
		 * @return String
		 */
		public function getText():String {
			return textField.text;
		}
		
		/**
		 * 设置文字组件的坐标，
		 * @param	off IntPoint，相对于组件左上角的偏移量
		 * @see org.libra.geom.IntPoint
		 */
		public function setTextOffset(off:IntPoint):void {
			this.textField.x = off.getX();
			this.textField.y = off.getY();
		}
		
		/**
		 * 获取文字组件坐标
		 * @return IntPoint
		 * @see org.libra.geom.IntPoint 
		 */
		public function getTextOffset():IntPoint {
			return new IntPoint(textField.x, textField.y);
		}
		
		/**
		 * 重写设置前景色方法
		 * @param	c JColor
		 * @see org.libra.utils.JColor
		 */
		override public function setForeground(c:JColor):void {
			super.setForeground(c);
			this.textField.textColor = c.getRGB();
			this.textField.alpha = c.getAlpha();
		}
		
		/**
		 * 设置文字滤镜
		 * @param	fs 滤镜数组
		 */
		public function setTextFilters(fs:Array):void{
			this.textField.filters = fs;
		}
		
		/**
		 * 获取文字滤镜
		 * @return Array，滤镜数组
		 */
		public function getTextFilters():Array {
			return this.textField.filters;
		}
		
		/**
		 * 设置按钮是否可用
		 * @param	b true or false
		 */
		public function setEnable(b:Boolean):void {
			if (enable != b) {
				if (b) {
					this.stateModel.changeToNormal();
				}else {
					this.stateModel.changeToDisable();
				}
				this.enable = b;
			}
		}
		
		/**
		 * 获取按钮是否可用
		 * @return true or false
		 */
		public function isEnable():Boolean {
			return this.enable;
		}
		
		/**
		 * 执行按钮按下时响应的事件
		 */
		public function doClick():void {
			if (clickFun != null) {
				clickFun.call(this, null);
			}
		}
		
		/**
		 * 自动生成最小的大小
		 */
		override public function pack():void {
			this.textField.autoSize = TextFieldAutoSize.LEFT;
			var size:IntDimension = new IntDimension(textField.width, textField.height);
			super.setSize(size);
			this.stateModel.update(size);
		}
		
		override public function toString():String {
			return "BasicButton";
		}
		
	}

}