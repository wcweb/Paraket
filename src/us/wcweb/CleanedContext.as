package us.wcweb {
	import flash.display.DisplayObjectContainer;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	import us.wcweb.controller.commands.PreViewCommand;
	import us.wcweb.controller.commands.PrepControllerCommand;
	import us.wcweb.controller.commands.PrepModelCommand;
	import us.wcweb.controller.commands.StartupCommand;
	import us.wcweb.controller.commands.playerControllers.PlayClipItemCommand;
	import us.wcweb.model.events.PlayerProxyEvent;
	import us.wcweb.model.proxies.LocalConfigProxy;
	import us.wcweb.model.proxies.PlayerProxy;
	import us.wcweb.utils.Tools;



	public class CleanedContext extends Context {

		// ---------------------------------------
		// CONSTRUCTOR
		// ---------------------------------------
		public function CleanedContext(contextView : DisplayObjectContainer = null, autoStartup : Boolean = true) {
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
			
			injector.mapSingleton(PlayerProxy);
			
			
			
			// Controller
			// commandMap.mapEvent( YOUR START UP COMMAND, ContextEvent.STARTUP, ContextEvent, true );
			
			commandMap.mapEvent(PlayerProxyEvent.PLAY_ITEM, PlayClipItemCommand, PlayerProxyEvent);
			

			// View
			// mediatorMap.mapView(YOUR VIEW, YOUR MEDIATOR);

			// Dispatch a start up event
			dispatchEvent(new ContextEvent(ContextEvent.STARTUP));

			super.startup();
		}
	}
}