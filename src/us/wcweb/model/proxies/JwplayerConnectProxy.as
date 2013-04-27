package us.wcweb.model.proxies {
	import flash.events.StatusEvent;
	import flash.events.AsyncErrorEvent;
	import us.wcweb.model.events.JwplayerConnectProxyEvent;
	import flash.net.LocalConnection;
	import org.robotlegs.mvcs.Actor;
	/**
	 * @author macbookpro
	 */
	public class JwplayerConnectProxy extends Actor {
		private var lc_name:String;
		private var _con:LocalConnection;
		// ---------------------------------------
		// CONSTRUCTOR
		// ---------------------------------------
		public function JwplayerConnectProxy() {
			super();
			initialize();
		}

		// ---------------------------------------
		// PROTECTED METHODS
		// ---------------------------------------
		protected function initialize() : void {
			// Add any initialization here
			// example: myArrayCollection = new ArrayCollection();
			
			lc_name = "lc_arrow";
			_con = new LocalConnection();
			_con.allowDomain('*');
			_con.addEventListener(AsyncErrorEvent.ASYNC_ERROR, _asyncErrorHandler);
			_con.addEventListener(StatusEvent.STATUS, onStatus);
			_con.client = this;
			if (!LocalConnection.isSupported) {
				trace("当前系统不支持localconnection，请升级flashplayer或者切换浏览器");
			}
		}
		
		public function connect():void{
			try {
				_con.connect(lc_name);
			} catch(e : Error) {
				trace("error: " + e);
			}
		}
		private function onStatus(e : StatusEvent) : void {
			switch (e.level) {
				case "status":
					trace("LocalConnection.send() succeeded");
					break;
				case "error":
					trace("LocalConnection.send() failed");
					break;
			}
		}
		public function timeingHandle(num : String) : void {
			dispatch(new JwplayerConnectProxyEvent(JwplayerConnectProxyEvent.UPDATE_TIME,num));
		}

		private function _asyncErrorHandler(e : AsyncErrorEvent) : void {
			dispatch(new JwplayerConnectProxyEvent(JwplayerConnectProxyEvent.ASYNC_ERROR,e));
		}
	
	}
}
