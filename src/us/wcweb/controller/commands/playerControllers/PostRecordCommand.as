package us.wcweb.controller.commands.playerControllers {
	import com.demonsters.debugger.MonsterDebugger;

	import us.wcweb.model.proxies.LocalConfigProxy;
	import us.wcweb.view.components.content.PlayerView;
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

		[Inject]
		public var local_config : LocalConfigProxy;

		override public function execute() : void {
//			if (!proxy.empty()) {
//				proxy.eventDispatcher.addEventListener(RecordProxyEvent.ENCORD_COMPLETE, handleEncordComplete);
//			}
			//proxy.eventDispatcher.addEventListener(RecordProxyEvent.ENCORD_COMPLETE, handleEncordComplete);
			// if(proxy.status == proxy.ENCORDED){
			// proxy.eventDispatcher.addEventListener(RecordProxyEvent.ENCORD_COMPLETE, handleEncordComplete);
			// }else{
			// view.log("never record a sound!");
			// }
			trace(local_config.parameters);
			MonsterDebugger.trace(this, local_config.parameters);
			MonsterDebugger.trace(this, proxy.mp3());
			service.uploadMp3(proxy.mp3(), local_config.parameters);
		}

		private function handleEncordComplete(e : RecordProxyEvent) : void {
			
		}
	}
}
