package org.libra.utils {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public final class DepthUtil {
		
		public function DepthUtil() {
			throw new Error("DepthUtil can't be a instance!");
		}
		
		public static function bringToBottom(mc:DisplayObject):void{
			var parent:DisplayObjectContainer = mc.parent;
			if (parent) {
				if(parent.getChildIndex(mc) != 0){
					parent.setChildIndex(mc, 0);
				}
			}
		}
		
		public static function bringToTop(mc:DisplayObject):void{
			var parent:DisplayObjectContainer = mc.parent;
			if (parent) {
				var maxIndex:int = parent.numChildren - 1;
				if (parent.getChildIndex(mc) != maxIndex) { 
					parent.setChildIndex(mc, maxIndex);
				}
			}
		}
		
		public static function isTop(mc:DisplayObject):Boolean { 
			var parent:DisplayObjectContainer = mc.parent;
			if (parent) {
				return (parent.numChildren - 1) == parent.getChildIndex(mc);
			}
			return false;
		}
		
		public static function isBottom(mc:DisplayObject):Boolean { 
			var parent:DisplayObjectContainer = mc.parent;
			if (parent) {
				return parent.getChildIndex(mc) == 0;
			}
			return false;
		}
		
		public static function isJustBelow(mc:DisplayObject, aboveMC:DisplayObject):Boolean { 
			var parent:DisplayObjectContainer = mc.parent;
			if (parent) {
				if (aboveMC.parent != parent) {
					return false;
				}
				return parent.getChildIndex(mc) == parent.getChildIndex(aboveMC) - 1;
			}
			return false;
		}
		
		public static function isJustAbove(mc:DisplayObject, belowMC:DisplayObject):Boolean{
			return isJustBelow(belowMC, mc);
		}
		
	}

}