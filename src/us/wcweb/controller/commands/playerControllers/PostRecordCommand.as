package us.wcweb.controller.commands.playerControllers {
	import us.wcweb.service.BackEndService;
	import us.wcweb.events.SystemEvent;
	import us.wcweb.model.events.RecordProxyEvent;
	import us.wcweb.model.proxies.RecorderServiceProxy;
	import us.wcweb.view.events.PlayerViewEvent;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author macbookpro
	 */
	public class PostRecordCommand extends Command {
		[Inject]
		public var event : SystemEvent;
		[Inject]
		public var proxy : RecorderServiceProxy;
		[Inject]
		public var service : BackEndService;

		override public function execute() : void {
			
			proxy.eventDispatcher.addEventListener(RecordProxyEvent.ENCORD_COMPLETE, handleEncordComplete);
			
		}
		private function handleEncordComplete(e:RecordProxyEvent):void{
			service.uploadMp3(e.target.data);
		}
	}
}
