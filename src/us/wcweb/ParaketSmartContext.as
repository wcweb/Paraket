package us.wcweb {
	import us.wcweb.controller.commands.SmartStartupCommand;
	import us.wcweb.model.proxies.LocalConfigProxy;
	import us.wcweb.controller.commands.StartupCommand;
	import us.wcweb.controller.commands.PrepControllerCommand;

	import org.robotlegs.base.ContextEvent;

	import us.wcweb.controller.commands.PrepModelCommand;
	import us.wcweb.view.components.content.PlayerView;
	import us.wcweb.view.mediators.PlayerViewMediator;

	import org.robotlegs.mvcs.Context;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author macbookpro
	 */
	public class ParaketSmartContext extends Context {

		[Inject]
		public var local_config : LocalConfigProxy;

		public function ParaketSmartContext(contextView : DisplayObjectContainer = null, autoStartup : Boolean = true) {
			super(contextView, autoStartup);
		}

		override public function startup() : void {
			local_config = new LocalConfigProxy();
			
			local_config.setConfig(this.contextView);
			
			injector.mapValue(LocalConfigProxy, local_config);
			// commandMap.mapEvent( YOUR START UP COMMAND, ContextEvent.STARTUP, ContextEvent, true );
			commandMap.mapEvent(ContextEvent.STARTUP, SmartStartupCommand, ContextEvent, true);



			// View
			// mediatorMap.mapView(YOUR VIEW, YOUR MEDIATOR);

			// Dispatch a start up event
			dispatchEvent(new ContextEvent(ContextEvent.STARTUP));

			// addEventListener(JwplayerConnectProxyEvent.UPDATE_TIME, handleupdateTimer);

			super.startup();
		}
	}
}
