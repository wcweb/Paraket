package us.wcweb.view.components.content.elements {
	import org.libra.JFrameTitleBar;
	import org.libra.JFrame;
	import org.libra.basic.Container;

	/**
	 * @author macbookpro
	 */
	public class MyFrame extends JFrame {
		private var titleBar : JFrameTitleBar;
		private var titleBarHeight : int;

		public function MyFrame(owner : Container, modal : Boolean = false, titleBarHeight : int = 20) {
			super(owner, modal, titleBarHeight);
		}

		override public function paint() : void {
			this.titleBar.paint();
			this.graphics.clear();
//			this.addBorder(MyColorScheme.RED);
			this.graphics.beginFill(MyColorScheme.LIGHT_GREEN_GRAY.getRGB());
			this.graphics.drawRect(0, 0, getWidth(), getHeight());
			this.graphics.endFill();
		}
	}
}
