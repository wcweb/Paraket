package us.wcweb.view.components.content {
	import com.demonsters.debugger.MonsterDebugger;

	import flash.display.LoaderInfo;

	import us.wcweb.utils.Strings;

	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.GradientType;
	import flash.geom.Matrix;

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
		// --------------------------------------------------------------------------
		//
		// Class Properties
		//
		// --------------------------------------------------------------------------
		[Embed(source='/assets/swf/playerAssets.swf')]
		public var PlayerContainer : Class;
		// --------------------------------------------------------------------------
		//
		// Instance Properties
		//
		// --------------------------------------------------------------------------
		public var skin : MovieClip;
		public var container : MovieClipAsset;

		// currentPosition
		// stautsLabel
		// uploadBtn
		// encordPlayBtn
		// recordBtn
		// playTimer
		// recordTimer
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
			// trace("for mock", this.name);
			// trace("for mock", container.name);
		}

		public function main() : void {
			Loader(container.getChildAt(0)).contentLoaderInfo.addEventListener(Event.INIT, initializeView);
		}

		// --------------------------------------------------------------------------
		//
		// API
		//
		// --------------------------------------------------------------------------
		public function hide() : void {
			visible = false;
		}

		public function currentPosition(time : Number) : void {
			skin['currentPosition'].txt.text = Strings.digits(time);
		}

		public function playTimer(time : Number) : void {
			skin.playTimer.txt.text = Strings.digits(time);
		}

		public function recordTimer(time : Number) : void {
			skin.recordTimer.txt.text = Strings.digits(time);
		}

		public function clear(target : TextField) : void {
			skin.statusLogger.txt.text = "程序信息显示在这里：）";
		}

		public function log(str : String) : void {
			skin.statusLogger.txt.text = str;
		}

		public function showUploadBtnEncordBtn() : void {
			/*getButton(skin.uploadBtn).enabled = true;*/
			/*getButton(skin.encordPlayBtn).enabled = true;*/
		}

		public function hiddenUploadBtnEncordBtn() : void {
			/*getButton(skin.uploadBtn).enabled = false;*/
			/*getButton(skin.encordPlayBtn).enabled = false;*/
		}

		public function progressUpdate(percentage : int) : void {
			var w : Number = skin.progressbar.width;
			var h : Number = skin.progressbar.height;
			var mask : Sprite = new Sprite();

			mask.graphics.drawRect(0, 0, w * percentage, h);
			addChild(mask);
			skin.progressbar.mask = mask;
		}

		public function drawWave() : void {
			// @TODO
		}

		public function onSuccessUpload() : void {
			getButton(skin.uploadBtn).selected = false;
			getButton(skin.uploadBtn).enabled = false;
		}

		public function onSuccessRecord() : void {
			getButton(skin.uploadBtn).enabled = true;
			getButton(skin.encordPlayBtn).enabled = true;
		}
		
		public function onComperssing() :void{
			getButton(skin.uploadBtn).selected = false;
			getButton(skin.uploadBtn).enabled = false;
		}
		
		public function onCompletePlayRecord():void{
			getButton(skin.encordPlayBtn).selected=false;
			//dispatchEvent(new RecordProxyEvent(RecordProxyEvent.STOP_CURRENT_PLAY, null));
		}

		// --------------------------------------------------------------------------
		//
		// Eventhandling
		//
		// --------------------------------------------------------------------------
		private function initializeView(e : Event) : void {
			skin = MovieClip(e.target.content).cc;
			getButton(skin.uploadBtn).enabled = false;
			getButton(skin.encordPlayBtn).enabled = false;
			getButton(skin.uploadBtn).selected = false;
			getButton(skin.encordPlayBtn).selected = false;

			addEventListener(MouseEvent.CLICK, initializeBehaviour);
			// Tools.walkDisplayObjects(skin, Tools.traceContainer);
			

			/*getButton(skin.uploadBtn).enabled = false;*/
			/*getButton(skin.encordPlayBtn).enabled = false;*/
			// skin.stautsLabel.addEventListener(MouseEvent.CLICK, handleStageClick);
			// var fvars : Object = LoaderInfo(Loader(container.getChildAt(0)).contentLoaderInfo).parameters;
			// trace(fvars);
			// MonsterDebugger.trace(this, fvars);
			// initializeProgressBar();
		}

		private function initializeProgressBar() : void {
		}

		private function handleStageClick(e : MouseEvent) : void {
			// trace(e.target);
			this.dispatchEvent(new SystemEvent(SystemEvent.STAGE_CLICK));
		}

		private function initializeBehaviour(e : MouseEvent) : void {
			switch(e.target.name) {
				case 'recordBtn':
					handleEncordBtn(this, getButton(skin.recordBtn).selected);
					break;
				case 'encordPlayBtn':
					handlePlayBtn(this, getButton(skin.encordPlayBtn).selected);
					break;
				case 'uploadBtn':
					handleUploadBtn(this, getButton(skin.uploadBtn).selected);
					break;
				case 'stautsLabel':
					clear(TextField(e.target));
					break;
				default:
					dispatchEvent(new SystemEvent(SystemEvent.STAGE_CLICK));
					break;
			}

			function handleEncordBtn(dispatcher : IEventDispatcher, selected : Boolean) : void {
				getButton(skin.uploadBtn).selected = false;
				getButton(skin.encordPlayBtn).selected = false;
				getButton(skin.uploadBtn).enabled = false;
				getButton(skin.encordPlayBtn).enabled = false;

				if (selected) {
					// trace('getButton(skin.recordBtn).selected');

					dispatcher.dispatchEvent(new RecordProxyEvent(RecordProxyEvent.START_RECORD, null));
				} else {
					hiddenUploadBtnEncordBtn();
					// trace('getButton(skin.recordBtn).deselected');
					dispatcher.dispatchEvent(new RecordProxyEvent(RecordProxyEvent.STOP_RECORD, null));
				}
			}
			function handlePlayBtn(dispatcher : IEventDispatcher, selected : Boolean) : void {
				getButton(skin.uploadBtn).selected = false;
				getButton(skin.recordBtn).selected = false;
				if (selected) {
					dispatcher.dispatchEvent(new RecordProxyEvent(RecordProxyEvent.PLAY_CURRENT_RECORDED, null));
				} else {
					dispatcher.dispatchEvent(new RecordProxyEvent(RecordProxyEvent.STOP_CURRENT_PLAY, null));
				}
				// trace("encordPlayBtn Click");
			}
			function handleUploadBtn(dispatcher : IEventDispatcher, selected : Boolean) : void {
				getButton(skin.recordBtn).selected = false;
				getButton(skin.encordPlayBtn).selected = false;
				if (selected) {
					trace("upload PlayListEvent.PLAY_CLIP");
					dispatcher.dispatchEvent(new SystemEvent(SystemEvent.POST_RECORD, null));
				} else {
					// trace("encordPlayBtn PlayListEvent.PLAY_CLIP");
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