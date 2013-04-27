package org.libra.geom {
	
	/**
	 * 范围类，包含坐标和宽高
	 * @author Eddie
	 */
	public final class IntRectangle {
		
		/**
		 * 横坐标
		 */
		private var x:int;
		
		/**
		 * 纵坐标
		 */
		private var y:int;
		
		/**
		 * 宽度
		 */
		private var width:int;
		
		/**
		 * 高度
		 */
		private var height:int;
		
		/**
		 * 构造函数
		 * @param	x 横坐标
		 * @param	y 纵坐标
		 * @param	width 宽度
		 * @param	height 高度
		 */
		public function IntRectangle(x:int = 0, y:int = 0, width:int = 0, height:int = 0) { 
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
		}
		
		/**
		 * 获取宽高
		 * @return IntDimension
		 * @see org.libra.geom.IntDimension
		 */
		public function getSize():IntDimension {
			return new IntDimension(width, height);
		}
		
		/**
		 * 获取左上角点的坐标
		 * @return IntPoint
		 * @see org.libra.geom.IntPoint
		 */
		public function getLocation():IntPoint {
			return new IntPoint(x, y);
		}
		
		/**
		 * 设置宽高
		 * @param	size 宽高大小
		 * @return 新的范围
		 */
		public function setSize(size:IntDimension):IntRectangle {
			this.width = size.getWidth();
			this.height = size.getHeight();
			return this;
		}
		
		/**
		 * 设置范围左上角顶点的坐标
		 * @param	location 坐标
		 * @return 新的范围
		 */
		public function setLocation(location:IntPoint):IntRectangle {
			this.x = location.getX();
			this.y = location.getY();
			return this;
		}
		
		/**
		 * 获取左上角顶点的坐标
		 * @return IntPoint
		 * @see org.libra.geom.IntPoint
		 */
		public function getLeftTop():IntPoint {
			return new IntPoint(x, y);
		}
		
		/**
		 * 获取右上角顶点的坐标
		 * @return IntPoint
		 * @see org.libra.geom.IntPoint
		 */
		public function getRightTop():IntPoint {
			return new IntPoint(x + width, y);
		}
		
		/**
		 * 获取右下角顶点的坐标
		 * @return IntPoint
		 * @see org.libra.geom.IntPoint
		 */
		public function getRightBottom():IntPoint {
			return new IntPoint(x + width, y + height);
		}
		
		/**
		 * 获取左下角顶点的坐标
		 * @return IntPoint
		 * @see org.libra.geom.IntPoint
		 */
		public function getLeftBottom():IntPoint {
			return new IntPoint(x, y + height);
		}
		
		/**
		 * 生成String，输出坐标和宽高
		 * @return String
		 */
		public function toString():String {
			return "x = " + this.x + ",y = " + this.y + ",widht = " + this.width + ",height = " + this.height;
		}
		
	}

}