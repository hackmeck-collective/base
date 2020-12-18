~grain_sample_timestretch_1_buffer ?? {~grain_sample_timestretch_1_buffer = Buffer.readChannel(s, thisProcess.nowExecutingPath.dirname +/+ "/samples/textural/Textur_6.wav", channels: [0])};

s.sync;

(
SynthDef.new(\grain_sample_timestretch_1,
	{
		arg gate = 1,
		freq,
		max_grains = 128,
		sync_switch = 0,
		detune_num = 12,
		grain_position_offset_control = 0,
		grain_buffer = ~grain_sample_timestretch_1_buffer;

		var note = \note.kr(60,0);

		var macro_controls = Lag.kr(
			In.kr(
				~grain_sample_timestretch_1_controlbus ?? {~grain_sample_timestretch_1_controlbus = Bus.control(Server.default, 4)},
				4),
			0.1);

		var macro_1 = macro_controls[0],
		grain_rate_control = macro_1.lincurve(0,1,0.25,4,-7);

		var macro_2 = macro_controls[1],
		grain_playback_position_change_rate = macro_1.lincurve(0,1,4,0.25,-7);

		var macro_3 = macro_controls[2],
		amp_r = macro_3.lincurve(0,1,0.2,5,-10),
		amp_c = macro_3.lincurve(0,1,-1,-10,-10),
		grain_density = macro_2.lincurve(0,1,1,128,-7);

		var fader = macro_controls[3],
		vol = fader.lincurve(0,1,0,1 ,-7),
		vol_correct = 1 * macro_2.lincurve(0,1,3,1,-7);

		var grain_trigger, grain_length, grain_rate, grain_position_start_ratio, grain_position_end_ratio, grain_position_start, grain_position_end, grain_position_line, grain_position_noise, grain_position, grain_position_offset, granulator, summing, adsr;

		grain_trigger = Select.kr(sync_switch, [Dust.ar(grain_density), Impulse.ar(grain_density)]);
		grain_length = Rand(0.1,0.7);
		grain_rate = grain_rate_control;
		grain_playback_position_change_rate = 1;
		grain_position_start_ratio = 0;
		grain_position_end_ratio = 1;

		grain_position_start = 0;
		grain_position_end = (BufSamples.ir(~grain_sample_timestretch_1_buffer) - 1);
		grain_position_line = Phasor.ar(0,
			grain_playback_position_change_rate * BufRateScale.ir(~grain_sample_timestretch_1_buffer),
			grain_position_start,
			grain_position_end);

		grain_position_noise = LFNoise1.ar(grain_density).bipolar(0.01 * SampleRate.ir);

		grain_position_offset = grain_position_offset_control;

		grain_position = (grain_position_line + grain_position_noise) / BufSamples.ir( ~grain_sample_timestretch_1_buffer);

		granulator = GrainBuf.ar(
			1,
			grain_trigger,
			grain_length,
			grain_buffer,
			grain_rate,
			grain_position + grain_position_noise,
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