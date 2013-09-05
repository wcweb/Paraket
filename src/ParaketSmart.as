package {
	import us.wcweb.model.events.JwplayerConnectProxyEvent;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.Sprite;

	import us.wcweb.ParaketContext;

	/**
	 * @author macbookpro
	 */
	public class ParaketSmart extends Sprite {
		private var _context : ParaketContext;
		public var config : Object;

		public function ParaketSmart() {
			super();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			// Security.allowDomain("maps.googleapis.com");

			_context = new ParaketContext(this);
		}

		public function countTime(time : Number) : void {
			// var data : Object = new Object();
			// data = {"time":time, "pause":pause};
			_context.dispatchEvent(new JwplayerConnectProxyEvent(JwplayerConnectProxyEvent.UPDATE_TIME, time));
		}
	}
}
