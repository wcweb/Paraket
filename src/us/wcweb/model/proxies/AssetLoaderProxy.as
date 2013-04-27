package us.wcweb.model.proxies {
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	import us.wcweb.model.events.AssetLoaderProxyEvent;
	import org.robotlegs.mvcs.Actor;

	/**
	 * Proxy to load the xml content.
	 *  
	 * @author Peter Lorent peter.lorent@gmail.com
	 * 
	 */
	public class AssetLoaderProxy extends Actor {
		// --------------------------------------------------------------------------
		//
		// Instance Properties
		//
		// --------------------------------------------------------------------------
		private var _urlLoader : URLLoader;

		// --------------------------------------------------------------------------
		//
		// Initialization
		//
		// --------------------------------------------------------------------------
		/**
		 * Nah, no comment. 
		 * 
		 */
		public function AssetLoaderProxy() {
			super();
		}

		// --------------------------------------------------------------------------
		//
		// API
		//
		// --------------------------------------------------------------------------
		/**
		 * No comment.
		 *  
		 * @param url String
		 * 
		 */
		public function loadXMLContent(url : String) : void {
			var urlRequest : URLRequest = new URLRequest(url);
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE, onXMLContentLoaded);
			_urlLoader.load(urlRequest);
		}

		// --------------------------------------------------------------------------
		//
		// Eventhandling
		//
		// --------------------------------------------------------------------------
		/**
		 * Event handler. Dispatches an AssetLoaderProxyEvent so the ContentMediator
		 * can pass the data to its view component.
		 *  
		 * @param event Event
		 * 
		 */
		private function onXMLContentLoaded(event : Event) : void {
			var data : XML = new XML(_urlLoader.data);

			dispatch(new AssetLoaderProxyEvent(AssetLoaderProxyEvent.XML_CONTENT_LOADED, data));

			_urlLoader.removeEventListener(Event.COMPLETE, onXMLContentLoaded);
			_urlLoader = null;
		}
	}
}