package us.wcweb.controller.commands.playerControllers {
	import us.wcweb.service.BackEndService;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author macbookpro
	 */
	public class StopPostCommand extends Command {
		[Inject]
		public var backend:BackEndService;
		public function StopPostCommand() {
		}
		override public function execute():void{
			 backend.stopUpload();
		}
	}
}
