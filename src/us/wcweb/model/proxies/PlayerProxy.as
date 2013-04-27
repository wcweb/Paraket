package us.wcweb.model.proxies {


	import us.wcweb.view.events.PlayerViewEvent;
	import org.as3wavsound.WavSound;
	import flash.events.SampleDataEvent;
	import flash.utils.ByteArray;

	import us.wcweb.model.events.PlayerProxyEvent;

	import com.noteflight.standingwave3.sources.SoundSource;

	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.net.URLRequest;

	import com.noteflight.standingwave3.output.AudioPlayer;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author macbookpro
	 */
	public class PlayerProxy extends Actor {
		public var player : *;
		public var url : String;
		public var sound : Sound;

		public function PlayerProxy() {
		}

		public function play(url : String) : void {
			//@TODO prefer this player.
			player = new AudioPlayer();
			this.url = url;
			sound.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			sound.addEventListener(Event.COMPLETE, onLoadComplete);
			sound.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			var req : URLRequest = new URLRequest(url);
			sound.load(req);

			function onLoadProgress(event : ProgressEvent) : void {
				var loadedPct : uint = Math.round(100 * (event.bytesLoaded / event.bytesTotal));
				trace("The sound is " + loadedPct + "% loaded.");
			}

			function onLoadComplete(event : Event) : void {
				var localSound : Sound = event.target as Sound;
				player.play(new SoundSource(localSound));

				dispatch(new PlayerProxyEvent(PlayerProxyEvent.PLAYING, url));
			}
			function onIOError(event : IOErrorEvent) : void {
				trace("The sound could not be loaded, but: " + event.text);
				dispatch(new PlayerProxyEvent(PlayerProxyEvent.PLAY_ERROR, "The sound could not be loaded: "));
			}
		}

		public function stop() : void {
			player.stop();
		}

		public function playRaw(wave : ByteArray) : void {
			sound = new Sound();
			player = new WavSound(wave);
			
			player.play();
			//eventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
			dispatch(new PlayerProxyEvent(PlayerProxyEvent.PLAYING, "Current playing"));
			// sound.addEventListener(SampleDataEvent.SAMPLE_DATA, processSound);
			// mp3Player.play(new SoundSource(sound));
			// sound.play();
		}

//		private function processSound(event : SampleDataEvent) : void {
//			event.data.writeBytes(_raw);
//			trace("sound sound ~~~");
//		}
	}
}
