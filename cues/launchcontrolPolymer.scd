~launchControlEvents = Dictionary.new;

~launchControlEvents.add(\launchControlXlEvent_0_0 -> {
	Pdef(\drums,
		Ppar([
			( Pdef(\bdThump).collect {|ev| ~scM8.play; ev} <> Pbindef(\root) <> Pbindef(\pulse_2) ),
			( Pdef(\bd1).collect {|ev| ~scM4.play; ev} <> Pbindef(\root) <> Pbindef(\pulse_2) ),
			( Pdef(\sd1)/*.collect {|ev| ~scM8.play; ev}*/ <> Pbindef(\root) <> Pbindef(\pulse_4_ob)),
			( Pdef(\hh1) <> Pbindef(\fifth) <> Pbindef(\pulse_8))
		])
	).quant_(4);
	Pdef(\drums).play(~linkClock, quant: 4);
	"lc1_1".postln;}
);

~launchControlEvents.add(\launchControlXlEvent_0_1 -> {
	Pdef(\drums,
		Ppar([
			( Pdef(\bdThump).collect {|ev| ~scM8.play; ev} <> Pbindef(\root) <> Pbindef(\bd_pattern_8th_rng) ),
			( Pdef(\bd1).collect {|ev| ~scM4.play; ev} <> Pbindef(\root) <> Pbindef(\pulse_2) ),
			( Pdef(\sd1).collect {|ev| ~scM8.play; ev} <> Pbindef(\fifth) <> Pbindef(\sd_pattern_1)),
			( Pdef(\hh1) <> Pbindef(\fifth) <> Pbindef(\pulse_8))
		])
	).quant_(4);
	Pdef(\drums).play(~linkClock, quant: 4);
	"lc1_2".postln;}
);

~launchControlEvents.add(\launchControlXlEvent_0_2 -> {
	Pdef(\drums,
		Ppar([
			( Pdef(\bdThump).collect {|ev| ~scM8.play; ev} <> Pbindef(\root) <> Pbindef(\bd_pattern_8th_rng) ),
			( Pdef(\bd1).collect {|ev| ~scM4.play; ev} <> Pbindef(\root) <> Pbindef(\pulse_2) ),
			( Pdef(\sd1).collect {|ev| ~scM8.play; ev} <> Pbindef(\fifth) <> Pbindef(\sd_pattern_1)),
			( Pdef(\hh1) <> Pbindef(\root) <> Pbindef(\euclidean_8th_rng) ),
			( Pdef(\hh2) <> Pbindef(\root) <> Pbindef(\euclidean_16th_rng) ),
		])
	).quant_(4);
	Pdef(\drums).play(~linkClock, quant: 4);
	"lc1_3".postln;}
);

~launchControlEvents.add(\launchControlXlEvent_0_3 -> {
	Pdef(\drums,
		Ppar([
			( Pdef(\bdThump).collect {|ev| ~scM8.play; ev} <> Pbindef(\root) <> Pbindef(\bd_pattern_8th_rng) ),
			( Pdef(\bd1).collect {|ev| ~scM4.play; ev} <> Pbindef(\root) <> Pbindef(\pulse_2) ),
			( Pdef(\sd1).collect {|ev| ~scM8.play; ev} <> Pbindef(\fifth) <> Pbindef(\sd_pattern_1)),
			( Pdef(\hh1) <> Pbindef(\root) <> Pbindef(\euclidean_8th_rng) ),
			( Pdef(\hh2) <> Pbindef(\root) <> Pbindef(\euclidean_16th_rng) ),
			( Pdef(\hh3) <> Pbindef(\root) <> Pbindef(\hh_rng) )
		])
	).quant_(4);
	Pdef(\drums).play(~linkClock, quant: 4);
	"lc1_4".postln;}
);

~launchControlEvents.add(\launchControlXlEvent_1_0 -> {
	Pdef(\loop,
		Ppar([
			( Pdef(\simplePluckReverse)
				<> Pn(Psync(Pbindef(\pat_332_downUp,
					\upperLimit, 24,
					\lowerLimit, 0,),maxdur:16))
				<> Pbindef(\pulse_8) ),
			( Pdef(\srrPluck)
				<> Pn(Psync(Pbindef(\arp,
					\upperLimit, -12,
					\lowerLimit, -36,
					\transpositionHarmonics, 1,
					\chordTranspositions, 10),maxdur:8))
				<> Pbindef(\pulse_16))
		])
	).quant_(4);
	Pdef(\loop).play(~linkClock, quant: 4);
	"lc2_1".postln;}
);

~launchControlEvents.add(\launchControlXlEvent_1_1 -> {
	Pdef(\loop,
		Ppar([
			( Pbind(\controlbus, ~launchcontrol_xl_row_1) <>
				Pdef(\srrPluck)
				<> Pbind(\external1Target, "fx_mod_1",
					\external1Amount, 1,
					\pattern1Target, "oscillator_mod_1",
					\pattern1Amount, 1,
					\pattern1In, Pseq([0.5,1,0.7,0.2],inf),
				) <>
				Pbindef(\root) <> Pbindef(\pulse_16)),
			( Pdef(\srrPluck)
				<> Pn(Psync(Pbindef(\arp,
					\upperLimit, -12,
					\lowerLimit, -36,
					\transpositionHarmonics, 1,
					\chordTranspositions, 10),maxdur:8))
				<> Pbindef(\pulse_16))
		])
	).quant_(4);
	Pdef(\loop).play(~linkClock, quant: 4);
	"lc2_2".postln;}
);