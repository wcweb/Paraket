package org.libra.managers {
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import org.libra.JButton;
	import org.libra.JPanel;
	import org.libra.utils.DepthUtil;
	
	/**
	 * Libra UI的最牛逼的管家，管理着所有小管家
	 * @author Eddie
	 */
	public final class LibraManager {
		
		/**
		 * 舞台，文档类的stage
		 */
		private var stage:Stage = null;
		
		/**
		 * 文档类实例
		 */
		private var main:DisplayObjectContainer;
		
		/**
		 * 在舞台上的所有的面板
		 */
		private var showingPanel:Vector.<JPanel> = new Vector.<JPanel>();
		
		/**
		 * 激活的面板，永远有且只有一个。
		 */
		private var activePanel:JPanel;
		
		private var modalChild:Sprite;
		
		/**
		 * 当前实例
		 */
		private static var instance:LibraManager;
		
		/**
		 * 构造函数，侦听键盘管家发出的事件
		 * @param	main 文档类
		 */
		public function LibraManager(main:DisplayObjectContainer) {
			if (!main) {
				throw new Error("LibraManager's main can't be null");
			}
			this.stage = main.stage;
			this.main = main;
			KeyBoardManager.getInstance(main).addEventListener(KeyBoardManager.ENTER_DOWN, onEnterDownHandler);
			DragManager.setMain(main);
			modalChild = new Sprite();
			modalChild.mouseChildren = false;
		}
		
		/**
		 * 键盘管家发出的回车键弹起事件，
		 * 调用当前激活面板的defaultButton所响应的事件
		 * @param	e
		 */
		private function onEnterDownHandler(e:Event):void {
			if (this.activePanel) {
				var b:JButton = this.activePanel.getDefaultButton();
				if (b) {
					b.doClick();
				}
			}
		}
		
		/**
		 * 获取文档类实例
		 * @return
		 */
		public function getMain():DisplayObjectContainer {
			return this.main;
		}
		
		/**
		 * 获取舞台
		 * @return
		 */
		public function getStage():Stage {
			return stage;
		}
		
		/**
		 * 当有一个JPanel调用了show()后，就被添加到showingPanel里。
		 * 该JPanel当被点击时，会发出JPanel.CLICKED，所以这里要添加一个侦听该事件的方法
		 * 方便大管家管理
		 * @param	p 调用了show()的JPanel
		 */
		public function addPanel(p:JPanel):void {
			if (p.isActiveable()) {
				if (showingPanel.indexOf(p) == -1) {
					p.addEventListener(JPanel.CLICKED, onClickPanelHandler);
					showingPanel[showingPanel.length] = p;
					this.setActivePanel(p);
				}
			}
		}
		
		/**
		 * 当JPanel调用了tryToClose()后，就从showingPanel里移除。
		 * 移除侦听JPanel.CLICKED事件的方法。
		 * 方便大管家管理。
		 * @param	p 调用了tryToClose()的JPanel
		 */
		public function removePanel(p:JPanel):void {
			var index:int = showingPanel.indexOf(p);
			if (index != -1) {
				p.removeEventListener(JPanel.CLICKED, onClickPanelHandler);
				showingPanel.splice(index, 1);
				if (p.isActive()) {
					var l:int = showingPanel.length;
					if (l > 0) {
						setActivePanel(showingPanel[l - 1]);
					}else {
						setUnactivePanel(activePanel);
						activePanel = null;
					}
				}
			}
		}
		
		/**
		 * 响应JPanel的JPanel.CLICKED事件的方法。
		 * 将JPanel设置成当前激活面板
		 * @param	e
		 */
		private function onClickPanelHandler(e:Event):void {
			var p:JPanel = e.target as JPanel;
			setActivePanel(p);
		}
		
		/**
		 * 设置当前的激活面板，并将其置于显示层最上层显示。
		 * @param	p JPanel
		 * @see org.libra.JPanel
		 */
		private function setActivePanel(p:JPanel):void {
			if (p.isActiveable()) {
				if (p != activePanel) {
					if (activePanel) {
						setUnactivePanel(activePanel);
					}
					this.activePanel = p;
					activePanel.setActive(true);
					if (activePanel.isModal()) {
						this.updateModalChild(activePanel.parent.width, activePanel.parent.height);
						activePanel.parent.addChild(this.modalChild);
					}
					DepthUtil.bringToTop(activePanel);
				}
			}
		}
		
		private function setUnactivePanel(p:JPanel):void {
			activePanel.setActive(false);
			if (activePanel.isModal()) {
				modalChild.parent.removeChild(this.modalChild);
			}
		}
		
		/**
		 * 获取当前激活的面板
		 * @return JPanel
		 * @see org.libra.JPanel
		 */
		public function getActivePanel():JPanel {
			return this.activePanel;
		}
		
		private function updateModalChild(width:int, height:int):void { 
			modalChild.graphics.beginFill(0xff00000, 0);
			modalChild.graphics.drawRect(0, 0, width, height);
			modalChild.graphics.endFill();
		}
		
		/**
		 * 获取当前实例，使用了单例模式，一个家族中有且仅有一位大管家
		 * @param	main 文档类
		 * @return 当前实例
		 */
		public static function getInstance(main:DisplayObjectContainer = null):LibraManager {
			if (instance) {
				return instance;
			}
			instance = new LibraManager(main);
			return instance;
		}
		
	}

}