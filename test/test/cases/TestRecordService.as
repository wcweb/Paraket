package test.cases {
	import us.wcweb.ParaketContext;

	import flash.events.EventDispatcher;

	import us.wcweb.model.services.RecorderService;

	import asunit.asserts.*;
	import asunit.framework.IAsync;

	import flash.display.Sprite;

	/**
	 * @author macbookpro
	 */
	public class TestRecordService {
		private var service : RecorderService;
		private var serviceDispatcher : EventDispatcher = new EventDispatcher();
		[Inject]
		public var async : IAsync;
		[Inject]
		public var context : Sprite;

		[Before]
		public function setUp() : void {
			serviceDispatcher = new EventDispatcher();
			service = new RecorderService();
			service.eventDispatcher = serviceDispatcher;
		}

		[After]
		public function tearDown() : void {
			this.serviceDispatcher = null;
			this.service = null;
		}

		[Test]
		public function shouldBeInstantiated() : void {
			assertTrue("instance is Recorder", service is RecorderService);
		}
		
		[Test]
		public function testRecord():void{
			
		}
	}
}
