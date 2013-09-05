package us.wcweb.view.mediators {
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
			eventMap.mapListener(view, RecordProxyEvent.PLAY_CURRENT_RECORDED, handlePlayCurrentRecorded);
			eventMap.mapListener(view, RecordProxyEvent.STOP_CURRENT_PLAY, handleStopCurrentPlay);

			eventMap.mapListener(view, SystemEvent.POST_RECORD, handlePostRecord);
			eventMap.mapListener(view, SystemEvent.STOP_POST, handleStopPost);
			eventMap.mapListener(view, SystemEvent.STAGE_CLICK, handleStageClick);

			eventMap.mapListener(eventDispatcher, JwplayerConnectProxyEvent.UPDATE_TIME, handleUpdateTiming);
			eventMap.mapListener(eventDispatcher, JwplayerConnectProxyEvent.PAUSE_TIME, handlePauseTiming);

			eventMap.mapListener(eventDispatcher, RecordProxyEvent.ENCORD_COMPLETE, handleEncordComplete);

			eventMap.mapListener(eventDispatcher, RecordProxyEvent.RECORD_COMPLETE, handleRecordComplete);
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
		}

		private function handleStopPost(event : SystemEvent) : void {
			dispatch(event);
		}

		private function handleStageClick(event : SystemEvent) : void {
			dispatch(event);
		}

		private function handleStartRecord(event : RecordProxyEvent) : void {
			dispatch(event);
		}

		private function handleStopRecord(event : RecordProxyEvent) : void {
			trace("handle timing update :" + event);
			// dispatch(event)
			eventDispatcher.dispatchEvent(event);
		}

		private function handlePlayCurrentRecorded(event : RecordProxyEvent) : void {
			trace("handle event : " + event);
			eventDispatcher.dispatchEvent(event);
		}

		private function handleStopCurrentPlay(event : RecordProxyEvent) : void {
			trace("handle event : " + event);
			eventDispatcher.dispatchEvent(event);
		}

		// ---------------------------------------
		// HANDLE INCOMING SINGLES
		// ---------------------------------------
		private function handleUpdateTiming(event : JwplayerConnectProxyEvent) : void {
			view.currentPosition(event.data);
		}

		private function handlePauseTiming(event : JwplayerConnectProxyEvent) : void {
			view.currentPosition(event.data);
		}

		private function handleEncordComplete(event : RecordProxyEvent) : void {
		}

		private function handleRecordComplete(event : RecordProxyEvent) : void {
			/*view.showUploadBtnEncordBtn();*/
		}
	}
}
