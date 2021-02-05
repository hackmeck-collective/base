~grain_sample_timestretch_1_buffer ?? {~grain_sample_timestretch_1_buffer = Buffer.readChannel(s, thisProcess.nowExecutingPath.dirname +/+ "/samples/textural/Textur_3.wav", channels: [0])};

s.sync;

(
SynthDef.new(\asynchronus_grains_1,
	{
		arg gate = 1,
		freq,
		detune_num = 12;

		var note = \note.kr(60,0);

		var macro_controls = Lag.kr(
			In.kr(
				~asynchronus_grains_1_controlbus ?? {~asynchronus_grains_1_controlbus = Bus.control(Server.default, 4)},
				4),
			0.1);

		var macro_1 = macro_controls[0],
		grain_rate_control = macro_1.lincurve(0,1,0.25,4,-7);

		var macro_2 = macro_controls[1],
		grain_density = macro_2.lincurve(0,1,1,128,-7);

		var macro_3 = macro_controls[2],
		amp_r = macro_3.lincurve(0,1,0.2,5,-10),
		amp_c = macro_3.lincurve(0,1,-1,-10,-10);

		var fader = macro_controls[3],
		vol = fader.lincurve(0,1,0,1 ,-7),
		vol_correct = 1 * macro_2.lincurve(0,1,3,1,-7);

		var grain_trigger, grain_length, grain_rate, grain_position, granulator, summing, adsr;

		grain_trigger = Dust.ar(grain_density);
		grain_length = Rand(0.1,0.7);
		grain_rate = grain_rate_control;
		grain_position = Rand(0,0.5);

		granulator = GrainBuf.ar(
			1,
			grain_trigger,
			grain_length,
			~synchronus_grains_1_buffer,
			grain_rate,
			grain_position,
			4,
			0,
			-1,
			128
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