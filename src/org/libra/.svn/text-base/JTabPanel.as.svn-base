package org.libra {
	import flash.events.Event;
	import org.libra.basic.Component;
	import org.libra.basic.Container;
	import org.libra.events.LibraEvent;
	import org.libra.geom.IntDimension;
	import org.libra.geom.IntPoint;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public class JTabPanel extends JPanel {
		
		private var tabHeads:Vector.<JButton>;
		private var pagePanels:Vector.<Component>;
		private var pageCounter:int;
		private var selectIndex:int;
		private var headLocation:IntPoint;
		private var headSize:IntDimension;
		private var headInterval:int;
		private var pageLocation:IntPoint;
		
		public function JTabPanel(owner:Container, headLocation:IntPoint, headSize:IntDimension, headInterval:int, pageLocation:IntPoint, modal:Boolean = false) { 
			super(owner, modal);
			this.headLocation = headLocation;
			this.headSize = headSize;
			this.headInterval = headInterval;
			this.pageLocation = pageLocation;
			tabHeads = new Vector.<JButton>();
			pagePanels = new Vector.<Component>();
			pageCounter = 0;
			selectIndex = 0;
		}
		
		override protected function onAddToStageHandler(e:Event):void {
			super.onAddToStageHandler(e);
			for each(var head:JButton in tabHeads) {
				head.addActionListener(onTabHeadClickHandler);
			}
		}
		
		override protected function onRemoveFromStageHandler(e:Event):void {
			super.onRemoveFromStageHandler(e);
			for each(var head:JButton in tabHeads) {
				head.removeActionListener(onTabHeadClickHandler);
			}
		}
		
		override public function append(c:Component):Boolean {
			return this.appendTab(c, c.toString());
		}
		
		override public function remove(c:Component):Boolean {
			var index:int = this.pagePanels.indexOf(c);
			if (index != -1) {
				if (super.remove(c)) {
					var head:JButton = this.tabHeads[index];
					head.removeActionListener(onTabHeadClickHandler);
					super.remove(head);
					this.tabHeads.splice(index, 1);
					this.pagePanels.splice(index, 1);
					pageCounter--;
					if (selectIndex == index) {
						setSelectedIndex(index - 1);
					}
					return true;
				}
			}
			return false;
		}
		
		private function createTabHead(text:String):JButton {
			var b:JButton = new JButton(text);
			b.setSize(headSize);
			b.addActionListener(onTabHeadClickHandler);
			return b;
		}
		
		private function onTabHeadClickHandler(evt:LibraEvent):void {
			var head:JButton = evt.target as JButton;
			if (head) {
				this.setSelectedIndex(this.tabHeads.indexOf(head));
			}
		}
		
		public function appendTab(c:Component, title:String):Boolean { 
			if (this.pagePanels.indexOf(c) == -1) {
				if (super.append(c)) {
					c.setVisible(pageCounter == selectIndex);
					c.setLocation(pageLocation);
					var head:JButton = this.createTabHead(title);
					super.append(head);
					head.setLocation(new IntPoint(pageCounter * headInterval + headLocation.getX(), headLocation.getY()));
					this.tabHeads[pageCounter] = head;
					this.pagePanels[pageCounter++] = c;
					return true;
				}
			}
			return false;
		}
		
		public function removeTab(index:int):Boolean {
			if (index < 0 || index > pageCounter) {
				return remove(this.pagePanels[index]);
			}
			return false;
		}
		
		public function setSelectedIndex(index:int):void {
			if (index < 0 || index > pageCounter) {
				return;
			}
			if (selectIndex == index) {
				return;
			}
			tabHeads[selectIndex].getState().changeToNormal();
			tabHeads[index].getState().changeToSelected();
			pagePanels[selectIndex].setVisible(false);
			pagePanels[index].setVisible(true);
			selectIndex = index;
		}
		
		public function getSelectedIndex():int {
			return this.selectIndex;
		}
		
		override public function dispose():void {
			for each(var head:JButton in tabHeads) {
				head.removeActionListener(onTabHeadClickHandler);
				head.dispose();
			}
			for each(var page:Component in pagePanels) {
				page.dispose();
			}
			super.dispose();
		}
		
		override public function toString():String {
			return "JTabPanel";
		}
		
	}

}