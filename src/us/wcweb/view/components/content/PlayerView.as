package us.wcweb.view.components.content {
	import us.wcweb.model.events.RecordProxyEvent;
	import flash.events.IEventDispatcher;
	import com.kevincao.kafe.utils.KafeHelper;

	import us.wcweb.utils.Tools;
	import us.wcweb.events.SystemEvent;
	import us.wcweb.view.events.PlayerViewEvent;

	import flash.display.DisplayObject;
	import flash.display.Loader;

	import mx.core.MovieClipAsset;

	import flash.utils.getDefinitionByName;

	import com.kevincao.kafe.behaviors.display.KafeButton;
	import com.kevincao.kafe.behaviors.display.EasyButton;

	import flash.text.TextField;
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
	public class PlayerView extends MovieClip {
		[Embed(source='/assets/swf/playerAssets.swf')]
		public var PlayerContainer : Class;
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
		public var recordTimer : TextField;
		public var currentPosition : TextField;
		public var stautsLabel : TextField;
		public var recordBtn : MovieClip;
		public var encordPlayBtn : MovieClip;
		public var saveLocalBtn : MovieClip;
		public var uploadBtn : MovieClip;
		// [Embed(source='/assets/swf/playerAssets.swf',symbol='com.wcweb.UI.RecordBtn')]
		public var rb : KafeButton;
		public var skin : MovieClip;
		public var container : MovieClipAsset;

		// public var link_github : MovieClip;
		// public var contentHolder : MovieClip;
		// public var placeHolderScroller : MovieClip;
		// private var _currentView : MovieClip;
		// private var _tips : Array = [];
		// private var _scroller : CustomScrollbar;
		// --------------------------------------------------------------------------
		//
		// Initialization
		//
		// --------------------------------------------------------------------------
		public function PlayerView() {
			super();
			// @TODO whern use symbol class cannot convert  to movieclipAsset
			container = MovieClipAsset(new PlayerContainer());
			addChild(container as MovieClip);
			trace("for mock",this.name);
			trace("for mock",container.name);
		}

		public function main() : void {
			Loader(container.getChildAt(0)).contentLoaderInfo.addEventListener(Event.INIT, initializeView);
		}

		// --------------------------------------------------------------------------
		//
		// API
		//
		// --------------------------------------------------------------------------
		// public function show() : void {
		// Tweener.addTween(this, {y:150, alpha:1, transition:Equations.easeOutExpo, time:.8});
		// }
		//
		// public function hide() : void {
		// visible = false;
		// }
		public function stopTiming(currentPosition : Number) : void {
			skin['currentPosition'].text = currentPosition;
		}

		public function updateTiming(currentPosition : Number) : void {
			skin['currentPosition'].text = currentPosition;
		}

		public function recordTime() : void {
		}

		public function clear(target : TextField) : void {
			skin.stautsLabel.text = "fuckkkkkkk";
		}

		public function showUploadBtnEncordBtn() : void {
			getButton(skin.uploadBtn).enabled = true;
			getButton(skin.encordPlayBtn).enabled = true;
		}

		public function hiddenUploadBtnEncordBtn() : void {
			getButton(skin.uploadBtn).enabled = false;
			getButton(skin.encordPlayBtn).enabled = false;
		}

		// --------------------------------------------------------------------------
		//
		// Eventhandling
		//
		// --------------------------------------------------------------------------
		private function initializeView(e : Event) : void {
			skin = MovieClip(e.target.content).cc;
//			Tools.walkDisplayObjects(skin, Tools.traceContainer);
			addEventListener(MouseEvent.CLICK, initializeBehaviour);

			getButton(skin.uploadBtn).enabled = false;
			getButton(skin.encordPlayBtn).enabled = false;
			// skin.stautsLabel.addEventListener(MouseEvent.CLICK, handleStageClick);
		}

		private function handleStageClick(e : MouseEvent) : void {
			trace(e.target);
			this.dispatchEvent(new SystemEvent(SystemEvent.STAGE_CLICK));
		}

		private function initializeBehaviour(e : MouseEvent) : void {
			switch(e.target.name) {
				case 'recordBtn':
					handleEncordBtn(this,getButton(skin.recordBtn).selected);
					break;
				case 'encordPlayBtn':
					handlePlayBtn(this,getButton(skin.encordPlayBtn).selected);
					break;
				case 'uploadBtn':
					handleUploadBtn(this,getButton(skin.uploadBtn).selected);
					break;
				case 'stautsLabel':
					clear(TextField(e.target));
					break;
				default:
					dispatchEvent(new SystemEvent(SystemEvent.STAGE_CLICK));
					break;
			}

			function handleEncordBtn(dispatcher:IEventDispatcher,selected : Boolean) : void {
				getButton(skin.uploadBtn).selected = false;
				getButton(skin.encordPlayBtn).selected = false;
				if (selected) {
					trace('getButton(skin.recordBtn).selected');
					
					dispatcher.dispatchEvent(new RecordProxyEvent(RecordProxyEvent.START_RECORD, null));
				} else {
					hiddenUploadBtnEncordBtn();
					trace('getButton(skin.recordBtn).deselected');
					dispatcher.dispatchEvent(new RecordProxyEvent(RecordProxyEvent.STOP_RECORD, null));
				}
			}
			function handlePlayBtn(dispatcher:IEventDispatcher,selected : Boolean) : void {
				getButton(skin.uploadBtn).selected = false;
				getButton(skin.recordBtn).selected = false;
				if (selected) {
					dispatcher.dispatchEvent(new RecordProxyEvent(RecordProxyEvent.PLAY_CURRENT_RECORDED, null));
				} else {
					dispatcher.dispatchEvent(new RecordProxyEvent(RecordProxyEvent.STOP_CURRENT_PLAY, null));
				}
				trace("encordPlayBtn Click");
			}
			function handleUploadBtn(dispatcher:IEventDispatcher,selected : Boolean) : void {
				getButton(skin.recordBtn).selected = false;
				getButton(skin.encordPlayBtn).selected = false;
				if (selected) {
					trace("encordPlayBtn PlayListEvent.PLAY_CLIP");
					dispatcher.dispatchEvent(new SystemEvent(SystemEvent.POST_RECORD, null));
				} else {
					trace("encordPlayBtn PlayListEvent.PLAY_CLIP");
					dispatcher.dispatchEvent(new SystemEvent(SystemEvent.STOP_POST, null));
				}
			}

			// @TODO  trace(e.target == skin['recordBtn']);//return false
		}

		// --------------------------------------------------------------------------
		//
		// Methods
		//
		// --------------------------------------------------------------------------
		private function getButton(target : MovieClip) : KafeButton {
			return KafeButton(KafeHelper.getBehavior(target));
		}
		// private function openExternalURL(url : String) : void {
		// var request : URLRequest = new URLRequest();
		// request.url = url;
		// navigateToURL(request, "_blank");
		// }
	}
}