package us.wcweb.controller.commands {
	import org.robotlegs.mvcs.Command;
	import us.wcweb.controller.commands.playerControllers.PlayCurrentItemCommand;
	import us.wcweb.controller.commands.playerControllers.StartRecordCommand;
	import us.wcweb.controller.commands.playerControllers.StopCurrentItemCommand;
	import us.wcweb.controller.commands.playerControllers.StopRecordCommand;
	import us.wcweb.controller.commands.stageCommands.CleanupStartupCommand;
	import us.wcweb.events.SystemEvent;
	import us.wcweb.model.events.RecordProxyEvent;
	import us.wcweb.model.proxies.AssetLoaderProxy;
	import us.wcweb.model.proxies.JwplayerConnectProxy;
	import us.wcweb.model.proxies.PlayerProxy;
	import us.wcweb.model.proxies.RecorderServiceProxy;
	import us.wcweb.service.BackEndService;
	import us.wcweb.view.components.content.PlayerView;
	import us.wcweb.view.mediators.PlayerViewMediator;


	/**
	 * @author macbookpro
	 */
	public class SmartStartupCommand extends Command {
		override public function execute() : void {
			dispatch(new SystemEvent(SystemEvent.LOAD_CONTENT));
			trace("dispatch loadCOntent");
			contextView.addChild(new PlayerView());
			// models
			injector.mapSingleton(AssetLoaderProxy);
			injector.mapSingleton(JwplayerConnectProxy);
			injector.mapSingleton(BackEndService);
			injector.mapSingleton(PlayerProxy);
			injector.mapSingleton(RecorderServiceProxy);
			// views
			mediatorMap.mapView(PlayerView, PlayerViewMediator);

			// commands
			// commandMap.mapEvent(SystemEvent.LOAD_CONTENT, LoadXMLCommand, SystemEvent, true); // no playlist
			commandMap.mapEvent(SystemEvent.CLEANUP_STARTUP, CleanupStartupCommand, SystemEvent, true);

			commandMap.mapEvent(RecordProxyEvent.START_RECORD, StartRecordCommand);
			commandMap.mapEvent(RecordProxyEvent.STOP_RECORD, StopRecordCommand);

			commandMap.mapEvent(RecordProxyEvent.PLAY_CURRENT_RECORDED, PlayCurrentItemCommand);
			commandMap.mapEvent(RecordProxyEvent.STOP_CURRENT_PLAY, StopCurrentItemCommand);
		}
	}
}
