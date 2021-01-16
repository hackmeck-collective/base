/*~grain_sample_timestretch_1_buffer ?? {~grain_sample_timestretch_1_buffer = Buffer.readChannel(s, thisProcess.nowExecutingPath.dirname +/+ "/samples/textural/Textur_6.wav", channels: [0])};*/

~grain_sample_timestretch_1_buffer ?? {~grain_sample_timestretch_1_buffer = Buffer.readChannel(s, "C:/Users/Admin/Documents/00_Resourcen/ZZ_Github/Hackmeck/Synthese_Sounddesign/201211_Performance Patch/instruments/samples/203066__enjoypa__counting-from-1-to-20.wav", channels: [0])};

s.sync;

(
SynthDef.new(\grain_sample_timestretch_1,
	{
		arg gate = 1,
		freq,
		max_grains = 128,
		sync_switch = 0,
		grain_buffer = ~grain_sample_timestretch_1_buffer;

		var note = \note.kr(60,0);

		var macro_controls = Lag.kr(
			In.kr(
				~grain_sample_timestretch_1_controlbus ?? {~grain_sample_timestretch_1_controlbus = Bus.control(Server.default, 4)},
				4),
			0.1);

		var macro_1 = macro_controls[0],
		grain_pitch_control = macro_1.lincurve(0,1,0.25,4,-7);

		var macro_2 = macro_controls[1],
		grain_position_speed = macro_1.lincurve(0,1,4,0.25,-7);

		var macro_3 = macro_controls[2],
		amp_r = macro_3.lincurve(0,1,0.2,5,-10),
		amp_c = macro_3.lincurve(0,1,-1,-10,-10),
		grain_density = macro_2.lincurve(0,1,1,128,-7);

		var fader = macro_controls[3],
		vol = fader.lincurve(0,1,0,1 ,-7),
		vol_correct = 1 * macro_2.lincurve(0,1,3,1,-7);

		var grain_trigger, grain_duration, grain_pitch, grain_position_random, grain_position, grain_position_offset, granulator, summing, adsr;

		grain_trigger = Select.ar(sync_switch, [Dust.ar(grain_density), Impulse.ar(grain_density)]);
		grain_duration = Rand(0.1, 0.7);
		grain_pitch = grain_pitch_control;
		grain_position_random = LFNoise1.kr(100).bipolar(/*grain_position_random**/SampleRate.ir);

		grain_position = Phasor.ar(0, /*grain_position_speed**/BufRateScale.ir(grain_buffer), 0, BufSamples.ir(grain_buffer)-1);
		grain_position = grain_position + grain_position_random;
		grain_position = grain_position / BufSamples.ir(grain_buffer);
		grain_position = grain_position + grain_position_offset;*/

		grain_position =1;

		granulator = GrainBuf.ar(
			1,
			grain_trigger,
			grain_duration,
			grain_buffer,
			grain_pitch,
			grain_position,
			4,
			0,
			-1,
			max_grains
		);

		summing = Splay.ar(granulator);

		adsr = summing * vol * vol_correct * EnvGen.kr
		(Env.adsr(attackTime: 0.1,
			decayTime: amp_r,
			sustainLevel: 0.5,
			releaseTime: amp_r,
			peakLevel: 1.0, curve: amp_c),
			gate: gate, doneAction:2);

		Out.ar(~chords_bus, adsr);

}).add;
)