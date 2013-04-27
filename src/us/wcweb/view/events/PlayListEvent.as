package us.wcweb.view.events {
	import flash.events.Event;

	/**
	 * No comments here. Basic stuff.
	 * 
	 * @author Peter Lorent peter.lorent@gmail.com
	 * 
	 */
	public class PlayListEvent extends Event {
		// --------------------------------------------------------------------------
		//
		// Class Properties
		//
		// --------------------------------------------------------------------------
		public static const CONTENT_CHANGE : String = "contentChange";
		public static const PLAY_CLIP : String ="playClip";
		public static const STOP_CLIP : String ="stopClip";
		public static const PLAY_LISTITEM_ERROR : String = "contentChange";
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
		public function PlayListEvent(type : String, url : String) {
			super(type);

			_url = url;
		}

		// --------------------------------------------------------------------------
		//
		// Getters and setters
		//
		// --------------------------------------------------------------------------
		public function get url() : String {
			return _url;
		}

		// --------------------------------------------------------------------------
		//
		// Overridden API
		//
		// --------------------------------------------------------------------------
		override public function clone() : Event {
			return new PlayListEvent(type, url);
		}
	}
}