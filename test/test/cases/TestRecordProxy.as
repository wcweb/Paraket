package test.cases {
	import us.wcweb.model.events.RecordProxyEvent;
	import us.wcweb.service.BackEndService;

	import flash.utils.ByteArray;

	import asunit.framework.ErrorEvent;

	import org.osmf.metadata.NullMetadataSynthesizer;

	import asunit.framework.Async;

	import org.as3wavsound.WavSound;

	import com.noteflight.standingwave3.output.AudioPlayer;

	import us.wcweb.model.proxies.PlayerProxy;

	import asunit.events.TimeoutCommandEvent;
	import asunit.framework.TimeoutCommand;

	import flash.utils.clearTimeout;
	import flash.events.Event;
	import flash.utils.setTimeout;

	import us.wcweb.model.proxies.RecorderServiceProxy;
	import us.wcweb.ParaketContext;

	import flash.events.EventDispatcher;

	import asunit.asserts.*;
	import asunit.framework.IAsync;

	import flash.display.Sprite;

	/**
	 * @author macbookpro
	 */
	public class TestRecordProxy {
		[Inject]
		private var proxy : RecorderServiceProxy;
		[Inject]
		private var serviceDispatcher : EventDispatcher = new EventDispatcher();
		private var timer : uint;
		private var dispatcher : EventDispatcher;
		private var orphanAsync : IAsync;
		private var command : TimeoutCommand;
		private var timeoutID : int = -1;
		private var backend : BackEndService;
		[Inject]
		public var async : IAsync;
		[Inject]
		public var context : Sprite;
		public var player : PlayerProxy;
		public var repeatTime : int = 0;

		[Before]
		public function setUp() : void {
			serviceDispatcher = new EventDispatcher();
			proxy = new RecorderServiceProxy();
			player = new PlayerProxy();
			player.eventDispatcher = serviceDispatcher;
			proxy.player = player;
			backend = new BackEndService();
			orphanAsync = new Async();
			proxy.eventDispatcher = serviceDispatcher;
			dispatcher = new EventDispatcher();
			repeatTime = 0;
		}

		[After]
		public function tearDown() : void {
			this.serviceDispatcher = null;
			this.proxy = null;
			player = null;
			orphanAsync = null;
			timeoutID = -1;
			command = null;
			backend = null;
		}

		[Ignore("because it works")]
		[Test]
		public function shouldBeInstantiated() : void {
			assertTrue("instance is Recorder", proxy is RecorderServiceProxy);
		}

		[Ignore("because it works")]
		[Test]
		public function shouldBeUploaded() : void {
			var handler : Function = async.add(stopAndUpload, 20000);
			proxy.record();
			setTimeout(handler, 10000);
		}

		private function stopAndUpload() : void {
			proxy.stop();
			
			proxy.makeIntoMp3(proxy.recorder.output);
			var handler : Function = async.add(onConverCompleteUpload, 8000);

			setTimeout(handler, 6000);
			// proxy.eventDispatcher.addEventListener(Event.COMPLETE, async.add(onConverCompleteUpload, 3000));
		}

		private function onConverCompleteUpload() : void {
			backend.uploadMp3(proxy.mp3(), {});
		}

		// [Ignore("because it works")]
		[Test]
		public function shouldBeRecordAndPlay() : void {
			if (repeatTime > 1) {
				assertTrue("proxy",proxy.player is PlayerProxy);
			} else {
				repeatTime += 1;
				orphanAsync.timeout = 5000;
				// orphanAsync.proceedOnEvent(player.eventDispatcher, Event.COMPLETE);
				var handler : Function = async.add(stopAndplay, 4000*repeatTime);
				proxy.record();
				setTimeout(handler, 3000*repeatTime);
			}
		}

		private function stopAndplay() : void {
			// proxy.makeIntoMp3(proxy.recorder.output);

			proxy.stop();
			var handler : Function = async.add(onConverCompletePlay, 5000*repeatTime);
			setTimeout(handler, 500*repeatTime);
			// orphanAsync.proceedOnEvent(serviceDispatcher, RecordProxyEvent.ENCORD_COMPLETE, 1000);

			command = orphanAsync.getPending()[0];

			
		}

		private function onConverCompletePlay() : void {
			trace("before play!");
			
			var handler : Function = async.add(shouldBeRecordAndPlay, 20000*repeatTime);
			proxy.play();
			setTimeout(handler, 5000*repeatTime);
			// assertEquals(" pend end !", 0, orphanAsync.getPending().length);
		}

		[Ignore("because it works")]
		[Test(async)]
		public function testRecord() : void {
			// (async.getPending()[0] as TimeoutCommand).addEventListener(TimeoutCommandEvent.CALLED, async.add(stopandRender,1000));
			// timer= setTimeout(async.add(stopandRender), 10000);

			orphanAsync.proceedOnEvent(dispatcher, Event.COMPLETE);

			var commands : Array = orphanAsync.getPending();
			assertEquals("one pending command for test after proceedOnEvent()", 1, commands.length);

			dispatchCompleteEvent();

			var message : String = "No pending commands for test after correct Event dispatched.";

			var handler : Function = async.add(stopandRender, 4000);
			trace('wwwwwww');
			proxy.record();
			setTimeout(handler, 2000);

			assertEquals(message, 0, orphanAsync.getPending().length);
		}

		private function dispatchCompleteEvent() : void {
			dispatcher.dispatchEvent(new Event(Event.COMPLETE));
		}

		private function stopandRender() : void {
			trace('proxy', proxy.recorder);
			proxy.stop();
			// player = new WavSound(proxy.recorder.output);
			// player.play();

			proxy.makeIntoMp3(proxy.recorder.output);

			var handler : Function = async.add(stopandRender, 4000);
			trace('wwwwwww');
			proxy.record();
			setTimeout(handler, 2000);

			proxy.eventDispatcher.addEventListener(Event.COMPLETE, async.add(onConverComplete, 2000));
			// proxy.recorder.addEventListener(Event.COMPLETE, handleComplete);
			// clearTimeout(timer);
			assertTrue("instance is Recorder", proxy is RecorderServiceProxy);
		}

		private function onConverComplete() : void {
			assertTrue("instance is mp3", proxy.mp3() is ByteArray);
		}

		private function handleComplete(e : Event) : void {
			trace(proxy.recorder.output);
			// player = new WavSound(proxy.recorder.output);
			// player.play();
		}

		protected function onAsyncMethodFailed(event : TimeoutCommandEvent) : void {
			assertEquals("event type", TimeoutCommandEvent.TIMED_OUT, event.type);
			clearTimeout(timeoutID);
		}

		[Ignore("because it works")]
		[Test(async)]
		public function proceedOnEventShouldSendCALLEDEventAsExpected() : void {
			orphanAsync.proceedOnEvent(dispatcher, Event.COMPLETE, 10);

			command = orphanAsync.getPending()[0];

			// Use AsUnit 3's orphanAsync.add() to verify onAsyncMethodCalled is called.
			command.addEventListener(TimeoutCommandEvent.CALLED, async.add(onAsyncMethodCalled));

			// If all goes well, the ErrorEvent won't be dispatched.
			command.addEventListener(ErrorEvent.ERROR, failIfCalled);

			// send the correct event faster than orphanAsync.proceedOnEvent duration
			setTimeout(dispatchCompleteEvent, 0);
		}

		protected function onAsyncMethodCalled(e : Event) : void {
			assertEquals("event type", TimeoutCommandEvent.CALLED, e.type);
		}

		protected function failIfCalled(e : Event = null) : void {
			fail("ProceedOnEventTest: This function should not have been called");
		}
	}
}
