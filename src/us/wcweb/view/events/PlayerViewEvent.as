package us.wcweb.view.events {
	import flash.events.Event;

	/**
	 * No comments here. Basic stuff.
	 * 
	 * @author Peter Lorent peter.lorent@gmail.com
	 * 
	 */
	public class PlayerViewEvent extends Event {
		// --------------------------------------------------------------------------
		//
		// Class Properties
		//
		// --------------------------------------------------------------------------
//		public static const CONTENT_CHANGE : String = "contentChange";
//		public static const ZIP_2_MP3 : String = "zip_2_mp3";
		public static const PLAY_ITEM : String = 'play_item';
		public static const PLAY_LISTITEM_ERROR : String = "play_list_error";
		public static const PLAYING : String = "playing";
		public static const PLAY_ERROR : String = 'play_error';
		//
		// start record
		// pause record
		// stop record
		// start encord
		// encord error
		// encord complete
		// start decord
		// decord error
		// decord complete
		// zip to mp3
		//
		// --------------------------------------------------------------------------
		//
		// Instance Properties
		//
		// --------------------------------------------------------------------------
		private var _data : Object;

		// --------------------------------------------------------------------------
		//
		// Initialization
		//
		// --------------------------------------------------------------------------
		public function PlayerViewEvent(type : String, data : Object) {
			super(type);

			_data = data;
		}

		// --------------------------------------------------------------------------
		//
		// Getters and setters
		//
		// --------------------------------------------------------------------------
		public function get data() : Object {
			return _data;
		}

		// --------------------------------------------------------------------------
		//
		// Overridden API
		//
		// --------------------------------------------------------------------------
		override public function clone() : Event {
			return new PlayerViewEvent(type, data);
		}
	}
}