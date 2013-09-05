package us.wcweb.view.components.content.elements {
	import org.libra.JScrollPanel;
	import org.libra.basic.Container;

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import org.libra.basic.Component;
	import org.libra.basic.Container;
	import org.libra.events.ListEvent;
	import org.libra.events.ScrollEvent;
	import org.libra.geom.IntDimension;
	import org.libra.geom.IntPoint;
	import org.libra.ui.interfaces.IListItem;

	/**
	 * @author macbookpro
	 */
	public class PlayListComponents extends Container {
		private var lineHeight : int;
		private var itemPanel : Container;
		private var items : Vector.<IListItem>;
		private var itemCounter : int;
		private var itemHeight : int;
		private var selectedItem : IListItem;
		private var scrollPanel : JScrollPanel;
		private var listScrollRect : Rectangle;

		public function PlayListComponents(lineHeight : uint) {
			super();

			this.lineHeight = lineHeight;
			itemPanel = new Container();
			this.append(itemPanel);
			items = new Vector.<IListItem>();
			itemHeight = itemCounter = 0;
			this.setBorderable(true);
		}
		

		override protected function onAddToStageHandler(e : Event) : void {
			super.onAddToStageHandler(e);
			// this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			this.itemPanel.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
			// this.addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			this.itemPanel.addEventListener(MouseEvent.CLICK, onClickHandler);
			if (this.scrollPanel) {
				this.scrollPanel.addEventListener(ScrollEvent.MOVE, onScrollMoveHandler);
			}
		}

		override protected function onRemoveFromStageHandler(e : Event) : void {
			super.onRemoveFromStageHandler(e);
			// this.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			this.itemPanel.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseMoveHandler);
			// this.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			this.itemPanel.removeEventListener(MouseEvent.CLICK, onClickHandler);
			if (this.scrollPanel) {
				if (this.scrollPanel.hasEventListener(ScrollEvent.MOVE)) {
					this.scrollPanel.removeEventListener(ScrollEvent.MOVE, onScrollMoveHandler);
				}
			}
		}

		private function onClickHandler(e : MouseEvent) : void {
			var item : IListItem = getItemUnderPoint(new Point(e.stageX, e.stageY));
			if (item) {
				item.changeToSelected();
				dispatchEvent(new ListEvent(ListEvent.ITEM_CLICK, item));
			}
		}

		//
		// private function onMouseUpHandler(e:MouseEvent):void {
		//
		// }
		//
		private function onMouseMoveHandler(e : MouseEvent) : void {
			var item : IListItem = getItemUnderPoint(new Point(e.stageX, e.stageY));
			if (item) {
				if (item == selectedItem) {
					return;
				}
				for each (var i:IListItem in items) {
					if (i == item) {
						item.changeToOver();
					} else {
						i.changeToNormal();
					}
				}
				selectedItem = item;
			}
		}

		//
		// private function onMouseDownHandler(e:MouseEvent):void {
		//
		// }
		private function getItemUnderPoint(point : Point) : IListItem {
			var ary : Array = this.stage.getObjectsUnderPoint(point);
			var l : int = ary.length;
			for (var i : int = l; i > -1; i-- ) {
				if (ary[i] is DisplayObject) {
					var obj : DisplayObject = ary[i] as DisplayObject;
					if (obj.parent is IListItem) {
						return obj.parent as IListItem;
					} else if (obj is IListItem) {
						return obj as IListItem;
					}
				}
			}
			return null;
		}

		public function getLineHeight() : int {
			return this.lineHeight;
		}

		public function setLineHeight(lineHeight : int) : void {
			this.lineHeight = lineHeight;
		}

		override public function setSize(size : IntDimension) : void {
			super.setSize(size);
			this.itemPanel.setSize(size);
			this.listScrollRect = new Rectangle(0, 0, size.getWidth(), size.getHeight());
			this.itemPanel.scrollRect = listScrollRect;
		}

		public function appendItem(item : IListItem) : void {
			if (!hasItem(item)) {
				item.update(new IntDimension(getWidth(), lineHeight));
				item.changeToNormal();
				var com : Component = item.getCell();
				com.setLocation(new IntPoint(0, itemHeight));
				this.itemPanel.append(com);
				items[itemCounter++] = item;
				itemHeight += lineHeight;
				showScrollBar();
			}
		}

		public function appendItemAll(items : Array) : void {
			for each (var i:* in items) {
				if (i is IListItem) {
					this.appendItem(i as IListItem);
				}
			}
		}

		public function removeItem(item : IListItem) : void {
			var index : int = this.items.indexOf(item);
			if (index != -1) {
				var com : Component = item.getCell();
				this.itemPanel.remove(com);
				items.splice(index, 1);
				itemCounter--;
				itemHeight -= lineHeight;
				for (var i : int = index; i < itemCounter; i += 1 ) {
					items[i].getCell().addY(-lineHeight);
				}
				showScrollBar();
			}
		}

		public function clearItem() : void {
			this.itemPanel.removeAll();
			itemHeight = items.length = itemCounter = 0;
			showScrollBar();
		}

		public function hasItem(item : IListItem) : Boolean {
			return this.items.indexOf(item) != -1;
		}

		public function getItemCounter() : int {
			return this.itemCounter;
		}

		private function showScrollBar() : void {
			if (itemHeight > getHeight()) {
				if (!scrollPanel) {
					scrollPanel = new JScrollPanel();
				}
				if (this.append(scrollPanel)) {
					scrollPanel.addEventListener(ScrollEvent.MOVE, onScrollMoveHandler);
				}
				scrollPanel.setLocation(new IntPoint(this.getWidth() - scrollPanel.getWidth()));
				scrollPanel.setSize(new IntDimension(lineHeight/4, getHeight()));
				scrollPanel.updateThumbHeight(itemCounter - int(getHeight() / lineHeight));
				this.bringToTop(scrollPanel);
				listScrollRect.width = this.getWidth() - this.scrollPanel.getWidth();
				this.itemPanel.scrollRect = listScrollRect;
			} else {
				if (this.remove(scrollPanel)) {
					scrollPanel.removeEventListener(ScrollEvent.MOVE, onScrollMoveHandler);
				}
			}
		}

		private function onScrollMoveHandler(e : ScrollEvent) : void {
			listScrollRect.y = lineHeight * e.getCurLine();
			var maxY : int = itemHeight - getHeight();
			listScrollRect.y = listScrollRect.y > maxY ? maxY : listScrollRect.y;
			this.itemPanel.scrollRect = listScrollRect;
		}

		public function getScrollPanel() : JScrollPanel {
			return this.scrollPanel;
		}

		override public function toString() : String {
			return "JList:items = " + items;
		}
	}
}