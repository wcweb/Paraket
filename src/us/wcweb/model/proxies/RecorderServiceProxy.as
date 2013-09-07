package us.wcweb.model.proxies {
	import us.wcweb.view.components.content.PlayerView;
	import us.wcweb.model.events.RecordProxyEvent;

	import flash.events.ErrorEvent;

	import org.as3wavsound.WavSound;

	import flash.media.Microphone;

	import us.wcweb.utils.Tools;

	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import com.noteflight.standingwave3.elements.AudioDescriptor;
	import com.noteflight.standingwave3.performance.AudioPerformer;
	import com.noteflight.standingwave3.performance.ListPerformance;
	import com.noteflight.standingwave3.elements.Sample;
	import com.noteflight.standingwave3.formats.WaveFile;

	import flash.events.Event;

	import org.bytearray.micrecorder.events.RecordingEvent;

	import flash.utils.ByteArray;

	import fr.kikko.lab.ShineMP3Encoder;

	import org.bytearray.micrecorder.encoder.WaveEncoder;
	import org.bytearray.micrecorder.MicRecorder;
	import org.robotlegs.mvcs.Actor;

	public class RecorderServiceProxy extends Actor {
		public var recorder : MicRecorder;
		private var _mic : Microphone;
		public var wav_encorder : WaveEncoder;
		public var mp3_encorder : ShineMP3Encoder;
		private var waveData : ByteArray;
		private var waveFile : ByteArray;
		private var src : Sample;
		private var sequence : ListPerformance;
		public var audio : AudioPerformer;
		private const DELAY_LENGTH : int = 4000;
		private var ziped : Boolean = false;
		private var zipedFile : ByteArray;
		public const INITIALZE : int = 0;
		public const ENCORDING : int = 2;
		public const RECORDING : int = 3;
		public const ENCORDED : int = 5;
		public var status : int;
		[Inject]
		public var player : PlayerProxy;

		// ---------------------------------------
		// CONSTRUCTOR
		// ---------------------------------------
		public function RecorderServiceProxy() {
			super();
			initialize();
		}

		// ---------------------------------------
		// PROTECTED METHODS
		// ---------------------------------------
		protected function initialize() : void {
			// Add any initialization here
			// example: myArrayCollection = new ArrayCollection();

			wav_encorder = new WaveEncoder();
			recorder = new MicRecorder(wav_encorder, Microphone.getEnhancedMicrophone());

			recorder.microphone.setLoopBack(true);
			recorder.microphone.setSilenceLevel(0, DELAY_LENGTH);
			waveData = new ByteArray();
			waveFile = new ByteArray();
			recorder.addEventListener(RecordingEvent.RECORDING, onRecording);
			recorder.addEventListener(Event.COMPLETE, onRecordComplete);
			sequence = new ListPerformance();
		}

		public function  record() : void {
			recorder.microphone = Microphone.getEnhancedMicrophone();
			recorder.record();
		}

		public function stop() : void {
			recorder.stop();
			recorder.microphone = null;
			ziped = false;
		}

		public function onRecording(e : RecordingEvent) : void {
			// dispatch(event)recorder.microphone.activityLevel;
			trace('recorder.microphone.activityLevel', recorder.microphone.activityLevel);

			dispatch(new RecordProxyEvent(RecordProxyEvent.RECORDING, recorder.microphone.activityLevel));
		}

		private function onRecordComplete(e : Event) : void {
			waveData.writeBytes(recorder.output);
			// trace(recorder.output);
			// src = new Sample(new AudioDescriptor());
			// src.writeWavBytes(output);
			// output.position = 0;
			// src = WaveFile.createSample(output);
			// trace(waveData);
			// sequence.addSourceAt(0, src);
			// audio = new AudioPerformer(sequence, new AudioDescriptor());

			status = ENCORDED;
			dispatch(new RecordProxyEvent(RecordProxyEvent.ENCORD_COMPLETE, waveData));
		}

		public function render(convertToMp3 : Boolean = false) : void {
			var innerTimer : Timer = new Timer(10, 0);
			var framesPerChunk : uint = 8192;

			innerTimer.addEventListener(TimerEvent.TIMER, handleRenderTimer);
			innerTimer.start();

			function handleRenderTimer(e : TimerEvent) : void {
				src.getSample(framesPerChunk).writeWavBytes(waveData);

				var m : uint = Math.min(src.frameCount, src.position + framesPerChunk);
				var n : uint = Math.max(0, m - src.position);

				if (n == 0) {
					if (src.position > 0) finishRender();
					else trace("cancel rendering");
				} else {
					trace("rendering audio: " + Math.floor(src.position * 100 / src.frameCount) + "%");
					dispatch(new RecordProxyEvent(RecordProxyEvent.RENDERING, Math.floor(src.position * 100 / src.frameCount) + "%"));
				}
			}
			function finishRender() : void {
				innerTimer.stop();
				trace("finishing audio render") ;
				WaveFile.writeBytesToWavFile(waveFile, waveData, 44100, 2, 16);

				if (convertToMp3) {
					makeIntoMp3(waveFile);
				}
			}
		}

		public function makeIntoMp3(wavFile : ByteArray) : void {
			wavFile.position = 0;
			mp3_encorder = new ShineMP3Encoder(wavFile);
			mp3_encorder.addEventListener(Event.COMPLETE, mp3EncodeComplete);
			mp3_encorder.addEventListener(ProgressEvent.PROGRESS, mp3EncodeProgress);
			mp3_encorder.addEventListener(ErrorEvent.ERROR, mp3EncodeError);
			mp3_encorder.start();

			function mp3EncodeProgress(e : ProgressEvent) : void {
				trace("encoding mp3: " + e.bytesLoaded + "%") ;
				dispatch(new RecordProxyEvent(RecordProxyEvent.ENCORDING, "压缩中 : " + e.bytesLoaded + "%"));
			}

			function mp3EncodeComplete(e : Event) : void {
				trace("mp3 encoding complete\n");
				eventDispatcher.dispatchEvent(new RecordProxyEvent(RecordProxyEvent.ENCORD_COMPLETE, mp3_encorder.mp3Data));
			}
			function mp3EncodeError(e : ErrorEvent) : void {
				trace("mp3 encoding error :", e.text);
				eventDispatcher.dispatchEvent(new RecordProxyEvent(RecordProxyEvent.ENCORD_ERROR, mp3_encorder.mp3Data));
			}
		}

		public function mp3() : ByteArray {
			if (ziped) {
				return zipedFile;
			}
			// WRITE ID3 TAGS
			var sba : ByteArray = mp3_encorder.mp3Data;
			sba.position = sba.length - 128;
			sba.writeMultiByte("TAG", "iso-8859-1");
			sba.writeMultiByte("Paraket:: a microphone test 1-2, 1-2      " + String.fromCharCode(0), "iso-8859-1");
			// Title
			sba.writeMultiByte("Chan9ry.ian                " + String.fromCharCode(0), "iso-8859-1");
			// Artist
			sba.writeMultiByte("Chan9ry.ian's fav Volume 1  " + String.fromCharCode(0), "iso-8859-1");
			// Album
			sba.writeMultiByte("2013" + String.fromCharCode(0), "iso-8859-1");
			// Year
			sba.writeMultiByte("wcweb.us         " + String.fromCharCode(0), "iso-8859-1");
			// comments
			sba.writeByte(57);
			zipedFile = sba;
			ziped = true;
			return sba;
		}

		public function play() : void {
			if (!empty()) {
				player.playRaw(recorder.output);
			} else {
				eventDispatcher.dispatchEvent(new RecordProxyEvent(RecordProxyEvent.NO_RECORD, null));
			}
		}

		public function empty() : Boolean {
			return recorder.output == null;
		}

		public function stopPlaying() : void {
			player.stop();
		}

		public function destory() : void {
			_mic = null;
			wav_encorder = null;
			recorder = null;
			waveData = null;
			waveFile = new ByteArray();
			recorder.removeEventListener(RecordingEvent.RECORDING, onRecording);
			recorder.removeEventListener(Event.COMPLETE, onRecordComplete);
			sequence = null;
		}
	}
}
