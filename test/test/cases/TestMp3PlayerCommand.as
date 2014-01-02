package test.cases {
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
	import asunit.events.TimeoutCommandEvent;
	import asunit.framework.Async;
	import asunit.framework.ErrorEvent;
	import asunit.framework.IAsync;
	import asunit.framework.TimeoutCommand;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	import org.robotlegs.base.CommandMap;
	import org.robotlegs.mvcs.Context;
	import org.swiftsuspenders.Injector;
	import org.swiftsuspenders.Reflector;
	// import org.swiftsuspenders.mapping.MappingEvent;
	import us.wcweb.CleanedContext;
	import us.wcweb.ParaketContext;
	import us.wcweb.controller.commands.playerControllers.PlayClipItemCommand;
	import us.wcweb.model.events.PlayerProxyEvent;
	import us.wcweb.model.proxies.PlayerProxy;

	import us.wcweb.view.components.content.PlayListView;
	import us.wcweb.view.mediators.PlayListMediator;

	/**
	 * @author macbookpro
	 */
	public class TestMp3PlayerCommand {
		private var proxy : PlayerProxy;
		private var serviceDispatcher : EventDispatcher;
		private var serviceDispatcher2 : EventDispatcher;
		private var dispatcher : EventDispatcher;
		private var orphanAsync : Async;
		private var view : PlayListView;
		private var command : TimeoutCommand;
		private var controller : PlayClipItemCommand;
		private var timeoutID : int = -1;
		[Inject]
		private var mediator : PlayListMediator;
		private var mp3 : String = 'http://127.0.0.1:9292/assets/abc.mp3';
		[Inject]
		public var async : IAsync;
		public var context : CleanedContext;

		[Before]
		public function setUp() : void {
			serviceDispatcher = new EventDispatcher();
			// async event test
			dispatcher = new EventDispatcher();
			orphanAsync = new Async();
			// serviceDispatcher2 = new EventDispatcher();
			context = new CleanedContext();

			mediator = new PlayListMediator();
			view = new PlayListView();
			proxy = new PlayerProxy();

			// controller = new PlayClipItemCommand();

			// var injector:Injector = new Injector();
			// var reflector:Reflector = new Reflector();
			// var commandMap:CommandMap = new CommandMap(serviceDispatcher,injector,reflector);
			// controller.commandMap = commandMap;
			// controller.commandMap.mapEvent(PlayerProxyEvent.PLAYING, PlayClipItemCommand);
			// controller.injector.mapSingleton(Mp3PlayerProxy);

			mediator.view = view;
			mediator.setViewComponent(view);
			mediator.eventDispatcher = context.eventDispatcher;
			mediator.onRegister();
		}

		[After]
		public function tearDown() : void {
			this.serviceDispatcher = null;
			this.mediator = null;
			view = null;
			controller = null;
			dispatcher = null;
			orphanAsync = null;
			timeoutID = -1;
			command = null;
			context = null;
		}

		[Test(async)]
		public function testPlaythroungEvent() : void {
			orphanAsync.proceedOnEvent(dispatcher, Event.COMPLETE, 10);
			orphanAsync.proceedOnEvent(mediator.eventDispatcher, PlayerProxyEvent.PLAYING, 10);
			var commands : Array = orphanAsync.getPending();

			// var handler : Function = async.add(handlePlaying, 20000);
			// mediator.playItemTest(mp3);
			// setTimeout(handlePlaying, 10000);
			var command : TimeoutCommand = commands[0];
			command.addEventListener(TimeoutCommandEvent.TIMED_OUT, async.add(onAsyncMethodFailed, 500));
			command = commands[1];
			command.addEventListener(PlayerProxyEvent.PLAYING, async.add(handlePlaying));

			timeoutID = setTimeout(function() : void {
				mediator.playItemTest(mp3);
				dispatchCompleteEvent();
			}, 10);
			// mediator.eventDispatcher.dispatchEvent(new PlayerProxyEvent(PlayerProxyEvent.PLAY_ITEM, mp3));
		}

		private function handlePlaying(e : PlayerProxyEvent) : void {
			assertEquals("handlePlaying event url", mp3, e.url);
			trace("handlePlaying event url", mp3, e.url);
		}

		[Ignore("because it works")]
		[Test]
		public function directPlay() : void {
			proxy.play(mp3);
			proxy.eventDispatcher.addEventListener(PlayerProxyEvent.PLAYING, handleAllPlayerEvent);
			proxy.eventDispatcher.addEventListener(PlayerProxyEvent.PLAY_ERROR, handleAllPlayerEvent);
		}

		private function handleAllPlayerEvent(e : PlayerProxyEvent) : void {
			assertEquals("handleAllPlayerEvent url", mp3, e.url);
		}

		[Ignore("because it works")]
		[Test]
		public function shouldBeInstantiated() : void {
			assertTrue("instance is mediator", mediator is PlayListMediator);
		}

		[Test]
		public function proceedOnEventShouldDispatchCorrectEventAndClearPendingCommands() : void {
			orphanAsync.proceedOnEvent(dispatcher, Event.COMPLETE, 10);

			var commands : Array = orphanAsync.getPending();
			trace(commands);
			assertEquals("one pending command for test after proceedOnEvent()", 1, commands.length);

			// send the correct event synchronously
			dispatchCompleteEvent();

			var message : String = "No pending commands for test after correct Event dispatched.";
			assertEquals(message, 0, orphanAsync.getPending().length);
		}

		[Test]
		public function proceedOnEventShouldTimeoutAppropriately() : void {
			// Grab a reference to the Dispatcher so that we still have
			// it after the test run (Fixing uncaught RTE null pointer exception)
			var source : IEventDispatcher = dispatcher;

			// This is the initial setup, we want test execution to pause
			// for 1ms OR until the COMPLETE event fires:
			orphanAsync.proceedOnEvent(source, Event.COMPLETE, 1);

			// Get the Command so that we can just wait for the TIMED_OUT event:
			var commands : Array = orphanAsync.getPending();
			var command : TimeoutCommand = commands[0];
			command.addEventListener(TimeoutCommandEvent.TIMED_OUT, async.add(onAsyncMethodFailed, 500));

			// send the correct event too slowly
			timeoutID = setTimeout(function() : void {
				source.dispatchEvent(new Event(Event.COMPLETE));
			}, 10);
		}

		protected function onAsyncMethodFailed(event : TimeoutCommandEvent) : void {
			assertEquals("event type", TimeoutCommandEvent.TIMED_OUT, event.type);
			clearTimeout(timeoutID);
		}

		[Test(async)]
		public function proceedOnEventShouldSendCALLEDEventAsExpected() : void {
			orphanAsync.proceedOnEvent(dispatcher, Event.COMPLETE, 100);

			command = orphanAsync.getPending()[0];

			// Use AsUnit 3's orphanAsync.add() to verify onAsyncMethodCalled is called.
			command.addEventListener(TimeoutCommandEvent.CALLED, async.add(onAsyncMethodCalled));

			// If all goes well, the ErrorEvent won't be dispatched.
			command.addEventListener(ErrorEvent.ERROR, failIfCalled);

			// send the correct event faster than orphanAsync.proceedOnEvent duration
			setTimeout(dispatchCompleteEvent, 10);
		}

		private function dispatchCompleteEvent() : void {
			dispatcher.dispatchEvent(new Event(Event.COMPLETE));
		}

		protected function onAsyncMethodCalled(e : Event) : void {
			assertEquals("event type", TimeoutCommandEvent.CALLED, e.type);
		}

		protected function failIfCalled(e : Event = null) : void {
			fail("ProceedOnEventTest: This function should not have been called");
		}
	}
}
