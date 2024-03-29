/*
 * Copyright (c) 2009 the original author or authors
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package us.wcweb.events {
	import flash.events.Event;

	/**
	 * No comments here. Basic stuff.
	 *  
	 * @author Peter Lorent peter.lorent@gmail.com
	 * 
	 */
	public class SystemEvent extends Event {
		// --------------------------------------------------------------------------
		//
		// Class Properties
		//
		// --------------------------------------------------------------------------
		public static const LOAD_CONTENT : String = "loadContent";
		// public static const GOOGLE_MAP_ON_STAGE : String = "googleMapOnStage";
		// public static const REQUEST_GEOCODING : String = "requestGeoCoding";
		public static const CLEANUP_STARTUP : String = "cleanupStartup";
		// public static const REQUEST_BACKCODING : String = "request_backcoding";
		public static const START_RECORD : String = "star_record";
		public static const POST_RECORD : String = "post_record";
		public static const POST_ERROR : String = "post_error";
		public static const STOP_POST : String = "stop_post";
		public static const STAGE_CLICK : String = "stage_click";
		public static const POST_PROCESS : String = "post_process";
		public static const POST_SUCCESS :String = "post_success";

		// --------------------------------------------------------------------------
		//
		// Instance Properties
		//
		// --------------------------------------------------------------------------
		private var _body : *;

		// --------------------------------------------------------------------------
		//
		// Initialization
		//
		// --------------------------------------------------------------------------
		public function SystemEvent(type : String, body : * = null) {
			super(type);

			_body = body;
		}

		// --------------------------------------------------------------------------
		//
		// Getters and setters
		//
		// --------------------------------------------------------------------------
		public function get body() : * {
			return _body;
		}

		// --------------------------------------------------------------------------
		//
		// Overridden API
		//
		// --------------------------------------------------------------------------
		override public function clone() : Event {
			return new SystemEvent(type, body);
		}
	}
}