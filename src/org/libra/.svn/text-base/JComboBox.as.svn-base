package org.libra {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import org.libra.basic.Container;
	import org.libra.events.LibraEvent;
	import org.libra.events.ListEvent;
	import org.libra.geom.IntDimension;
	import org.libra.geom.IntPoint;
	import org.libra.ui.interfaces.IButtonState;
	import org.libra.ui.interfaces.IListItem;
	import org.libra.utils.JColor;
	import org.libra.utils.JFont;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public class JComboBox extends Container {
		
		private const minBtnWidth:int = 16;
		private const minbtnHeight:int = 16;
		
		private var itemContainer:Container;
		private var itemListScrollRect:Rectangle;
		private var itemList:JList;
		private var arrowBtn:JButton;
		private var textField:TextField;
		private var editAble:Boolean;
		private var unfold:Boolean;
		private var lineHeight:int;
		private var itemListNum:int;
		private var unfoldspeed:int;
		private var unfolding:Boolean;
		
		public function JComboBox(text:String = "", lineHeight:int = 18, itemListNum:int = 10) { 
			super();
			this.setBorderable(true);
			textField = new TextField();
			textField.text = text;
			this.addChild(textField);
			editAble = true;
			setEditAble(false);
			arrowBtn = new JButton();
			this.append(arrowBtn);
			unfold = false;
			itemContainer = new Container();
			itemList = new JList(lineHeight);
			this.itemContainer.append(itemList);
			itemListScrollRect = new Rectangle();
			this.lineHeight = lineHeight;
			this.itemListNum = itemListNum;
			this.unfoldspeed = 50;
			this.unfolding = false;
		}
		
		override protected function onAddToStageHandler(e:Event):void {
			super.onAddToStageHandler(e);
			arrowBtn.addActionListener(onArrowBtnHandler);
			this.itemList.addEventListener(ListEvent.ITEM_CLICK, onItemClickedHandler);
		}
		
		override protected function onRemoveFromStageHandler(e:Event):void {
			super.onRemoveFromStageHandler(e);
			arrowBtn.removeActionListener(onArrowBtnHandler);
			this.itemList.removeEventListener(ListEvent.ITEM_CLICK, onItemClickedHandler);
		}
		
		override public function setSize(size:IntDimension):void {
			super.setSize(size);
			var btnHeight:int = size.getHeight() > minbtnHeight ? size.getHeight() : minbtnHeight;
			arrowBtn.setSize(new IntDimension(minBtnWidth, btnHeight));
			arrowBtn.setLocation(new IntPoint(size.getWidth() - minBtnWidth));
			textField.width = size.getWidth() - minBtnWidth;
			textField.height = size.getHeight();
			itemContainer.setSize(new IntDimension(size.getWidth(), itemListNum * lineHeight));
			itemContainer.setLocation(new IntPoint(0, size.getHeight()));
			itemList.setSize(itemContainer.getSize());
			itemListScrollRect.y = itemContainer.getHeight();
			itemListScrollRect.width = itemContainer.getWidth();
			itemListScrollRect.height = itemContainer.getHeight();
			itemContainer.scrollRect = itemListScrollRect;
			if (itemContainer.getHeight() < (unfoldspeed << 2)) { 
				unfoldspeed = int(itemContainer.getHeight() >> 2);
			}else if (itemContainer.getHeight() > (unfoldspeed << 3)) { 
				unfoldspeed = int(itemContainer.getHeight() >> 3);
			}
		}
		
		private function onArrowBtnHandler(evt:LibraEvent):void {
			this.setUnfold(!unfold);
		}
		
		private function onItemClickedHandler(e:ListEvent):void {
			var item:IListItem = e.getItem();
			this.textField.text = item.getData();
		}
		
		public function setEditAble(b:Boolean):void {
			if (this.editAble != b) {
				if (b) {
					this.textField.type = TextFieldType.INPUT;
					this.textField.mouseEnabled = this.textField.mouseWheelEnabled = this.textField.selectable = true;
					this.textField.tabEnabled = false;
				}else {
					this.textField.type = TextFieldType.DYNAMIC;
					this.textField.mouseEnabled = this.textField.mouseWheelEnabled = this.textField.selectable = false;
				}
				this.editAble = b;
			}
		}
		
		public function isEditAble():Boolean {
			return this.editAble;
		}
		
		public function getTextField():TextField {
			return this.textField;
		}
		
		public function setFont(font:JFont):void {
			this.textField.defaultTextFormat = font.getTextFormat();
		}
		
		override public function setForeground(c:JColor):void {
			super.setForeground(c);
			this.textField.textColor = c.getRGB();
			this.textField.alpha = c.getAlpha();
		}
		
		public function setTextFilters(fs:Array):void{
			this.textField.filters = fs;
		}
		
		public function getTextFilters():Array {
			return this.textField.filters;
		}
		
		public function setTextOffset(offset:IntPoint):void {
			this.textField.x = offset.getX();
			this.textField.y = offset.getY();
		}
		
		public function getTextOffset():IntPoint {
			return new IntPoint(textField.x, textField.y);
		}
		
		public function setArrowBtnState(state:IButtonState):void {
			this.arrowBtn.setState(state);
		}
		
		public function setUnfold(b:Boolean):void {
			if (unfold != b) {
				if (!this.unfolding) {
					this.unfold = b;
					this.unfolding = true;
					if (b) {
						this.append(itemContainer);
					}
					this.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
				}
			}
		}
		
		private function onEnterFrameHandler(e:Event):void {
			if (unfold) {
				this.itemListScrollRect.y -= unfoldspeed;
				this.itemListScrollRect.y = this.itemListScrollRect.y < 0 ? 0 : this.itemListScrollRect.y;
				this.itemContainer.scrollRect = this.itemListScrollRect;
				if (this.itemListScrollRect.y <= 0) {
					this.removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
					this.itemContainer.addEventListener(MouseEvent.ROLL_OUT, onItemMouseOutHandler);
					this.unfolding = false;
				}
			}else {
				this.itemListScrollRect.y += unfoldspeed;
				this.itemListScrollRect.y = this.itemListScrollRect.y > this.itemContainer.getHeight() ? this.itemContainer.getHeight() : this.itemListScrollRect.y;
				this.itemContainer.scrollRect = this.itemListScrollRect;
				if (this.itemListScrollRect.y >= this.itemContainer.getHeight()) {
					this.removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
					this.itemContainer.removeEventListener(MouseEvent.ROLL_OUT, onItemMouseOutHandler);
					this.remove(itemContainer);
					this.unfolding = false;
				}
			}
		}
		
		private function onItemMouseOutHandler(e:MouseEvent):void {
			if (e.target == itemContainer) {
				setUnfold(false);
			}
		}
		
		public function isUnfold():Boolean {
			return this.unfold;
		}
		
		public function appendItem(item:IListItem):void {
			this.itemList.appendItem(item);
		}
		
		public function removeItem(item:IListItem):void {
			this.itemList.removeItem(item);
		}
		
		override public function toString():String {
			return "JComboBox";
		}
	}

}