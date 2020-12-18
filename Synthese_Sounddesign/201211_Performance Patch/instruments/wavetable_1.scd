(
var wavetables_buffer_number = 10;

~wavetables_random_sig ?? {~wavetables_random_sig = wavetables_buffer_number.collect({
	arg i;

	var numSegs = i.linexp(0,wavetables_buffer_number-1,4,40).round;

	Env(
		//env always begins and ends with zero
		//inner points are random from -1.0 to 1.0
		[0]++({1.0.rand}.dup(numSegs-1) * [1,-1]).scramble++[0],

		//greater segment duration variety in higher-index wavetables
		{exprand(1,i.lincurve(0,wavetables_buffer_number-1,1,100,-3))}.dup(numSegs),

		//low-index wavetables tend to be sinusoidal
		//high index wavetables tend to have sharp angles and corners
		{[\sine,0,exprand(1,20) * [1,-1].choose].wchoose([wavetables_buffer_number-1-i,3,i].normalizeSum)}.dup(numSegs)
	).asSignal(1024);
})
};

//~wavetables_random_sig.plot;

//load into 10 buffers in wavetable format
~wavetables_random_buf = Buffer.allocConsecutive(wavetables_buffer_number, s, 2048, 1, {
	arg buf, index;
	buf.setnMsg(0, ~wavetables_random_sig[index].asWavetable);
});


SynthDef.new(\wavetable_1,
	{
		arg gate = 1,
		buffer_number = wavetables_buffer_number,
		freq;

		var note = \note.kr(60,0);

		var macro_controls = Lag.kr(
			In.kr(
				~wavetable_1_controlbus ?? {~wavetable_1_controlbus = Bus.control(Server.default, 4)},
				4),
			0.1);

		var macro_1 = macro_controls[0],
		buffer_position = macro_1.lincurve(0,1,0,buffer_number - 2,-12) + ~wavetables_random_buf[0].bufnum,
		fold_factor = macro_1.lincurve(0,1,1,2,-5);

		var macro_2 = macro_controls[1],
		detune = macro_2.lincurve(0,1,0,0.2,-7);

		var macro_3 = macro_controls[2],
		amp_r = macro_3.lincurve(0,1,0.2,5,-10),
		amp_c = macro_3.lincurve(0,1,-1,-10,-10);

		var fader = macro_controls[3],
		vol = fader.lincurve(0,1,0,0.05 ,-7),
		vol_correct = 1;

		var detuneCtrl, sig, adsr;

		detuneCtrl = LFNoise1.kr(0.1!8).bipolar(detune).midiratio;

		sig = VOsc.ar(buffer_position, freq * detuneCtrl, {Rand(0,2pi)}!8);

		sig = Fold.ar(sig * fold_factor, -1, 1);

		sig = Splay.ar(sig);

		sig = LeakDC.ar(sig);

		adsr = sig * vol * vol_correct * EnvGen.kr
		(Env.adsr(attackTime: 0.1,
			decayTime: 0,
			sustainLevel: 1,
			releaseTime: amp_r,
			peakLevel: 1.0, curve: amp_c),
		gate: gate, doneAction:2);

		Out.ar(~melody_bus, adsr);

}).add;
)