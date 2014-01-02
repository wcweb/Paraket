package test.cases {
	import us.wcweb.model.proxies.RecorderServiceProxy;
	import us.wcweb.ParaketContext;

	import flash.events.EventDispatcher;

	
	import asunit.asserts.*;
	import asunit.framework.IAsync;

	import flash.display.Sprite;

	/**
	 * @author macbookpro
	 */
	public class TestRecordService {
		private var service : RecorderServiceProxy;
		private var serviceDispatcher : EventDispatcher = new EventDispatcher();
		[Inject]
		public var async : IAsync;
		[Inject]
		public var context : Sprite;

		[Before]
		public function setUp() : void {
			serviceDispatcher = new EventDispatcher();
			service = new RecorderServiceProxy();
			service.eventDispatcher = serviceDispatcher;
		}

		[After]
		public function tearDown() : void {
			this.serviceDispatcher = null;
			this.service = null;
		}

		[Test]
		public function shouldBeInstantiated() : void {
			assertTrue("instance is Recorder", service is RecorderServiceProxy);
		}
		
		[Test]
		public function testRecord():void{
			
		}
	}
}
