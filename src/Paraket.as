package {
	import com.demonsters.debugger.MonsterDebugger;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.system.Security;
	import us.wcweb.ParaketContext;
	import us.wcweb.model.events.JwplayerConnectProxyEvent;
	import us.wcweb.utils.Debug;
	import us.wcweb.utils.Tools;



	public class Paraket extends Sprite {
		private var _context : ParaketContext;
		public var config : Object;

		public function Paraket() {
			super();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			// Security.allowDomain("maps.googleapis.com");
			Security.allowDomain('*');
			Security.allowInsecureDomain('*');
			_context = new ParaketContext(this);

		}

		public function countTime(time : Number) : void {
			// var data : Object = new Object();
			// data = {"time":time, "pause":pause};
			_context.dispatchEvent(new JwplayerConnectProxyEvent(JwplayerConnectProxyEvent.UPDATE_TIME, time));
		}
	}
}

