package org.libra {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import org.libra.basic.Container;
	import org.libra.events.LibraEvent;
	import org.libra.events.ScrollEvent;
	import org.libra.geom.IntDimension;
	import org.libra.geom.IntPoint;
	import org.libra.managers.DragManager;
	import org.libra.ui.BasicScrollPanelState;
	import org.libra.ui.interfaces.IScrollPanelState;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public class JScrollPanel extends Container {
		
		private var arrowHeight:int;
		private var arrowWidth:int;
		private var state:IScrollPanelState;
		private var upArrow:JButton;
		private var downArrow:JButton;
		private var thumb:JButton;
		private var lineHeight:int;
		private var thumbDragRect:Rectangle;
		private var curLine:int;
		private var totalLine:int;
		
		public function JScrollPanel(state:IScrollPanelState = null, lineHeight:int = 3) { 
			super();
			this.lineHeight = lineHeight;
			upArrow = new JButton();
			downArrow = new JButton();
			thumb = new JButton();
			this.appendAll(upArrow, downArrow, thumb);
			this.setState(state);
			this.thumbDragRect = new Rectangle();
			totalLine = curLine = 0;
		}
		
		override protected function onAddToStageHandler(e:Event):void {
			super.onAddToStageHandler(e);
			this.addEventListener(MouseEvent.ROLL_OVER, onMouseOverHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, onMouseOutHandler);
			this.upArrow.addActionListener(onBtnClickHandler);
			this.downArrow.addActionListener(onBtnClickHandler);
			this.thumb.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			this.thumb.addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			this.thumb.addEventListener(MouseEvent.ROLL_OUT, onMouseOutHandler);
		}
		
		private function onBtnClickHandler(e:LibraEvent):void {
			switch(e.currentTarget) {
				case upArrow:
					if(curLine > 0) {
						var endY:int = this.thumb.y - lineHeight;
						endY = endY > arrowHeight ? endY : arrowHeight;
						this.thumb.y = endY;
						curLine--;
						dispatchEvent(new ScrollEvent(ScrollEvent.MOVE, curLine));
					}else {
						this.thumb.y = arrowHeight;
					}
				break;
				case downArrow:
					var maxY:int = getHeight() - arrowHeight - thumb.height;
					if(curLine < totalLine) {
						endY = this.thumb.y + lineHeight;
						endY = endY > maxY ? maxY : endY;
						this.thumb.y = endY;
						curLine += 1;
						dispatchEvent(new ScrollEvent(ScrollEvent.MOVE, curLine));
					}else {
						this.thumb.y = maxY;
					}
				break;
			}
		}
		
		override protected function onRemoveFromStageHandler(e:Event):void {
			super.onRemoveFromStageHandler(e);
			this.removeEventListener(MouseEvent.ROLL_OVER, onMouseOverHandler);
			this.removeEventListener(MouseEvent.ROLL_OUT, onMouseOutHandler);
			this.upArrow.removeActionListener(onBtnClickHandler);
			this.downArrow.removeActionListener(onBtnClickHandler);
			this.thumb.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			this.thumb.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			this.thumb.removeEventListener(MouseEvent.ROLL_OUT, onMouseOutHandler);
		}
		
		private function onMouseDownHandler(e:MouseEvent):void {
			this.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			this.thumb.startDrag(false, thumbDragRect);
		}
		
		private function onMouseUpHandler(e:MouseEvent):void {
			stopDtagThumb();
		}
		
		/**
		 * 如果DragManager没有在执行拖拽任务，才能继续执行if里的语句。
		 * 因为不管谁调用了stopDrag方法，那么所有正在被拖拽的sprite都会stopDrag，
		 * 这应该算是flash的一个小bug。
		 */
		private function stopDtagThumb():void {
			if (!DragManager.isDraging) {
				thumb.stopDrag();
				if (this.hasEventListener(Event.ENTER_FRAME)) {
					this.removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
				}
			}
		}
		
		private function onEnterFrameHandler(e:Event):void {
			var tempLine:int = int((thumb.y - arrowHeight) / lineHeight);
			if (curLine != tempLine) {
				curLine = tempLine;
				dispatchEvent(new ScrollEvent(ScrollEvent.MOVE, curLine));
			}
		}
		
		private function onMouseOutHandler(e:MouseEvent):void {
			if (e.target == this) {
				state.changeToNormal();
			}else if (e.target == thumb) {
				stopDtagThumb();
			}
		}
		
		private function onMouseOverHandler(e:MouseEvent):void {
			state.changeToOver()
		}
		
		public function getArrowheight():int {
			return this.arrowHeight;
		}
		
		public function getArrowWidth():int {
			return this.arrowWidth;
		}
		
		override public function setSize(size:IntDimension):void {
			super.setSize(size);
			this.state.update(size);
			this.arrowWidth = size.getWidth();
			this.arrowHeight = arrowWidth;
			var arrowSize:IntDimension = new IntDimension(arrowWidth, arrowHeight);
			upArrow.setSize(arrowSize);
			downArrow.setSize(arrowSize);
			downArrow.setLocation(new IntPoint(0, size.getHeight() - arrowHeight));
			thumb.setLocation(new IntPoint(0, arrowHeight));
			this.thumbDragRect.y = arrowHeight;
		}
		
		public function updateThumbHeight(extraLineNum:int):void { 
			this.totalLine = extraLineNum;
			var extraH:int = totalLine * lineHeight;
			var h:int = getHeight() - (arrowHeight << 1) - extraH;
			this.thumb.setSize(new IntDimension(arrowWidth, h));
			this.thumbDragRect.height = extraH;
		}
		
		public function setState(state:IScrollPanelState = null):void {
			if (this.state) {
				this.state.dispose();
			}
			if (state) {
				this.state = state;
			}else {
				this.state = new BasicScrollPanelState();
			}
			this.state.update(this.getSize());
			this.setBackgroundChild(this.state.getDisplayObject());
			this.upArrow.setState(this.state.getUpArrowState());
			this.downArrow.setState(this.state.getDownArrowState());
			this.thumb.setState(this.state.getThunmState());
		}
		
		public function resetState():void {
			this.state.changeToAllNormal();
		}
		
		override public function toString():String {
			return "JScrollPanel";
		}
		
	}

}