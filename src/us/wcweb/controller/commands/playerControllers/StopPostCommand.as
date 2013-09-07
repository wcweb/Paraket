package us.wcweb.controller.commands.playerControllers {
	import us.wcweb.model.proxies.RecorderServiceProxy;
	import us.wcweb.service.BackEndService;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author macbookpro
	 */
	public class StopPostCommand extends Command {
		[Inject]
		public var backend : BackEndService;
		[Inject]
		public var proxy : RecorderServiceProxy;

		public function StopPostCommand() {
		}

		override public function execute() : void {
//			if (!proxy.empty()) {
//				backend.stopUpload();
//			}
		}
	}
}
