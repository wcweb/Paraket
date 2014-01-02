package test.cases {
	import com.demonsters.debugger.MonsterDebugger;
	import us.wcweb.model.proxies.LocalConfigProxy;
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
	public class TestRecordAndUpload {
		[Inject]
		private var proxy : RecorderServiceProxy;
		[Inject]
		private var serviceDispatcher : EventDispatcher = new EventDispatcher();
		[Inject]
		private var local_config : LocalConfigProxy;
		private var orphanAsync : IAsync;
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
			MonsterDebugger.initialize(this);
			local_config = new LocalConfigProxy();
			local_config.setConfig(context);
			backend = new BackEndService();
			orphanAsync = new Async();
			backend.eventDispatcher = serviceDispatcher;
			proxy.eventDispatcher = serviceDispatcher;
			local_config.eventDispatcher = serviceDispatcher;
		}

		[After]
		public function tearDown() : void {
			this.serviceDispatcher = null;
			this.proxy = null;
			this.backend = null;
			this.local_config = null;
			orphanAsync = null;

			backend = null;
		}

		// [Ignore("because it works")]
		[Test]
		public function shouldBeUploaded() : void {
			var handler : Function = async.add(stopAndUpload, 5000);
			proxy.record();
			setTimeout(handler, 3000);
		}

		private function stopAndUpload() : void {
			proxy.stop();

			proxy.makeIntoMp3(proxy.recorder.output);
			var handler : Function = async.add(onConverCompleteUpload, 8000);

			setTimeout(handler, 3000);
			// proxy.eventDispatcher.addEventListener(Event.COMPLETE, async.add(onConverCompleteUpload, 3000));
		}

		private function onConverCompleteUpload() : void {
			MonsterDebugger.trace(this,local_config.parameters);
			backend.uploadMp3(proxy.mp3(), local_config.parameters);
		}
	}
}
