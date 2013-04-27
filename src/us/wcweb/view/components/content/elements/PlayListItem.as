package us.wcweb.view.components.content.elements {
	import us.wcweb.utils.Tools;

	import flash.display.Sprite;

	import org.libra.ui.interfaces.IListItem;

	import mx.core.MovieClipAsset;

	import com.kevincao.kafe.behaviors.display.KafeButton;

	import flash.events.Event;
	import flash.display.Loader;

	import us.wcweb.view.events.PlayListEvent;

	import flash.events.MouseEvent;
	import flash.display.MovieClip;

	import org.libra.basic.Component;
	import org.libra.utils.JColor;
	import org.libra.geom.IntDimension;
	import org.libra.ui.BasicListItem;

	/**
	 * @author macbookpro
	 * 
	 * 
	 * info ={ time:'', duration:'',author:''}
	 * 
	 * 
	 * 
	 */
	public class PlayListItem extends Component implements IListItem {
		[Embed(source='/assets/swf/playListAssets.swf', symbol='PlayListItem')]
		private var PlayListItemShape : Class;
		[Embed(source='/assets/swf/playListAssets.swf', symbol='PlayItBtn')]
		private var PlayBtnClass : Class;
		private var _info : Object;
		private var _state : KafeButton;
		private var state : MovieClip;
		private var playBtn : KafeButton;

		public function PlayListItem(info : Object) {
			_info = info;
			// this.setSize(new IntDimension(320, 18));
			_state = new KafeButton(new PlayListItemShape());
			state = _state.skin;
			_state.skin.buttonMode = true;
			addChild(state);
			playBtn = new KafeButton(new PlayBtnClass());
			state.addChild(playBtn.skin);
			playBtn.skin.x = 202.4;
			playBtn.skin.y = 19.95;
			playBtn.skin.buttonMode = true;
			createStateInfo();

			// Loader(state).contentLoaderInfo.addEventListener(Event.INIT, initListener);
			_state.skin.addEventListener(MouseEvent.CLICK, playClipHandler);
			changeToNormal();
		}

		private function initListener(e : Event) : void {
			changeToNormal();
			// state.addEventListener(MouseEvent.CLICK, playClipHandler);
		}

		private function createStateInfo() : void {
			this.state.cueTime.text = info.time;
			this.state.itemDuration.text = info.duration;
			this.state.title.text = info.author;
		}

		private function playClipHandler(e : MouseEvent) : void {
			trace(e.target);
			if (!playBtn.selected) {
				trace("playBtn PlayListEvent.PLAY_CLIP");
				dispatchEvent(new PlayListEvent(PlayListEvent.PLAY_CLIP, _info.link));
			} else {
				trace("playBtn PlayListEvent.PLAY_CLIP");
				dispatchEvent(new PlayListEvent(PlayListEvent.STOP_CLIP, _info.link));
			}
		}

		/* INTERFACE org.libra.interfaces.IListItem */
		public function getCell() : Component {
			return this;
		}

		public function changeToNormal() : void {
			// createState(JColor.HALO_ORANGE);
			// trace(state);
			// this.state.gotoAndStop('normal');
		}

		public function changeToOver() : void {
			// this.state.gotoAndStop('over');
		}

		public function changeToDown() : void {
			// this.state.gotoAndStop('down');
		}

		public function changeToUp() : void {
		}

		public function changeToSelected() : void {
			// this.state.gotoAndStop('selected');
		}

		public function update(size : IntDimension) : void {
			// this.setSize(new IntDimension(374, 67));
			// this.setSize(size);
		}

		public function get info() : Object {
			return _info;
		}

		public function getData() : String {
			return Tools.getProperties(info);
		}
	}
}
