package org.libra.ui.interfaces {
	import flash.display.DisplayObject;
	import org.libra.geom.IntDimension;
	
	/**
	 * 滚动条接口
	 * @see org.libra.ui.BasicScrollPanelState
	 * @author Eddie
	 */
	public interface IScrollPanelState {
		
		function getUpArrowState():IButtonState;
		
		function getDownArrowState():IButtonState;
		
		function getThunmState():IButtonState;
		
		function changeToNormal():void;
		
		function changeToOver():void;
		
		function changeToAllNormal():void;
		
		function getDisplayObject():DisplayObject;
		
		function update(size:IntDimension):void;
		
		function dispose():void;
		
	}
	
}