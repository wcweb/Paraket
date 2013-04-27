package us.wcweb.service {
	import flash.net.URLVariables;

	import ru.inspirit.net.events.MultipartURLLoaderEvent;

	import flash.net.URLLoaderDataFormat;

	import ru.inspirit.net.MultipartURLLoader;

	import flash.net.URLRequestHeader;
	import flash.utils.ByteArray;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.display.Loader;
	import flash.net.URLLoader;
	import flash.net.URLRequestMethod;
	import flash.net.URLRequest;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author macbookpro
	 */
	public class BackEndService extends Actor {
		private var url : String = '';
		private var file_post : Object;
		private var loader : URLLoader;
		private var uploadPostObject : Object;
		private var _config : Object;
		private var mp3loader : MultipartURLLoader;

		public function BackEndService() {
			_config = {base_url:'http://127.0.0.1:9292', upload_url:'/uploadmp3', filename:'', fieldname:'Filedata2', username:''};
			// loader = new URLLoader();
			// configureListeners(loader);

			mp3loader = new MultipartURLLoader();
			mp3loader.dataFormat = URLLoaderDataFormat.VARIABLES;

			mp3loader.addEventListener(Event.COMPLETE, onReady);
			mp3loader.addEventListener(MultipartURLLoaderEvent.DATA_PREPARE_PROGRESS, onWrite);
			mp3loader.addEventListener(MultipartURLLoaderEvent.DATA_PREPARE_COMPLETE, onWriteEnd);
//			mp3loader.addVariable('username', 'test variable');
		}

		private function onReady(e : Event) : void {
			trace('DATA UPLOADED');
			//
			// You can access loader returned data:
			var loader : URLLoader = MultipartURLLoader(e.currentTarget).loader;
			var data : URLVariables = new URLVariables(loader.data);
			//
			trace('\nSERVER RESPONSE: ' + data.result);
		}

		private function onWriteEnd(e : MultipartURLLoaderEvent) : void {
			trace('\nDATA PREPARE COMPLETE');
		}

		private function onWrite(e : MultipartURLLoaderEvent) : void {
			trace('Prepare data: ' + e.bytesTotal + '/' + e.bytesWritten);
		}

		public function uploadMp3(mp3 : ByteArray) : void {
			mp3loader.addFile(mp3, (new Date()).getTime() + '.mp3', 'Filedata2');
			mp3loader.load(config.base_url + _config.upload_url);

			// var header : URLRequestHeader = new URLRequestHeader("Content-type", "application/octet-stream");
			// var request : URLRequest = new URLRequest(_config.base_url + _config.upload_url + "?user=" + _config.username);
			// request.requestHeaders.push(header);
			// request.method = URLRequestMethod.POST;
			// request.data = mp3;
			// loader.load(request);
			// trace('request: ', request);
		}

		// private function configureListeners(loader : URLLoader) : void {
		// loader.addEventListener(IOErrorEvent.IO_ERROR, IOError_Handler);
		// loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, SecurityError_Handler);
		// loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, HTTPError_Handler);
		// loader.addEventListener(Event.COMPLETE, Complete_Handler);
		// loader.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, ServerData_Handler);
		//
		// function IOError_Handler(e : IOErrorEvent) : void {
		// trace("IOError_Handler", e.text);
		// }
		// function SecurityError_Handler(e : SecurityErrorEvent) : void {
		// trace("IOError_Handler", e.text);
		// }
		//
		// function HTTPError_Handler(e : HTTPStatusEvent) : void {
		// trace("HTTPError_Handler", e.status);
		// trace("HTTPError_Handler", e.status);
		// }
		//
		// function Complete_Handler(e : Event) : void {
		// trace("Complete_Handler", e.type);
		// }
		// function ServerData_Handler(e : DataEvent) : void {
		// trace("ServerData_Handler", e.text);
		// }
		// }
		public function get config() : Object {
			return _config;
		}

		public function set config(config : Object) : void {
			_config = config;
		}
	}
}
