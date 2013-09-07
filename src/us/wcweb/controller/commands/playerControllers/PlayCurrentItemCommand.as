package us.wcweb.controller.commands.playerControllers {
	import us.wcweb.model.events.RecordProxyEvent;
	import us.wcweb.model.proxies.RecorderServiceProxy;
	import us.wcweb.view.events.PlayerViewEvent;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author macbookpro
	 */
	public class PlayCurrentItemCommand extends Command {
		[Inject]
		public var event : RecordProxyEvent;
		[Inject]
		public var proxy : RecorderServiceProxy;

		override public function execute() : void {
			if (!proxy.empty()) {
				proxy.play();
			}
		}
	}
}
