package us.wcweb {
	import flash.display.DisplayObject;

	import us.wcweb.utils.Tools;

	import asunit.asserts.assertEquals;
	import asunit.asserts.assertEqualsArrays;
	import asunit.asserts.assertEqualsArraysIgnoringOrder;
	import asunit.asserts.assertEqualsFloat;
	import asunit.asserts.assertFalse;
	import asunit.asserts.assertMatches;
	import asunit.asserts.assertNotNull;
	import asunit.asserts.assertNotSame;
	import asunit.asserts.assertNull;
	import asunit.asserts.assertSame;
	import asunit.asserts.assertThrows;
	import asunit.asserts.assertThrowsWithMessage;
	import asunit.asserts.assertTrue;
	import asunit.asserts.fail;
	import asunit.framework.IAsync;

	import flash.display.Sprite;

	import us.wcweb.ParaketContext;

	public class ParaketContextTest {
		[Inject]
		public var async : IAsync;
		[Inject]
		public var context : Sprite;
		private var instance : ParaketContext;
		private var view : Sprite;
		private var objectList : Object;

		[Before]
		public function setUp() : void {
			view = new Sprite();
			context.addChild(view);
			instance = new ParaketContext(view);
			instance.contextView.x = 500;
			objectList = new Object();
		}

		[After]
		public function tearDown() : void {
			// context.removeChild(view);
			// instance = null;
			// view = null;
		}

		[Test]
		public function shouldBeInstantiated() : void {
			// Tools.walkDisplayObjects(instance.contextView,Tools.traceContainer);

			Tools.walkDisplayObjects(instance.contextView, addlist);

			function addlist(child : Object) : void {
				// if (String(child.name).indexOf('instance') == -1) {
				objectList[child.name] = child;
				// }
			}

			

			trace(Tools.getProperties(objectList));
			assertTrue("instance is ParaketContext", instance is ParaketContext);
		}
	}
}

