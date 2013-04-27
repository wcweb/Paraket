package org.libra.basic {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * 基类，继承自Sprite，作为所有ui组件的顶级父类
	 * @author Eddie
	 */
	public class BasicSprite extends Sprite {
		
		/**
		 * 背景层显示对象
		 */
		private var backgroundChild:DisplayObject;
		
		public function BasicSprite() {
			super();
		}
		
		/**
		 * 判断是否包含显示对象
		 * @param	child 显示对象
		 * @return Boolean值，包含，返回true，否则返回false
		 */
		public function containsChild(child:DisplayObject):Boolean {
			return child.parent == this;
		}
		
		/**
		 * 将显示对象置于顶层显示
		 * @param	child 显示对象
		 */
		public function bringToTop(child:DisplayObject):void{
			setChildIndex(child, this.numChildren - 1);
		}
		
		/**
		 * 将显示对象置于底层显示，如果设置了背景，
		 * 那么将显示对象置于背景的上一层，背景层永远在最底层
		 * @param	child 显示对象
		 */
		public function bringToBottom(child:DisplayObject):void{
			var index:int = 0;
			if(backgroundChild){
				if(backgroundChild != child){
					index = 1;
				}
			}
			setChildIndex(child, index);
		}
		
		/**
		 * 设置背景，如果不传参数或者参数为null，那么将背景层删除
		 * @param	child 背景层的显示对象
		 */
		public function setBackgroundChild(child:DisplayObject = null):void{
			if(child != backgroundChild){
				if(backgroundChild){
					removeChild(backgroundChild);
				}
				backgroundChild = child;
				if(backgroundChild != null){
					super.addChildAt(backgroundChild, 0);
				}
			}
		}
		
		/**
		 * 获取背景层显示对象
		 * @return 显示对象或者null
		 */
		public function getBackgroundChild():DisplayObject{
			return backgroundChild;
		}
		
		public function setVisible(b:Boolean):void {
			if (this.visible != b) {
				this.visible = b;
			}
		}
		
		public function getVisible():Boolean {
			return this.visible;
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject {
			if (index == 0) {
				if (backgroundChild) {
					index = 1;
				}
			}
			return super.addChildAt(child, index);
		}
		
	}

}