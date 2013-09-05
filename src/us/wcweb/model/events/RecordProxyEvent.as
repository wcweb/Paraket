package us.wcweb.model.events {
	import flash.events.Event;

	/**
	 * @author macbookpro
	 */
	public class RecordProxyEvent extends Event {
		// --------------------------------------------------------------------------
		//
		// Class Properties
		//
		// --------------------------------------------------------------------------
		// RECORDING
		public static const START_RECORD : String = "start_record";
		public static const RECORDING : String = 'recording';
		public static const PASUE_RECORD : String = "pasue_record";//@TODO pasue_record
		public static const STOP_RECORD : String = "stop_record";
		public static const RECORD_COMPLETE : String = "record_complete";
		// ENCORDING
		public static const START_ENCORD : String = "start_encord";
		public static const ENCORDING : String = 'encording';
		public static const ENCORD_ERROR : String = "encorderror";
		public static const ENCORD_COMPLETE : String = 'encord_complete';//@FIX
		// PLAYING
		public static const PLAY_CURRENT_RECORDED : String = "play_current_recorded";
		public static const STOP_CURRENT_PLAY : String = "stop_current_play";
		public static const PLAY_ITEM : String = 'play_item';
		public static const PLAYING : String = "playing";
		public static const PLAY_ERROR : String = 'play_error';
		// --------------------------------------------------------------------------
		//
		// Instance Properties
		//
		// --------------------------------------------------------------------------
		private var _data : *;

		// --------------------------------------------------------------------------
		//
		// Initialization
		//
		// --------------------------------------------------------------------------
		public function RecordProxyEvent(type : String, data : Object) {
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
			return new RecordProxyEvent(type, data);
		}
	}
}
