package org.libra.utils {
	import org.libra.JCheckBox;
	
	/**
	 * 选择按钮组，用以给选择性按钮分组。
	 * 如果两个checkBox在同一个组里，那么其中任何一个被勾选后，剩下的则自动取消勾选，
	 * @author Eddie
	 */
	public final class CheckBoxGroup {
		
		/**
		 * CheckBox的数组
		 */
		private var buttons:Vector.<JCheckBox>;
		
		public function CheckBoxGroup() {
			buttons = new Vector.<JCheckBox>();
		}
		
		/**
		 * 添加CheckBox
		 * @param	b 选择性按钮
		 * @see org.libra.JCheckBox
		 */
		public function append(b:JCheckBox):void {
			if (!has(b)) {
				buttons[buttons.length] = b;
				b.setCheckBoxGroup(this);
			}
		}
		
		/**
		 * 添加所有JCheckBox
		 * @param	...btns 选择性按钮
		 * @see org.libra.JCheckBox
		 */
		public function appendAll(...btns):void {
			for each(var i:* in btns) {
				if (i is JCheckBox) {
					this.append(i as JCheckBox);
				}
			}
		}
		
		/**
		 * 移除JCheckBox
		 * @param	b
		 * @see org.libra.JCheckBox
		 */
		public function remove(b:JCheckBox):void {
			var index:int = buttons.indexOf(b);
			if (index != -1) {
				buttons.splice(index, 1);
				b.setCheckBoxGroup(null);
			}
		}
		
		/**
		 * 移除所有的JCheckBox
		 * @see org.libra.JCheckBox
		 */
		public function removeAll():void {
			for each(var b:JCheckBox in buttons) {
				b.setCheckBoxGroup(null);
			}
			buttons.length = 0;
		}
		
		/**
		 * 判断是否包含JCheckBox
		 * @param	b
		 * @return 包含返回true，否则返回false
		 * @see org.libra.JCheckBox
		 */
		public function has(b:JCheckBox):Boolean {
			return buttons.indexOf(b) != -1;
		}
		
		/**
		 * 改变剩下的其他按钮的选择状态
		 * @param	selected 选择状态，是被勾选还是取消勾选
		 * @param	butThisButton 数组中唯一不改变选择状态的按钮
		 */
		public function setOtherSelected(selected:Boolean, butThisButton:JCheckBox):void { 
			for each(var checkBox:JCheckBox in buttons) {
				if (checkBox == butThisButton) {
					continue;
				}
				checkBox.setSelectedAlone(selected);
			}
		}
		
	}

}