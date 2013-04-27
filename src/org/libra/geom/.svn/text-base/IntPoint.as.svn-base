package org.libra.geom {
	import flash.geom.Point;
	
	/**
	 * 整数坐标类
	 * @author Eddie
	 */
	public final class IntPoint {
		
		/**
		 * 横坐标
		 */
		private var x:int;
		
		/**
		 * 纵坐标
		 */
		private var y:int;
		
		/**
		 * 构造函数
		 * @param	x 横坐标
		 * @param	y 纵坐标
		 */
		public function IntPoint(x:int = 0, y:int = 0) { 
			this.x = x;
			this.y = y;
		}
		
		/**
		 * 设置横坐标
		 * @param	x int
		 * @return 新的坐标 IntPoint
		 */
		public function setX(x:int):IntPoint {
			this.x = x;
			return this;
		}
		
		/**
		 * 获取横坐标
		 * @return int
		 */
		public function getX():int {
			return this.x;
		}
		
		/**
		 * 设置纵坐标
		 * @param	y int
		 * @return 新的坐标 IntPoint
		 */
		public function setY(y:int):IntPoint {
			this.y = y;
			return this;
		}
		
		/**
		 * 获取zzb
		 * @return int
		 */
		public function getY():int {
			return this.y;
		}
		
		/**
		 * 同时设置横坐标和纵坐标
		 * @param	x 横坐标
		 * @param	y 纵坐标
		 * @return 新的坐标 IntPoint
		 */
		public function setXY(x:int, y:int):IntPoint {
			this.x = x;
			this.y = y;
			return this;
		}
		
		/**
		 * 判断两个坐标是否相等
		 * @param	p 另一个坐标
		 * @return 如果两个坐标的横坐标和纵坐标都相等，返回true，否则返回false
		 */
		public function equals(p:IntPoint):Boolean {
			if (this.x == p.getX()) {
				if (this.y == p.getY()) {
					return true;
				}
			}
			return false;
		}
		
		/**
		 * 更改坐标的横坐标和纵坐标
		 * @param	x 横坐标的增量
		 * @param	y 纵坐标的增量
		 * @return 新的坐标
		 */
		public function change(x:int, y:int):IntPoint {
			this.x += x;
			this.y += y;
			return this;
		}
		
		/**
		 * 生成Point类的实例
		 * @return Point
		 */
		public function toPoint():Point {
			return new Point(x, y);
		}
		
		/**
		 * 生成String，输出横坐标和纵坐标
		 * @return String
		 */
		public function toString():String {
			return "x = " + this.x + ",y = " + this.y;
		}
		
	}

}