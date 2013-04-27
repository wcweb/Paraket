package us.wcweb.model.events {
	import flash.events.Event;

	/**
	 * @author macbookpro
	 */
	public class JwplayerConnectProxyEvent extends Event {
		public static const UPDATE_TIME : String = "updatetime";
		public static const ASYNC_ERROR : String = "asyncerror";
		public static const PAUSE_TIME : String = "pauseTime";
		public static const CLEANUP_STARTUP : String = "cleanupStartup";
		
		public static const REQUEST_BACKCODING : String = "request_backcoding";
		
		
		
		private var _data: *;
		public function JwplayerConnectProxyEvent(type : String, data: * = null) {
			super(type);
			_data = data;
		}

		// --------------------------------------------------------------------------
		//
		// Getters and setters
		//
		// --------------------------------------------------------------------------
		public function get data() : * {
			return _data;
		}

		// --------------------------------------------------------------------------
		//
		// Overridden API
		//
		// --------------------------------------------------------------------------
		override public function clone() : Event {
			return new JwplayerConnectProxyEvent(type, data);
		}
	}
}
