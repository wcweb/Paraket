package us.wcweb.service {
	import flash.events.HTTPStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.IOErrorEvent;

	import com.demonsters.debugger.MonsterDebugger;

	import us.wcweb.utils.Tools;
	import us.wcweb.model.proxies.LocalConfigProxy;
	import us.wcweb.events.SystemEvent;

	import flash.net.URLVariables;

	import ru.inspirit.net.events.MultipartURLLoaderEvent;

	import flash.net.URLLoaderDataFormat;

	import ru.inspirit.net.MultipartURLLoader;

	import flash.utils.ByteArray;
	import flash.events.Event;
	import flash.net.URLLoader;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author macbookpro
	 */
	public class BackEndService extends Actor {
		private var _default_config : Object;
		private var mp3loader : MultipartURLLoader;

		// [Inject]
		// public var MonsterDebuggerHelper : MonsterDebugger;
		public function BackEndService() {
			// MonsterDebugger.initialize(this);
			_default_config = {// base_url:'http://127.0.0.1:9292',
			upload_url:'http://127.0.0.1:9292/uploadmp3', filename:'default' + (new Date()).toString(), fieldname:'Filedata2', pkid:"pkid", targetType:"mp3", username:'username'};
			// loader = new URLLoader();
			// configureListeners(loader);

			// Tools.__extend(_config, localConfig.parameters);

			mp3loader = new MultipartURLLoader();
			mp3loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			MonsterDebugger.initialize(this);
			MonsterDebugger.trace(this, _default_config);
			// for (var key: Object in _config) {
			// mp3loader.addVariable(key.toString(), _config[key]);
			// }

			// mp3loader.addVariable('username', 'test variable');
			mp3loader.addEventListener(Event.COMPLETE, onReady);
			mp3loader.addEventListener(MultipartURLLoaderEvent.DATA_PREPARE_PROGRESS, onWrite);
			mp3loader.addEventListener(MultipartURLLoaderEvent.DATA_PREPARE_COMPLETE, onWriteEnd);
			mp3loader.addEventListener(IOErrorEvent.IO_ERROR, IOError_Handler);
			mp3loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, SecurityError_Handler);
			mp3loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, HTTPError_Handler);
			function IOError_Handler(e : IOErrorEvent) : void {
				MonsterDebugger.trace("IOError_Handler", e.text);
			}
			function SecurityError_Handler(e : SecurityErrorEvent) : void {
				MonsterDebugger.trace("IOError_Handler", e.text);
			}

			function HTTPError_Handler(e : HTTPStatusEvent) : void {
				MonsterDebugger.trace("HTTPError_Handler", e.status);
			}

			function Complete_Handler(e : Event) : void {
				MonsterDebugger.trace("Complete_Handler", e.type);
			}

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
			dispatch(new SystemEvent(SystemEvent.POST_SUCCESS, 'SERVER RESPONSE: Success '));
		}

		private function onWrite(e : MultipartURLLoaderEvent) : void {
			trace('Prepare data: ' + e.bytesTotal + '/' + e.bytesWritten);
			MonsterDebugger.trace(this, 'Prepare data: ' + e.bytesTotal + '/' + e.bytesWritten);
			dispatch(new SystemEvent(SystemEvent.POST_PROCESS, 'Prepare data: ' + e.bytesTotal + '/' + e.bytesWritten));
		}

		public function uploadMp3(mp3 : ByteArray, config : Object) : void {
			trace("uupload MP3"+config);
			MonsterDebugger.trace(this, config);
			mp3loader.addVariable("kill","motherfucker");
			for (var key:Object in _default_config) {
				if (config.hasOwnProperty(key)) {
					
					mp3loader.addVariable(String(key), config[key]);
				}
			}
			
			mp3loader.addFile(mp3, (new Date()).getTime() + '.mp3', config.filedname);
			mp3loader.load(config.upload_url);

			// var header : URLRequestHeader = new URLRequestHeader("Content-type", "application/octet-stream");
			// var request : URLRequest = new URLRequest(_config.base_url + _config.upload_url + "?user=" + _config.username);
			// request.requestHeaders.push(header);
			// request.method = URLRequestMethod.POST;
			// request.data = mp3;
			// loader.load(request);
			// trace('request: ', request);
		}

		public function stopUpload() : void {
			mp3loader.dispose();
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
	}
}
