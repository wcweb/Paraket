package org.libra.basic {
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.libra.geom.IntDimension;
	import org.libra.geom.IntPoint;
	import org.libra.geom.IntRectangle;
	import org.libra.managers.DragManager;
	import org.libra.managers.ToolTipManager;
	import org.libra.utils.JColor;
	
	
	/**
	 * 组件类，继承自BasicSprite
	 * 定义了所有组件需要用到的基本属性和方法
	 * @author Eddie
	 */
	public class Component extends BasicSprite {
		
		/**
		 * 组件外围界限
		 */
		private var bounds:IntRectangle;
		
		/**
		 * 字体颜色
		 */
		private var foreground:JColor;
		
		/**
		 * 不透明，组件默认不透明，
		 * 即将调用paint()进行组件的绘制，
		 * 如果需要用到自定义皮肤时，可将该值设置为true，
		 */
		private var opaque:Boolean;
		
		/**
		 * 绘制边界的图形
		 */
		private var borderShape:Shape;
		
		/**
		 * 是否要绘制边框，默认为false
		 */
		private var borderable:Boolean;
		
		/**
		 * 边框的颜色
		 */
		private var borderColor:JColor;
		
		/**
		 * 组件遮罩
		 */
		private var maskShape:Shape;
		
		/**
		 * 是否需要遮罩，默认为false
		 */
		private var masked:Boolean;
		
		/**
		 * 是否使用资源文件对组件进行了绘制
		 */
		private var drawedMe:Boolean;
		
		/**
		 * 是否支持拖放
		 */
		private var dragable:Boolean;
		
		/**
		 * 拖放时，呈现的图案的bitmapData
		 */
		private var dragBmd:BitmapData;
		
		private var toolTip:Component;
		
		/**
		 * 构造方法
		 * 当new的时候就侦听添加进显示列表的事件，
		 * 在事件方法中进行其他的初始化。
		 * 这样避免了一些new过的但是不在舞台上的组件的多余的事件监听。
		 */
		public function Component() {
			super();
			bounds = new IntRectangle();
			//取消flash默认的焦点边框
			this.focusRect = false;
			opaque = true;
			borderShape = new Shape();
			this.addChild(borderShape);
			borderable = false;
			borderColor = JColor.HALO_GREEN;
			masked = false;
			dragable = false;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStageHandler);
		}
		
		/**
		 * 添加到舞台后
		 * 子类可以重写该方法，进行个性化定义
		 * @param	e
		 */
		protected function onAddToStageHandler(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStageHandler);
		}
		
		/**
		 * 从舞台上移除后
		 * 子类可以重写该方法，进行将不需要监听的事件移除等操作
		 * @param	e
		 */
		protected function onRemoveFromStageHandler(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStageHandler);
			addEventListener(Event.ADDED_TO_STAGE, onAddToStageHandler);
		}
		
		public function pack():void {
			
		}
		
		/**
		 * 设置组件大小
		 * @param	size IntDimension
		 * @see org.libra.geom.IntDimension
		 */
		public function setSize(size:IntDimension):void {
			if (size.equal(this.getSize())) {
				return;
			}
			this.bounds.setSize(size);
			if (borderable) {
				addBorder();
			}
			if (masked) {
				setMaskRect(new IntRectangle(0, 0, size.getWidth(), size.getHeight()));
			}
			if (opaque) {
				paint();
			}
		}
		
		/**
		 * 获取组件大小
		 * @return IntDimension
		 * @see org.libra.geom.IntDimension
		 */
		public function getSize():IntDimension {
			return this.bounds.getSize();
		}
		
		/**
		 * 获取组件高度
		 * @return 高度 int类型
		 */
		public function getWidth():int {
			return this.bounds.getSize().getWidth();
		}
		
		/**
		 * 获取组件宽度
		 * @return 款第 int类型
		 */
		public function getHeight():int {
			return this.bounds.getSize().getHeight();
		}
		
		/**
		 * 设置组件坐标
		 * @param	location 坐标 IntPoint类型
		 * @see org.libra.geom.IntPoint
		 */
		public function setLocation(location:IntPoint):void {
			this.bounds.setLocation(location);
			this.x = location.getX();
			this.y = location.getY();
		}
		
		/**
		 * 获取组件坐标
		 * @return 坐标 IntPoint类型
		 * @see org.libra.geom.IntPoint
		 */
		public function getLocation():IntPoint {
			return this.bounds.getLocation();
		}
		
		/**
		 * 获取横坐标值 
		 * @return x int类型
		 */
		public function getX():int {
			return this.bounds.getLocation().getX();
		}
		
		/**
		 * 获取纵坐标值
		 * @return y int类型
		 */
		public function getY():int {
			return this.bounds.getLocation().getY();
		}
		
		/**
		 * 横坐标增加，若为负数，则横坐标减少
		 * @param	x 增量 int类型
		 */
		public function addX(x:int):void {
			this.x += x;
		}
		
		/**
		 * 纵坐标增加，若为负数，则纵坐标减少
		 * @param	y 增量 int类型
		 */
		public function addY(y:int):void {
			this.y += y;
		}
		
		/**
		 * 获取组件边界界限
		 * @return IntRectangle类型
		 * @see org.libra.geom.IntRectangle
		 */
		public function getIntBounds():IntRectangle {
			return this.bounds;
		}
		
		/**
		 * 设置前景色，若组件包含TextField，则将该颜色作为Textfield的字体颜色
		 * @param	c 颜色 JColor类型
		 * @see org.libra.utils.JColor
		 */
		public function setForeground(c:JColor):void{
			if(foreground != c){
				foreground = c;
			}
		}
		
		/**
		 * 获取前景色
		 * @return 若组件包含TextField，则返回Textfield的字体颜色
		 * @see org.libra.utils.JColor
		 */
		public function getForeground():JColor {
			return this.foreground;
		}
		
		/**
		 * 获取边框颜色
		 * @return JColor类型
		 * @see org.libra.utils.JColor
		 */
		public function getBorderColor():JColor {
			return this.borderColor;
		}
		
		/**
		 * 设置边框颜色
		 * @param	c JColor类型
		 * @see org.libra.utils.JColor
		 */
		public function setBorderColor(c:JColor):void {
			this.borderColor = c;
		}
		
		/**
		 * 添加边框
		 * @param	color 边框颜色，若参数为null，则使用组件默认的边框颜色
		 * @see org.libra.utils.JColor
		 */
		public function addBorder(color:JColor = null):void {
			if (borderable) {
				if (color) {
					this.borderColor = color;
				}
				borderShape.graphics.clear();
				borderShape.graphics.lineStyle(.5, borderColor.getRGB());
				borderShape.graphics.moveTo(0, 0);
				borderShape.graphics.lineTo(getWidth(), 0);
				borderShape.graphics.lineTo(getWidth(), getHeight());
				borderShape.graphics.lineTo(0, getHeight());
				borderShape.graphics.lineTo(0, 0);
			}
		}
		
		/**
		 * 删除边框
		 */
		public function removeBorder():void {
			this.borderShape.graphics.clear();
		}
		
		/**
		 * 设置是否需要添加边框
		 * @param	b Boolean true or false
		 */
		public function setBorderable(b:Boolean):void {
			this.borderable = b;
		}
		
		/**
		 * 获取是否添加边框
		 * @return Boolean true or false
		 */
		public function isBorderable():Boolean {
			return this.borderable;
		}
		
		/**
		 * 组件是否在舞台中显示
		 * @return Boolean true or false
		 */
		public function isOnStage():Boolean {
			return stage != null;
		}
		
		/**
		 * 设置组件透明度，0-1范围
		 * @param	num Alpha值
		 */
		public function setAlpha(num:Number):void {
			this.alpha = num;
		}
		
		/**
		 * 获取组件透明度，0-1范围
		 * @return Alpha值
		 */
		public function getAlpha():Number {
			return this.alpha;
		}
		
		/**
		 * 设置组件是否不透明，如果需要用到自己的皮肤，那么应该设置为false
		 * @param	b Boolean true or false
		 */
		public function setOpaque(b:Boolean):void {
			if (this.opaque != b) {
				if (b) {
					paint();
				}else {
					clearPaint();
				}
				opaque = b;
			}
		}
		
		/**
		 * 获取组件是否透明
		 * @return Boolean true or false
		 */
		public function isOpaque():Boolean {
			return this.opaque;
		}
		
		/**
		 * 删除组件所有的自我绘制
		 */
		public function clearPaint():void {
			this.graphics.clear();
		}
		
		/**
		 * 自我绘制,子类重写该方法，进行个性化绘制
		 * 当opaque为true（不透明）时，调用paint方法进行面板绘制
		 */
		public function paint():void {
			this.graphics.clear();
			this.graphics.beginFill(JColor.HALO_BLUE.getRGB());
			this.graphics.drawRect(0, 0, getWidth(), getHeight());
			this.graphics.endFill();
		}
		
		/**
		 * 使用资源文件对组件进行绘制，子类重写该方法，进行个性化绘制
		 * 当opaque为false（透明）时，调用该drawMe方法进行面板绘制
		 */
		public function drawMe():void {
			setDrawedMe(true);
		}
		
		/**
		 * 是否已经使用资源文件对组件进行了绘制
		 * @return Boolean true or false
		 */
		public function isDrawedMe():Boolean {
			return drawedMe;
		}
		
		/**
		 * 设置是否已经使用资源文件对组件进行了绘制
		 * @param	b Boolean true or false
		 */
		public function setDrawedMe(b:Boolean):void {
			this.drawedMe = b;
		}
		
		/**
		 * 设置组件遮罩，大部分组件是不需要遮罩的
		 * @param	b Boolean true or false
		 */
		public function setMasked(b:Boolean):void {
			if (masked != b) {
				if (b) {
					if (!maskShape) {
						maskShape = new Shape();
					}
					maskShape.graphics.clear();
					maskShape.graphics.beginFill(0);
					maskShape.graphics.drawRect(0, 0, 1, 1);
					maskShape.graphics.endFill();
					this.addChild(maskShape);
					this.mask = maskShape;
				}else {
					removeChild(maskShape);
					this.mask = null;
				}
				masked = b;
			}
		}
		
		/**
		 * 获取组件是否设置了遮罩
		 * @return Boolean true or false
		 */
		public function isMasked():Boolean {
			return masked;
		}
		
		/**
		 * 设置组件遮罩的范围
		 * @param	rect 遮罩范围
		 * @see org.libra.geom.IntRectangle
		 */
		public function setMaskRect(rect:IntRectangle):void {
			if (this.masked) {
				this.maskShape.x = rect.getLocation().getX();
				this.maskShape.y = rect.getLocation().getY();
				this.maskShape.width = rect.getSize().getWidth();
				this.maskShape.height = rect.getSize().getHeight();
			}
		}
		
		/**
		 * 获取组件遮罩范围
		 * @return IntRectangle类型，如果没有遮罩，那么返回null
		 * @see org.libra.geom.IntRectangle
		 */
		public function getMaskRect():IntRectangle {
			if (masked) {
				return new IntRectangle(maskShape.x, maskShape.y, maskShape.width, maskShape.height);
			}
			return null;
		}
		
		/**
		 * 设置是否允许拖放
		 * @param	b true ：允许拖放； false ： 不允许拖放
		 */
		public function setDragable(b:Boolean):void {
			if (this.dragable != b) {
				if (b) {
					if (!this.dragBmd) {
						this.dragBmd = createDragBmd();
					}
					this.addEventListener(MouseEvent.MOUSE_DOWN, onStartDragHandler);
				}else {
					this.removeEventListener(MouseEvent.MOUSE_DOWN, onStartDragHandler);
				}
				this.dragable = b;
			}
		}
		
		/**
		 * 获取是否拖放
		 * @return true or false
		 */
		public function isDragable():Boolean {
			return this.dragable;
		}
		
		/**
		 * 获取拖放时呈现图案的BitmapData
		 * @return
		 */
		public function getDragBmd():BitmapData {
			return this.dragBmd;
		}
		
		/**
		 * 设置拖放时呈现图案的BitmapData
		 * @param	bmd
		 */
		public function setDragBmd(bmd:BitmapData):void {
			if (dragBmd) {
				dragBmd.dispose();
			}
			this.dragBmd = bmd;
		}
		
		/**
		 * 拖放开始时，调用拖放管理类的startDrag方法
		 * @param	e
		 */
		protected function onStartDragHandler(e:MouseEvent):void {
			DragManager.startDrag(this);
		}
		
		/**
		 * 创建一个拖放图案的BitmapData，
		 * 如果dragBmd是null时，
		 * 才会调用该方法
		 * @return
		 */
		protected function createDragBmd():BitmapData {
			return new BitmapData(60, 60, true, 0xffff0000);
		}
		
		/**
		 * 设置提示面板
		 * @param	toolTip 提示面板是Component的子类，可以进行个性化的制定。
		 */
		public function setToolTip(toolTip:Component = null):void {
			if (this.toolTip) {
				this.toolTip.dispose();
			}
			if (toolTip) {
				toolTip.mouseChildren = toolTip.mouseEnabled = toolTip.tabEnabled = false;
			}
			this.toolTip = toolTip;
			ToolTipManager.getInstance().setToolTip(this, toolTip);
		}
		
		/**
		 * 获取提示面板
		 * @return
		 */
		public function getToolTip():Component {
			return this.toolTip;
		}
		
		/**
		 * 重写父类的设置组件宽度的方法
		 */
		override public function set width(value:Number):void {
			if (super.width != value) {
				super.width = value;
				this.bounds.getSize().setWidth(value);
			}
		}
		
		/**
		 * 重写父类的设置组件高度的方法
		 */
		override public function set height(value:Number):void {
			if (super.height != value) {
				super.height = value;
				this.bounds.getSize().setHeight(value);
			}
		}
		
		/**
		 * 重写父类的设置纵坐标的方法
		 */
		override public function set y(value:Number):void {
			if (super.y != value) {
				super.y = value;
				this.bounds.getLocation().setY(value);
			}
		}
		
		/**
		 * 重写父类的设置横坐标的方法
		 */
		override public function set x(value:Number):void {
			if (super.x != value) {
				super.x = value;
				this.bounds.getLocation().setX(x);
			}
		}
		
		override public function toString():String {
			return "hello!I'm Component!";
		}
		
		/**
		 * 销毁，彻底的销毁，将组件打入万劫不复的境界，从此以后烟消云散，不复存在
		 * 
		 *			  |
		 *		  \       /
		 *			.---. 
		 *	   '-.  |   |  .-'
		 *		 ___|   |___
		 *	-=  [           ]  =-
		 *		`---.   .---' 
		 *	 __||__ |   | __||__
		 *	 '-..-' |   | '-..-'
		 *	   ||   |   |   ||
		 *	   ||_.-|   |-,_||
		 *	 .-"`   `"`'`   `"-.
		 *  .'                   '.
		 * 
		 */
		public function dispose():void {
			if (this.hasEventListener(Event.ADDED_TO_STAGE)) {
				this.removeEventListener(Event.ADDED_TO_STAGE, onAddToStageHandler);
			}
			setDragable(false);
			setMasked(false);
			setBorderable(false);
			setToolTip(null);
		}
		
	}

}