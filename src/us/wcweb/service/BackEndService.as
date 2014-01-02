package us.wcweb.service {
	import flash.system.Security;
	import flash.external.ExternalInterface;
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
			Security.allowDomain('*');
			Security.allowInsecureDomain('*');
			// MonsterDebugger.initialize(this);
			_default_config = {// base_url:'http://127.0.0.1:9292',
			upload_url:'http://127.0.0.1:9292/uploadmp3_default', filename:'default' + (new Date()).toString(), fieldname:'Filedata2', pkid:"pkid", targetType:"mp3", completeFunc:"completeFunc", username:'username'};
			// loader = new URLLoader();
			// configureListeners(loader);

			// Tools.__extend(_config, localConfig.parameters);
		}

		private function onWriteEnd(e : MultipartURLLoaderEvent) : void {
			// trace('\nDATA PREPARE COMPLETE');
		}

		private function onWrite(e : MultipartURLLoaderEvent) : void {
			// trace('Prepare data: ' + e.bytesTotal + '/' + e.bytesWritten);
			MonsterDebugger.trace(this, 'Prepare data: ' + e.bytesTotal + '/' + e.bytesWritten);
			dispatch(new SystemEvent(SystemEvent.POST_PROCESS, 'Prepare data: ' + e.bytesTotal + '/' + e.bytesWritten));
		}

		public function uploadMp3(mp3 : ByteArray, config : Object) : void {
			mp3loader = new MultipartURLLoader();
			mp3loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			MonsterDebugger.initialize(this);
			MonsterDebugger.trace(this, _default_config);
			for (var key:Object in _default_config) {
				if (config.hasOwnProperty(key)) {
					mp3loader.addVariable(String(key), config[key]);
				}
			}
			mp3loader.addEventListener(Event.COMPLETE, onCompleteHandler);
			mp3loader.addEventListener(MultipartURLLoaderEvent.DATA_PREPARE_PROGRESS, onWrite);
			mp3loader.addEventListener(MultipartURLLoaderEvent.DATA_PREPARE_COMPLETE, onWriteEnd);
			mp3loader.addEventListener(IOErrorEvent.IO_ERROR, IOError_Handler);
			mp3loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, SecurityError_Handler);
			mp3loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, HTTP_STATUS_Handler);

			function IOError_Handler(e : IOErrorEvent) : void {
				MonsterDebugger.trace("IOError_Handler", e.text);
				dispatch(new SystemEvent(SystemEvent.POST_ERROR, 'SERVER RESPONSE: IOError '));
			}
			function SecurityError_Handler(e : SecurityErrorEvent) : void {
				MonsterDebugger.trace("IOError_Handler", e.text);
				dispatch(new SystemEvent(SystemEvent.POST_ERROR, 'SERVER RESPONSE: SecurityError '));
			}

			function HTTP_STATUS_Handler(e : HTTPStatusEvent) : void {
				if (e.status !== 200) {
					dispatch(new SystemEvent(SystemEvent.POST_ERROR, 'SERVER RESPONSE: e.status '));
				} else {
					MonsterDebugger.trace("HTTP_STATUS_Handler", e.status);
					MonsterDebugger.trace(this, "this time wait fuck complete");
					// MonsterDebugger.trace(this,e.status);
					// mp3loader.dispatchEvent(new Event(Event.COMPLETE));
					dispatch(new SystemEvent(SystemEvent.POST_SUCCESS, 'SERVER RESPONSE: Success '));
				}
			}
			function onCompleteHandler(e : Event) : void {
				trace('DATA UPLOADED');
				MonsterDebugger.trace(this, '\nSERVER RESPONSE: ' + e);
				// You can access loader returned data:
				var loader : URLLoader = MultipartURLLoader(e.currentTarget).loader;
				MonsterDebugger.trace(this, loader);
				var data : URLVariables = new URLVariables(loader.data);
				
				//
				MonsterDebugger.trace(this, '\nSERVER RESPONSE: ' + data);
				if (ExternalInterface.available) {
					// MonsterDebugger.trace("config.completeFunc", config.completeFunc);

					ExternalInterface.call(config.completeFunc, data);
				}
				MonsterDebugger.trace(this, '\nSERVER RESPONSE Event: ' + e);
				//dispatch(new SystemEvent(SystemEvent.POST_SUCCESS, 'SERVER RESPONSE: Success '));
			}

			// trace("uupload MP3"+config);
			// MonsterDebugger.trace(this, config);
			// mp3loader.addVariable("kill", "motherfucker");

			// Tools.__extend(config, _default_config);

			mp3loader.addFile(mp3, (new Date()).getTime() + '.mp3', config.filedname);
			// try throw error
			try {
				mp3loader.load(config.upload_url);
			} catch(e : Error) {
				dispatch(new SystemEvent(SystemEvent.POST_ERROR, 'SERVER RESPONSE: can\'t not work at local. '));
			}

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
