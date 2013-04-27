package us.wcweb.model.services {
	import com.noteflight.standingwave3.output.AudioPlayer;
	import com.noteflight.standingwave3.elements.Sample;
	import com.noteflight.standingwave3.performance.ListPerformance;
	import com.noteflight.standingwave3.elements.AudioDescriptor;
	import com.noteflight.standingwave3.elements.IAudioSource;
	import com.noteflight.standingwave3.performance.AudioPerformer;

	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import com.noteflight.standingwave3.formats.WaveFile;

	import flash.events.Event;

	import org.bytearray.micrecorder.events.RecordingEvent;
	import org.bytearray.micrecorder.encoder.WaveEncoder;
	import org.bytearray.micrecorder.MicRecorder;

	import flash.utils.ByteArray;

	import fr.kikko.lab.ShineMP3Encoder;

	import flash.media.Microphone;

	import org.robotlegs.mvcs.Actor;

	public class RecorderService extends Actor {
		public var mircophone : Microphone;
		public var recorder : MicRecorder;
		public var mp3Encoder : ShineMP3Encoder;
		private var myWavData : ByteArray = new ByteArray();
		private var myWavFile : ByteArray = new ByteArray();
		private var recording : Boolean = false;
		private var audio:AudioPerformer;
		private var player:AudioPlayer = new AudioPlayer();

		// ---------------------------------------
		// CONSTRUCTOR
		// ---------------------------------------
		public function RecorderService() {
			super();
			initialize();
		}

		// ---------------------------------------
		// PROTECTED METHODS
		// ---------------------------------------
		protected function initialize() : void {
			// Add any initialization here
			// example: myArrayCollection = new ArrayCollection();

			mircophone = new Microphone();
			recorder = new MicRecorder(new WaveEncoder());
			recorder.addEventListener(RecordingEvent.RECORDING, onRecording);
			recorder.addEventListener(Event.COMPLETE, onRecordComplete);
		}

		public function startRecording() : void {
			if (!recording) {
//				TweenMax.to(btnrec, .3, {glowFilter:{color:0xFF0000, alpha:1, blurX:50, blurY:50}})

				recorder.record();
			} else if (recording) {
				recorder.stop();
				recording = false;
////				TweenMax.to(btnrec, .3, {glowFilter:{color:0xFF0000, alpha:0, blurX:10, blurY:10}})
			}
		}

		public function requestSoundClips() : void {
		}
		public function play():void{
			if(audio){
				player.play(audio);
			}
		}
		public function onRecording(e : RecordingEvent) : void {			
			// statustxt.text = "make some noise!"	
			 var al:Number = recorder.microphone.activityLevel;
			 trace(al);
			// TweenMax.to(soundMeter, .1, {scaleX:al * .01, onUpdate:onActivitylevelUpdate});//, onUpdateParams:[al]})
			// if (!recording) recording = true;
		}

		// public function onActivitylevelUpdate(al) :void{
		// statustxt.text = _activityLevel
		// draw a cool sine wave!
		// xpos += speedX;
		// ypos = centerY + Math.sin(angle) * amplitude * ((al > 20)? al / 100 : 1)
		// angle += speedAngle;
		// graphics.lineTo(xpos,ypos)
		// }
		private function onRecordComplete(e : Event) : void {
			// soundMeter.scaleX = 0
			//
			// recording = false;
			// statustxt.text = "recording complete"
			//
			var src : Sample = WaveFile.createSample(recorder.output);
			// this is fine

			// I think im not clearing out the old audio properly here somehow...
			var sequence : ListPerformance = new ListPerformance();
			sequence.addSourceAt(0, src);
			audio = new AudioPerformer(sequence, new AudioDescriptor());
			// player.play(ap)

			renderWav(audio, true);

			// save to wav?
			// new FileReference().save (recorder.output, "VOCariousRecording.wav")
		}
		
		

		private function renderWav(src : IAudioSource, convertToMp3 : Boolean = false) : void {
			var innerTimer : Timer = new Timer(10, 0);
			var framesPerChunk : uint = 8192;

			innerTimer.addEventListener(TimerEvent.TIMER, handleRenderTimer);
			innerTimer.start();

			function handleRenderTimer(e : TimerEvent) : void {
				src.getSample(framesPerChunk).writeWavBytes(myWavData);

				var m : Number = Math.min(src.frameCount, src.position + framesPerChunk);
				var n : Number = Math.max(0, m - src.position);

				if (n == 0) {
					if (src.position > 0) finishRender();
					else trace("cancel rendering");
				} else {
					// statustxt.text = "rendering audio: " + Math.floor(src.position * 100 / src.frameCount) + "%";
				}
			}
			function finishRender() : void {
				innerTimer.stop();
				// statustxt.text = "finishing audio render"
				WaveFile.writeBytesToWavFile(myWavFile, myWavData, 44100, 2, 16);

				if (!convertToMp3) {
					// wavbtn.enabled = true;
				} else {
					makeIntoMp3(myWavFile);
				}
			}
		}

		private function makeIntoMp3(wav : ByteArray) : void {
			wav.position = 0;
			mp3Encoder = new ShineMP3Encoder(wav);
			mp3Encoder.addEventListener(Event.COMPLETE, mp3EncodeComplete);
			mp3Encoder.addEventListener(ProgressEvent.PROGRESS, mp3EncodeProgress);
			// mp3Encoder.addEventListener(ErrorEvent.ERROR, mp3EncodeError);
			mp3Encoder.start();

			function mp3EncodeProgress(e : ProgressEvent) : void {
				// statustxt.text = "encoding mp3: " + e.bytesLoaded + "%"
			}

			function mp3EncodeComplete(e : Event) : void {
				// statustxt.text = "mp3 encoding complete\n"
				// statustxt.appendText("you can now save the mp3 to your desktop")
				// wavbtn.enabled = true;
			}
		}
	}
}
