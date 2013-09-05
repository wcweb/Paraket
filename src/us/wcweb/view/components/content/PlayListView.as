package us.wcweb.view.components.content {
	import us.wcweb.view.events.PlayListEvent;
	import org.libra.basic.Component;

	import us.wcweb.view.components.content.elements.PlayListComponents;

	import com.kevincao.kafe.behaviors.display.KafeButton;

	import us.wcweb.utils.Tools;
	import us.wcweb.view.components.content.elements.PlayListItem;

	import org.libra.ui.BasicListItem;
	import org.libra.JList;
	import org.libra.geom.IntPoint;
	import org.libra.JFrame;
	import org.libra.geom.IntDimension;
	import org.libra.JWindow;
	import org.libra.managers.LibraManager;

	import flash.utils.getDefinitionByName;
	import flash.events.Event;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.display.MovieClip;

	// import caurina.transitions.Equations;
	// import caurina.transitions.Tweener;
	/**
	 * The implementation of the main content view.
	 *  
	 * @author Peter Lorent peter.lorent@gmail.com
	 * 
	 */
	[Embed(source='/assets/swf/playListAssets.swf', symbol='PlayListView')]
	public class PlayListView extends Sprite {
		// --------------------------------------------------------------------------
		//
		// Class Properties
		//
		// --------------------------------------------------------------------------
		// public static const SHOW_TIPS : String = "showTips";
		// --------------------------------------------------------------------------
		//
		// Instance Properties
		//
		// --------------------------------------------------------------------------
		public var list : PlayListComponents;
		public var f : JFrame;

		// public var placeHolderScroller : MovieClip;
		// private var _currentView : MovieClip;
		// private var _tips : Array = [];
		// private var _scroller : CustomScrollbar;
		// --------------------------------------------------------------------------
		//
		// Initialization
		//
		// --------------------------------------------------------------------------
		public function PlayListView() {
			// super();
			
			// trace("get cc inlist ",getDefinitionByName("Symbol 2"));
		}

		public function main() : void {
			initializeView();

			initializeBehaviour();
		}

		// --------------------------------------------------------------------------
		//
		// API
		//
		// --------------------------------------------------------------------------
		public function initializeList(itemlist : Array) : void {
			list.appendItemAll(itemlist);
		}
		// --------------------------------------------------------------------------
		//
		// Eventhandling
		//
		// --------------------------------------------------------------------------
		// private function handleEvent(event : *) : void {
		// if (event.target == link_github) openExternalURL("http://wiki.github.com/darscan/robotlegs");
		// }
		// --------------------------------------------------------------------------
		//
		// Methods
		//
		// --------------------------------------------------------------------------
		private function initializeView() : void {
			LibraManager.getInstance(this);
			var win : JWindow = new JWindow(this);
			win.setSize(new IntDimension(310, 170));
			win.setLocation(new IntPoint(28, 150));
			win.show();

			f = new JFrame(win);
			f.setSize(new IntDimension(310, 170));
			// f.setLocation(new IntPoint((stage.stageWidth - f.getWidth()) >> 1, (stage.stageHeight - f.getHeight()) >> 1));
			f.show();

			list = new PlayListComponents(67);
			list.setSize(new IntDimension(310, 170));
			var info : Object = {time:12, duration:200, author:'adminsdfsafasdfasdf', link:'abc.mp3'};
			list.appendItem(new PlayListItem(info));
			list.appendItem(new PlayListItem(info));
			list.appendItem(new PlayListItem(info));
			
			
			list.appendItem(new PlayListItem(info));
			list.appendItem(new PlayListItem(info));
			list.appendItem(new PlayListItem(info));
			list.appendItem(new PlayListItem(info));
			list.appendItem(new PlayListItem(info));
			list.appendItem(new PlayListItem(info));

			f.append(list);

			
			// trace("#######################################")
			// Tools.walkDisplayObjects(this, Tools.traceContainer);
		}

		private function parseItems(xml : XML) : Array {
			return new Array();
		}

		private function initializeBehaviour() : void {
			addEventListener(MouseEvent.CLICK, handleClickItem);
			addEventListener(PlayListEvent.PLAY_CLIP, handlePlayItem);
			// link_github.addEventListener(MouseEvent.MOUSE_UP, handleEvent);
		}
		// private function openExternalURL(url : String) : void {
		// var request : URLRequest = new URLRequest();
		// request.url = url;
		// navigateToURL(request, "_blank");
		// }
		private function handleClickItem(e:MouseEvent):void{
			trace(e.target);
			trace(e.currentTarget);
		}
		private function handlePlayItem(e:PlayListEvent):void{
			trace("hear? me in view?");
			dispatchEvent(e);
		}
	}
}