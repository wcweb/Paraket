package org.libra.ui.interfaces {
	import flash.display.DisplayObject;
	import org.libra.geom.IntDimension;
	
	/**
	 * 按钮状态接口
	 * @see org.libra.ui.BasicButtonState
	 * @author Eddie
	 */
	public interface IButtonState {
		
		function changeToNormal():void;
		
		
		function changeToOver():void;
		
		
		function changeToUp():void;
		
		
		function changeToDown():void;
		
		
		function changeToDisable():void;
		
		function changeToSelected():void;
		
		/**
		 * 当按钮的size改变时，调用该方法对state进行相应的修改
		 * @param	size IntDimension
		 * @see org.libra.geom.IntDimension
		 */
		function update(size:IntDimension):void;
		
		function getDisplayObject():DisplayObject;
		
		function dispose():void;
		
	}
	
}