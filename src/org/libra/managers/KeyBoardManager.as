package org.libra.managers {
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	/**
	 * 键盘事件管理器
	 * @author Eddie
	 */
	public final class KeyBoardManager extends EventDispatcher {
		
		/**
		 * 当回车键被弹起时，响应该方法
		 */
		public static const ENTER_DOWN:String = "enterDown";
		
		/**
		 * 舞台，文档类的stage
		 */
		private var stage:Stage;
		
		/**
		 * 该类的实例，使用了单例模式
		 */
		private static var instance:KeyBoardManager = null;
		
		/**
		 * 构造函数，给文档类的stage添加对按键弹起的事件的侦听
		 * @param	main 文档类
		 */
		public function KeyBoardManager(main:DisplayObjectContainer) {
			if (!main) {
				throw new Error("KeyBoardManager's main can't be null");
			}
			stage = main.stage;
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUpHandler);
		}
		
		/**
		 * 按键弹起事件
		 * @param	e
		 */
		private function onKeyUpHandler(e:KeyboardEvent):void {
			switch(e.keyCode) {
				case Keyboard.ENTER:
					dispatchEvent(new Event(ENTER_DOWN));
				break;
			}
		}
		
		/**
		 * 获取当前实例
		 * @param	main 文档类
		 * @return 当前实例
		 */
		public static function getInstance(main:DisplayObjectContainer = null):KeyBoardManager {
			if (instance) {
				return instance;
			}
			instance = new KeyBoardManager(main);
			return instance;
		}
		
	}

}