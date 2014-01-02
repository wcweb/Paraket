package us.wcweb.model.proxies {
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.media.SoundChannel;

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
		public var player : WavSound;
		public var url : String;
		public var sound : Sound;
		private var positionTimer : Timer;

		public function PlayerProxy() {
		}

		public function play(url : String) : void {
			// @TODO prefer this player.
			// player = new AudioPlayer();
			this.url = url;
			sound = new Sound();
			sound.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			sound.addEventListener(Event.COMPLETE, onLoadComplete);
			sound.addEventListener(IOErrorEvent.IO_ERROR, onIOError);

			var req : URLRequest = new URLRequest(url);
			sound.load(req);

			function onLoadProgress(event : ProgressEvent) : void {
				var loadedPct : uint = Math.round(100 * (event.bytesLoaded / event.bytesTotal));
				// trace("The sound is " + loadedPct + "% loaded.");
			}

			function onLoadComplete(event : Event) : void {
				var localSound : Sound = event.target as Sound;
				// player.play(new SoundSource(localSound));
				// player.addEventListener(Event.SOUND_COMPLETE, onPlayComplete);
				dispatch(new PlayerProxyEvent(PlayerProxyEvent.PLAYING, url));
			}
			function onIOError(event : IOErrorEvent) : void {
				// trace("The sound could not be loaded, but: " + event.text);
				dispatch(new PlayerProxyEvent(PlayerProxyEvent.PLAY_ERROR, "The sound could not be loaded: "));
			}

			function onPlayComplete(event : Event) : void {
				// trace("The sound is fuck complete");

				dispatch(new PlayerProxyEvent(PlayerProxyEvent.PLAY_COMPLETE, null));
			}
		}

		public function stop() : void {
			player.stop();
		}

		public function playRaw(wave : ByteArray) : void {
			// sound = new Sound();
			// player.stop();
			player = new WavSound(wave);

			var channel : SoundChannel = WavSound(player).play(0, 0);

			var channel_start_pos : Number = channel.position;
			// trace("channel.position_atfirst == 0?: " + channel.position+" : "+channel_start_pos );
			// channel.addEventListener(Event.SOUND_COMPLETE, onPlayComplete);// not this channnel
			// trace("length: " + player.length);
			// trace("channel.position: " + channel.position);

			// eventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
			dispatch(new PlayerProxyEvent(PlayerProxyEvent.BEGIN_PLAY, "star to play"));
			// sound.addEventListener(SampleDataEvent.SAMPLE_DATA, processSound);
			// mp3Player.play(new SoundSource(sound));
			// sound.play();

			positionTimer = new Timer(10);
			positionTimer.addEventListener(TimerEvent.TIMER, positionTimerHandler);
			positionTimer.start();
			function positionTimerHandler(event : TimerEvent) : void {
				// trace("player.length+  channel_start_pos * 10: " + player.length + " : " + channel_start_pos+" : "+positionTimer.currentCount)
				// trace("positionTimerHandler: " + channel.position.toFixed(2));
				if (channel.position > (player.length + channel_start_pos) * 1 ) {
					positionTimer.stop();
					// trace("The sound is end");

					dispatch(new PlayerProxyEvent(PlayerProxyEvent.PLAY_COMPLETE, null));
					positionTimer.removeEventListener(TimerEvent.TIMER, positionTimerHandler)
				}
			}
		}
		// private function processSound(event : SampleDataEvent) : void {
		// event.data.writeBytes(_raw);
		// trace("sound sound ~~~");
		// }
	}
}
