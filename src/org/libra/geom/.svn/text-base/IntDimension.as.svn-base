package org.libra.geom {
	
	/**
	 * 大小尺寸类
	 * @author Eddie
	 */
	public final class IntDimension {
		
		/**
		 * 宽度
		 */
		private var width:int;
		
		/**
		 * 高度
		 */
		private var height:int;
		
		/**
		 * 构造方法
		 * @param	width 高度
		 * @param	height 宽度
		 */
		public function IntDimension(width:int = 0, height:int = 0) { 
			this.width = width;
			this.height = height;
		}
		
		/**
		 * 重置大小
		 * @param	size IntDimension
		 */
		public function setSize(size:IntDimension):void {
			this.width = size.getWidth();
			this.height = size.getHeight();
		}
		
		/**
		 * 获取大小
		 * @return IntDimension
		 */
		public function getSize():IntDimension {
			return this;
		}
		
		/**
		 * 设置大小的宽度
		 * @param	w int
		 */
		public function setWidth(w:int):void {
			this.width = w;
		}
		
		/**
		 * 获取大小的宽度
		 * @return int
		 */
		public function getWidth():int {
			return this.width;
		}
		
		/**
		 * 获取大小的高度
		 * @return int
		 */
		public function getHeight():int {
			return this.height;
		}
		
		/**
		 * 设置大小的高度
		 * @param	h int
		 */
		public function setHeight(h:int):void {
			this.height = h;
		}
		
		/**
		 * 比较两个大小尺寸是否相等
		 * @param	s 另一个大小尺寸
		 * @return 如果两个大小尺寸高度相等宽度相等，那么返回true，否则返回false
		 */
		public function equal(s:IntDimension):Boolean {
			if (this.width == s.getWidth()) {
				if (this.height == s.getHeight()) {
					return true;
				}
			}
			return false;
		}
		
		/**
		 * 更改大小的宽和高
		 * @param	w 宽度的增量
		 * @param	h 高度的增量
		 * @return 改变后的大小 IntDimension
		 */
		public function change(w:int, h:int):IntDimension {
			this.width += w;
			this.height += h;
			return this;
		}
		
		/**
		 * 生成String，输出宽度和高度
		 * @return
		 */
		public function toString():String {
			return "width = " + this.width + ",height = " + this.height;
		}
		
	}

}