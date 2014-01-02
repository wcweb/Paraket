package us.wcweb.model.events {
	import flash.events.Event;

	/**
	 * @author macbookpro
	 */
	public class PlayerProxyEvent extends Event {
		// --------------------------------------------------------------------------
		//
		// Class Properties
		//
		// --------------------------------------------------------------------------
		public static const BEGIN_PLAY : String = 'begin_play';
		public static const PLAY_ITEM : String = 'play_item';
		public static const PLAYING : String = "playing";
		public static const PLAY_ERROR : String ='play_error';
		public static const PLAY_COMPLETE: String = 'play_complete';
		// --------------------------------------------------------------------------
		//
		// Instance Properties
		//
		// --------------------------------------------------------------------------
		private var _url : String;

		// --------------------------------------------------------------------------
		//
		// Initialization
		//
		// --------------------------------------------------------------------------
		public function PlayerProxyEvent(type : String, url : String) {
			super(type);
			_url = url;
		}

		// --------------------------------------------------------------------------
		//
		// Getters and setters
		//
		// --------------------------------------------------------------------------
		public function get url() : * {
			return _url;
		}

		// --------------------------------------------------------------------------
		//
		// Overridden API
		//
		// --------------------------------------------------------------------------
		override public function clone() : Event {
			return new PlayerProxyEvent(type, url);
		}
	}
}
