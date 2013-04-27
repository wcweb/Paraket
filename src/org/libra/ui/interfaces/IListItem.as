package org.libra.ui.interfaces {
	import org.libra.basic.Component;
	import org.libra.geom.IntDimension;
	
	/**
	 * 列表元素接口
	 * @see org.libra.ui.BasicListItem
	 * @author Eddie
	 */
	public interface IListItem {
		
		/**
		 * 获取呈现元素的组件，一般情况下，使用JLabel
		 * @return 
		 * @see org.libra.basic.Component
		 * @see org.libra.JLabel
		 */
		function getCell():Component;
		
		/**
		 * 将元素状态改变成正常状态
		 */
		function changeToNormal():void;
		
		/**
		 * 将元素状态改变成鼠标进入时状态
		 */
		function changeToOver():void;
		
		/**
		 * 将元素状态改变成鼠标按下时状态
		 */
		function changeToDown():void;
		
		/**
		 * 将元素状态改变成鼠标弹起时状态
		 */
		function changeToUp():void;
		
		/**
		 * 将元素状态改变成被选中时状态
		 */
		function changeToSelected():void;
		
		function update(size:IntDimension):void;
		
		/**
		 * 获取元素的一些信息，指定为String类型。
		 * @return String
		 */
		function getData():String;
		
	}
	
}