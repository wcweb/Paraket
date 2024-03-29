package com.noteflight.standingwave3.sources
{
    import com.noteflight.standingwave3.elements.*;
    import com.noteflight.standingwave3.modulation.*;
    import com.noteflight.standingwave3.sources.AbstractSource;

    /** 
     * The SamplerSource provides a convenient way to perform
     * complex sample wavetable playback functionality.
     * It has flexible start and loop points, and accepts pitch modulations.
     */
    public class SamplerSource extends AbstractSource 
    {
        
        /** A direct access source to serve as the source of raw sample data */
        private var _generator:IDirectAccessSource;
        
        /** The frame to begin and end looping on.
         * Standing Wave can *not* read loop points from samples. You must provide them.
         * Of course, loop points should almost ALWAYS be at zero-crossings! 
         */
        public var startFrame:Number = 0;
        public var endFrame:Number = 0;
        
        /**  Initial start point for when the source first starts */
        public var firstFrame:Number = 0; 
        
        /** Factor by which to shift the playback frequency up or down */
        public var frequencyShift:Number;
        
        /** An array of performable modulations to pitch */
        public var pitchModulations:Array;
        
        /** Bin for realized modulations */
        protected var _realizedModulations:Array;
        
        /** The pitch bend data */
        protected var _pitchModulationData:LineData;
        
        protected var _phase:Number;
        
        private static const LOOP_MAX:Number = 30;
        
        
        /** 
         * LoopSource extends a sample indefinitely by looping a section.
         * The source of a loop is always a SoundGenerator.
         */
        public function SamplerSource(ad:AudioDescriptor, soundGenerator:IDirectAccessSource)
        {
            super(ad, 0, 1.0);
            this._generator = soundGenerator;
            this._position = 0;
            this.frequencyShift = 1;
            this._phase = 0;
            this.pitchModulations = new Array();
            this._realizedModulations = new Array();
            this._pitchModulationData = new LineData();
        }
        
        override public function resetPosition():void 
        {
            _phase = 0;
            _position = 0;
        }
        
        /**
         * In a LoopSource, the frame count needs to be tweaked appropriately
         * to reflect the frequency shift.
         */
        override public function get frameCount():Number
        {
            if (endFrame)
            {
                return LOOP_MAX * descriptor.rate;
            }
            else
            {
            	var actualShift:Number = frequencyShift * ( _generator.descriptor.rate / _descriptor.rate );
                return Math.floor((_generator.frameCount - firstFrame) / actualShift);
            }
        }
        
        override public function get duration():Number
        {
            return frameCount / descriptor.rate;
        }

        override public function getSample(numFrames:Number):Sample 
        {
            // First realize any outstanding modulations
            
            realizeModulationData();
            var segments:Array = _pitchModulationData.getSegments(position, position+numFrames-1);
            
            var sample:Sample = new Sample(descriptor, numFrames, false);
            var tableSize:Number;
            
            if (endFrame) {
                // The wavetable size is from frame zero to loop end
                tableSize = Math.floor(endFrame);
            } else {
                // The wavetable size is the full sample
                tableSize = _generator.frameCount;
            }
            
            // The actual shift factor depends on the difference between the generator and output descriptors
            // multiplied by the requested shift. 
            var actualShift:Number = frequencyShift * ( _generator.descriptor.rate / _descriptor.rate );
            
            // The wavetable function works with a phase angle that goes from 0-1
            //  from the start to end of the table. The phaseAdd is added every frame.
            //  The phaseReset is where it loops back to if overrunns. 
            
            var phaseAdd:Number = actualShift / tableSize; 
            var phaseReset:Number;
            
            if (startFrame && endFrame) {
                phaseReset = startFrame / tableSize;
            } else {
                phaseReset = -1; // no loop
            } 
               
            if (_phase == 0 && firstFrame) {
                // a manual start point adjustment
                _phase = firstFrame / tableSize;
            }
            
            // Make sure the sound generator is filled to the max time we will need, plus a guard sample for interpolation
            _generator.fill( Math.ceil(_position / actualShift) + 1 );
            
            // Loop over all the segments in this window.
            // Each segment represents a change in keyframe to pitch modulation
            // Scan the wavetable forward, looping appropriately
            // The wavetable function returns the new phase (ie position in the generator)
            
            var segmentFrames:int;
            var offset:int;
            var pitchMod:Mod;
            
            for (var s:int=0; s<segments.length; s += 2) {
                // trace("Segment " + segments[s] + " to " + segments[s+1]);
                segmentFrames = segments[s+1] - segments[s] + 1; // length of segment
                offset = segments[s] - position; // offset in result sample to composite into
                pitchMod = _pitchModulationData.getModForRange(segments[s], segments[s+1]);
                _phase = sample.wavetableInDirectAccessSource(_generator, tableSize, _phase, phaseAdd, phaseReset, offset, segmentFrames, pitchMod);
            }
            
            _position += numFrames;  
            
            return sample;
            
        }
        
        protected function realizeModulationData():void
        {
            var pm:IPerformableModulation;
            
            while (pitchModulations.length > 0) 
            {
                pm = IPerformableModulation( pitchModulations.shift() );
                pm.realize(_pitchModulationData);        
                _realizedModulations.push(pm);
            }
        }
        
        override public function clone():IAudioSource
        {
            var rslt:SamplerSource = new SamplerSource(_descriptor, _generator);
            rslt.startFrame = startFrame;
            rslt.endFrame = endFrame;
            rslt.frequencyShift = frequencyShift;
            rslt.resetPosition();
            
            // Figure out if we need to clone modulations
            // FOr now, clones have empty modulations
            
            return rslt;
        }
        
    }
}