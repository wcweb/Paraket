package us.wcweb {
	import us.wcweb.model.events.JwplayerConnectProxyEvent;
	import us.wcweb.utils.Tools;
	import us.wcweb.model.proxies.LocalConfigProxy;
	import us.wcweb.controller.commands.PrepModelCommand;
	import us.wcweb.controller.commands.PrepControllerCommand;
	import us.wcweb.controller.commands.PreViewCommand;

	import flash.display.DisplayObjectContainer;

	import org.robotlegs.mvcs.Context;
	import org.robotlegs.base.ContextEvent;

	import us.wcweb.controller.commands.StartupCommand;

	public class ParaketContext extends Context {
		public var config : Object;
		[Inject]
		public var local_config : LocalConfigProxy;

		// ---------------------------------------
		// CONSTRUCTOR
		// ---------------------------------------
		public function ParaketContext(contextView : DisplayObjectContainer = null, autoStartup : Boolean = true) {
			super(contextView, autoStartup);
		}

		// ---------------------------------------
		// OVERRIDEN METHODS
		// ---------------------------------------
		override public function startup() : void {
			// Service
			// injector.mapSingleton(YOUR SERVICE);

			// Model
			// injector.mapSingleton(YOUR PROXY);

			local_config = new LocalConfigProxy();
			local_config.setConfig(this.contextView);

			injector.mapValue(LocalConfigProxy, local_config);

			// Controller
			// commandMap.mapEvent( YOUR START UP COMMAND, ContextEvent.STARTUP, ContextEvent, true );
			commandMap.mapEvent(ContextEvent.STARTUP, PrepModelCommand, ContextEvent, true);
			commandMap.mapEvent(ContextEvent.STARTUP, PreViewCommand, ContextEvent, true);
			commandMap.mapEvent(ContextEvent.STARTUP, PrepControllerCommand, ContextEvent);
			commandMap.mapEvent(ContextEvent.STARTUP, StartupCommand, ContextEvent, true);

			// View
			// mediatorMap.mapView(YOUR VIEW, YOUR MEDIATOR);

			// Dispatch a start up event
			dispatchEvent(new ContextEvent(ContextEvent.STARTUP));

//			addEventListener(JwplayerConnectProxyEvent.UPDATE_TIME, handleupdateTimer);

			super.startup();
		}

//		private function handleupdateTimer(e : JwplayerConnectProxyEvent) : void {
//			dispatchEvent(e);
//		}
	}
}