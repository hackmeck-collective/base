~granular_1_buffer ?? {~granular_1_buffer = Buffer.readChannel(s, "C:/Users/Admin/Documents/00_Resourcen/ZZ_Github/Hackmeck/Synthese_Sounddesign/201211_Performance Patch/instruments/samples/203066__enjoypa__counting-from-1-to-20-48kHz.wav", channels: [0])};

(
SynthDef.new(\granular_1,
	{
		arg gate = 1,
		freq,
		max_grains = 128,
		sync_switch = 0,
		grain_pitch_init = 0,
		grain_buffer = ~granular_1_buffer,
		grain_density_init = 50, grain_duration_init = 0.1,
		grain_position_offset=0, grain_position_random_init = 0;

		var macro_controls = Lag.kr(
			In.kr(
				~granular_1_controlbus ?? {~granular_1_controlbus = Bus.control(Server.default, 4)},
				4),
			0.1);

		var macro_1 = macro_controls[0],
		grain_pitch_control = macro_1.lincurve(0,1,-24,24,0).midiratio;

		var macro_2 = macro_controls[1],
		grain_position_speed_control = macro_2.lincurve(0,1,-24,24,0).midiratio;

		var macro_3 = macro_controls[2],
		amp_r = macro_3.lincurve(0,1,0.2,5,-10),
		amp_c = macro_3.lincurve(0,1,-1,-10,-10),
		grain_density_control = macro_2.lincurve(0,1,1,128,-7),
		grain_position_random_control = macro_2.lincurve(0,1,0,1,0);

		var fader = macro_controls[3],
		vol = fader.lincurve(0.05,1,0,0.05,3),
		vol_correct = 1 * macro_2.lincurve(0,1,3,1,-7);

		var grain_duration_random_control = 1;

		var grain_line_length = 0.1,
		grain_position_offset_control = 0;

		var grain_density, grain_trigger, grain_duration, grain_pitch, grain_duration_random, grain_position_speed, grain_position_random, grain_spawn_line, grain_position, granulator, summing, adsr;

		grain_density = grain_density_init + grain_density_control;

		grain_trigger = Select.ar(sync_switch, [Dust.ar(grain_density), Impulse.ar(grain_density)]);

		grain_duration_random = LFNoise1.kr(100).exprange(1 / grain_duration_random_control, grain_duration_random_control);
		grain_duration = grain_duration_init * grain_duration_random;

		grain_pitch = grain_pitch_control;

		grain_position_speed = grain_position_speed_control;
		grain_position_random = LFNoise1.kr(100).bipolar(
			(grain_position_random_init + grain_position_random_control) * SampleRate.ir
		);
		grain_spawn_line = Phasor.ar(0, grain_position_speed * BufRateScale.ir(grain_buffer) / grain_line_length, 0, BufSamples.ir(grain_buffer)-1);
		grain_spawn_line = grain_spawn_line + grain_position_random;
		grain_spawn_line = grain_spawn_line / BufSamples.ir(grain_buffer);
		grain_position = grain_spawn_line * grain_line_length + grain_position_offset;

		granulator = GrainBuf.ar(1,
			grain_trigger,
			grain_duration,
			grain_buffer,
			grain_pitch,
			grain_position,
			2,
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

		Out.ar(~chords_bus, tan(adsr));
}).add
)

// Synth.new(\granular_1)