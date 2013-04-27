package org.libra.events {
	import flash.events.Event;
	import org.libra.ui.interfaces.IListItem;
	
	/**
	 * 列表事件，当点击列表中任何一个元素时，响应该事件
	 * @author Eddie
	 */
	public class ListEvent extends Event {
		
		/**
		 * 点击列表元素事件
		 */
		public static const ITEM_CLICK:String = "itemClicked";
		
		/**
		 * 列表中被点击的元素
		 * @see org.libra.ui.interfaces.IListItem
		 */
		private var item:IListItem;
		
		public function ListEvent(type:String, item:IListItem, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
			this.item = item;
		} 
		
		public function getItem():IListItem {
			return this.item;
		}
		
		public override function clone():Event { 
			return new ListEvent(type, item, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("ListEvent", "item", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}