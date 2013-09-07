package us.wcweb.view.mediators {
	import com.demonsters.debugger.MonsterDebugger;
	import us.wcweb.utils.Strings;

	import org.robotlegs.base.EventMap;

	import us.wcweb.model.events.PlayerProxyEvent;

	import flash.events.MouseEvent;

	import us.wcweb.model.events.RecordProxyEvent;
	import us.wcweb.events.SystemEvent;
	import us.wcweb.view.events.PlayerViewEvent;

	import flash.events.Event;

	import us.wcweb.model.events.JwplayerConnectProxyEvent;
	import us.wcweb.view.components.content.PlayerView;

	import org.robotlegs.mvcs.Mediator;

	public class PlayerViewMediator extends Mediator {
		[Inject]
		public var view : PlayerView;

		public function PlayerViewMediator() {
			super();
			MonsterDebugger.initialize(this);
			
		}

		// ---------------------------------------
		// OVERRIDEN METHODS
		// ---------------------------------------
		override public function onRegister() : void {
			// Register your events in the eventMap here
			// eventMap.mapListener(YOUR VIEW COMPOENT, YOUR EVENT, YOUR HANDLER);

			// Optionally add bindings to your view components public variables
			view.main();
			super.onRegister();

			eventMap.mapListener(view, RecordProxyEvent.START_RECORD, handleStartRecord);
			eventMap.mapListener(view, RecordProxyEvent.STOP_RECORD, handleStopRecord);
			eventMap.mapListener(view, RecordProxyEvent.RENDERING, handleRendering);

			eventMap.mapListener(view, RecordProxyEvent.PLAY_CURRENT_RECORDED, handlePlayCurrentRecorded);
			eventMap.mapListener(view, RecordProxyEvent.STOP_CURRENT_PLAY, handleStopCurrentPlay);

			eventMap.mapListener(view, SystemEvent.POST_RECORD, handlePostRecord);
			eventMap.mapListener(view, SystemEvent.POST_PROCESS, handlePostProcess);
			eventMap.mapListener(view, SystemEvent.POST_SUCCESS, handlePostSucess);
			eventMap.mapListener(view, SystemEvent.POST_ERROR, handlePostError);
			eventMap.mapListener(view, SystemEvent.STOP_POST, handleStopPost);
			// eventMap.mapListener(view, SystemEvent.STAGE_CLICK, handleStageClick);

			eventMap.mapListener(eventDispatcher, JwplayerConnectProxyEvent.UPDATE_TIME, handleUpdateTiming);
			eventMap.mapListener(eventDispatcher, JwplayerConnectProxyEvent.PAUSE_TIME, handlePauseTiming);

			eventMap.mapListener(eventDispatcher, RecordProxyEvent.ENCORD_COMPLETE, handleEncordComplete);
			eventMap.mapListener(eventDispatcher, RecordProxyEvent.ENCORD_ERROR, handleEncordError);
			eventMap.mapListener(eventDispatcher, RecordProxyEvent.RECORD_COMPLETE, handleRecordComplete);
			eventMap.mapListener(eventDispatcher, RecordProxyEvent.RECORDING, handleRecordRecording);

			eventMap.mapListener(eventDispatcher, PlayerProxyEvent.PLAYING, handlePlayerPlaying);
		}

		override public function onRemove() : void {
			// Remove any listeners or bindings here
			// eventMap.unmapListeners();
			super.onRemove();
		}

		// ---------------------------------------
		// DISPATCH EVENTS
		// ---------------------------------------
		private function handlePostRecord(event : SystemEvent) : void {
			dispatch(event);
			view.log("上传录音...");
		}

		private function handlePostSucess(event : SystemEvent) : void {
			view.log(event.body);
			view.onSuccessUpload();
		}

		private function handlePostProcess(event : SystemEvent) : void {
			view.log(event.body);
		}

		private function handleStopPost(event : SystemEvent) : void {
			dispatch(event);
			view.log(" 上传取消。");
		}

		private function handlePostError(event : SystemEvent) : void {
			view.log(" 上传出错： " + event.body);
		}

		// private function handleStageClick(event : SystemEvent) : void {
		// dispatch(event);
		// }
		
		
		/*
		 * RecordProxyEvent
		 */
		private function handleStartRecord(event : RecordProxyEvent) : void {
			dispatch(event);
			view.log("开始录音：");
		}

		private function handleStopRecord(event : RecordProxyEvent) : void {
			trace("handle timing update :" + event);
			// dispatch(event)
			eventDispatcher.dispatchEvent(event);
			view.log("停止录音。");
		}

		private function handleRendering(event : RecordProxyEvent) : void {
			view.log("编码中：" + event.data);
		}

		private function handlePlayCurrentRecorded(event : RecordProxyEvent) : void {
			trace("handle event : " + event);
			eventDispatcher.dispatchEvent(event);
			view.log("准备播放录音...");
		}

		private function handleStopCurrentPlay(event : RecordProxyEvent) : void {
			trace("handle event : " + event);
			eventDispatcher.dispatchEvent(event);
			view.log("停止播放。");
		}

		private function handlePlayerPlaying(event : PlayerProxyEvent) : void {
			view.log("正在播放：");
		}

		// ---------------------------------------
		// HANDLE INCOMING SINGLES
		// ---------------------------------------
		private function handleUpdateTiming(event : JwplayerConnectProxyEvent) : void {
			view.currentPosition(event.data);
			view.log("播放：" + Strings.digits(event.data));
		}

		private function handlePauseTiming(event : JwplayerConnectProxyEvent) : void {
			view.currentPosition(event.data);
			view.log("暂停: " + event.data);
		}

		private function handleRecordRecording(event : RecordProxyEvent) : void {
			view.log('active:' + event.data);
			trace('active:' + event.data);
			MonsterDebugger.trace(this, 'active:' + event.data);
		}

		private function handleEncordComplete(event : RecordProxyEvent) : void {
			view.log(event.data);
			view.onSuccessRecord();
		}

		private function handleEncordError(event : RecordProxyEvent) : void {
			view.log(event.data);
		}

		private function handleRecordComplete(event : RecordProxyEvent) : void {
			/*view.showUploadBtnEncordBtn();*/
		}
	}
}
