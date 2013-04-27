package org.libra.basic {
	import flash.utils.Dictionary;
	
	/**
	 * 组件容器类，继承自Component，
	 * 作为所有的组件的容器，
	 * 比如 JWindow，JPanel，JFrame等等
	 * @author Eddie
	 */
	public class Container extends Component {
		
		/**
		 * 容器中所有的子对象
		 */
		private var children:Vector.<Component>;
		
		private var dragAcceptableInitiator:Dictionary;
		
		public function Container() {
			super();
			children = new Vector.<Component>();
		}
		
		/**
		 * 添加组件到容器里
		 * @param	c 组件
		 * @return Boolean 如果添加成功，返回true，否则返回false
		 * @see org.libra.basic.Component
		 */
		public function append(c:Component):Boolean {
			if (hasComponent(c)) {
				return false;
			}
			this.addChild(c);
			this.children[this.children.length] = c;
			return true;
		}
		
		/**
		 * 添加所有组件，遍历数组，并调用apped()
		 * @param	...coms 组件数组
		 * @see append
		 */
		public function appendAll(...coms):void {
			for each(var i:* in coms) {
				if (i is Component) {
					this.append(i as Component);
				}
			}
		}
		
		/**
		 * 移除组件
		 * @param	c 组件
		 * @return Boolean 如果移除成功，返回true，否则返回false
		 * @see org.libra.basic.Component
		 */
		public function remove(c:Component):Boolean {
			var index:int = this.children.indexOf(c);
			if (index != -1) {
				this.removeChild(c);
				this.children.splice(index, 1);
				return true;
			}
			return false;
		}
		
		/**
		 * 移除容器里所有的组件
		 */
		public function removeAll():void {
			for each(var com:Component in children) {
				this.removeChild(com);
			}
			this.children.length = 0;
		}
		
		/**
		 * 判断容器里是否包含组件
		 * @param	c 组件
		 * @return 如果包含，返回true，否则返回false
		 */
		public function hasComponent(c:Component):Boolean {
			return this.children.indexOf(c) != -1;
		}
		
		/**
		 * 重写drawMe()，遍历子对象数组，调用子对象的drawMe()
		 */
		override public function drawMe():void {
			super.drawMe();
			for each(var com:Component in children) {
				if (!com.isDrawedMe()) {
					com.drawMe();
				}
			}
		}
		
		public function addDragAcceptableInitiator(com:Component):void { 
			if (!dragAcceptableInitiator) { 
				dragAcceptableInitiator = new Dictionary(true);
			}
			dragAcceptableInitiator[com] = true;
		}
		
		public function removeDragAcceptableInitiator(com:Component):void { 
			if (dragAcceptableInitiator) { 
				dragAcceptableInitiator[com] = undefined;
				delete dragAcceptableInitiator[com];
			}
		}
		
		public function isDragAcceptableInitiator(com:Component):Boolean { 
			if (dragAcceptableInitiator) { 
				return dragAcceptableInitiator[com] == true;
			}
			return false;
		}
		
		override public function toString():String {
			return "Container";
		}
		
		/**
		 * 自我销毁，并销毁所有子对象
		 */
		override public function dispose():void {
			super.dispose();
			for each(var c:Component in children) {
				c.dispose();
			}
			children.length = 0;
			children = null;
		}
		
	}

}