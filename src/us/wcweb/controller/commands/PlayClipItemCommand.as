package us.wcweb.controller.commands {
	import us.wcweb.model.events.PlayerProxyEvent;
	import us.wcweb.model.proxies.PlayerProxy;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author macbookpro
	 */
	public class PlayClipItemCommand extends Command {
		[Inject]
		public var proxy : PlayerProxy;
		
		[Inject]
		public var event: PlayerProxyEvent;
		
		public function PlayClipItemCommand() {
		}
		
		// --------------------------------------------------------------------------
		//
		// Overridden API
		//
		// --------------------------------------------------------------------------
		override public function execute() : void {
			proxy.play(event.url);
		}
	}
}
