Pdef(\play).play(~linkClock, quant:4 )
Pdef(\play).stop
~linkClock.tempo = 3.8571428571429
~cueData[\lsysBeats1] = (~lsys.presets.rabbitSeq.maxPatDur * ~lsys.presets.rabbitSeq.baseTempo).roundUp(~lsys.presets.rabbitSeq.quant)
Pdef(\play, Pbind(\vol, Pfunc {|ev| if(ev.charNow == $F){1}{ 0.7}}) <> Pn(Pdef(\rabbitSeq_test)))
Pdef(\playVisuals).play(~linkClock, quant: 1)
~lsys.presets.rabbitSeq_test_gen3.maxPatDur
(81 / 21)

~lsys.presets.rabbitSeq_test.noteOffset = 60
Pdef(\play, Pn(
	Pbind(\vol, Pfunc {|ev| if(ev.charNow == $F){1}{0.7}}) <> Pspawner({|sp|
		sp.par(Pn(Pdef(\rabbitSeq_test), 1));
		//"next".postln;
		sp.par(Pn(Pdef(\rabbitSeq_test_gen3), 1));
	})
))
(
~newLsys.(
	name: \rabbitSeq_gen3,
	axiom: "F",
	rules: ( $F: "+F[|]-G--F++GFG", $G: "F" ),
	gen: 3.0,
	opts: (
		quant: 0,
		baseTempo: 1/8,
		useGlobalPitch: false
	)
);
)
(
~newLsys.(
	name: \rabbitSeq_gen4,
	axiom: "F",
	rules: ( $F: "+F[|]-G--F++GFG", $G: "F" ),
	gen: 4.0,
	opts: (
		quant: 0,
		baseTempo: 1/8,
		useGlobalPitch: false
	)

);
)
(
~newLsys.(
	name: \rabbitSeq_gen2,
	axiom: "F",
	rules: ( $F: "+F[|]-G--F++GFG", $G: "F"), //, $G: "F"
	gen: 2.0,
	opts: (
		quant: 0,
		baseTempo: 1/8,
		useGlobalPitch: false
	)

);
)


(
~newLsys.(
	name: \rabbitSeq_test,
	axiom: "F",
	rules: ( $F: "+f-G--f++GfG", $G: "F", $f: "+f-G--f++GfG"), //, $G: "F"
	gen: 2.0,
	opts: (
		quant: 0,
		baseTempo: 1/2,
		useGlobalPitch: false
	)
);
)

(
~newLsys.(
	name: \rabbitSeq_test_gen3,
	axiom: "F",
	rules: ( $F: "+f-G--f++GfG", $G: "F", $f: "+f-G--f++GfG"), //, $G: "F"
	gen: 3.0,
	opts: (
		quant: 0,
		baseTempo: 0.12962962962963,
		useGlobalPitch: false
	)
);
)
(
~newLsys.(
	name: \rabbitSeq_gen3,
	axiom: "+F-G--F++GFG",
	rules: ( $F: "+|-G[--|++G|G]", $G: "F"), //, $G: "F"
	gen: 2.0,
	opts: (
		quant: 0,
		baseTempo: 1/8,
		useGlobalPitch: false
	)

);
)

~lsys.presets.rabbitSeq.baseTempo = 0.125;
~lsys.presets.rabbitSeq.branchInterval = 7;
~lsys.presets.rabbitSeq.instr = [ 'simplePluck', 'detunePluck' ];
~lsys.presets.rabbitSeq.legatoArr = [ 0.55 ];
~lsys.presets.rabbitSeq.maxPatDur = 21;
~lsys.presets.rabbitSeq.mute = [ 1 ];
~lsys.presets.rabbitSeq.noteOffset = 48;
~lsys.presets.rabbitSeq.numBranches = 1;
~lsys.presets.rabbitSeq.quant = 0;
~lsys.presets.rabbitSeq.rootPitchDrift = 0;
~lsys.presets.rabbitSeq.stepInterval = 2.0;
~lsys.presets.rabbitSeq.theta = 60;
~lsys.presets.rabbitSeq.useGlobalPitch = true;
~lsys.presets.rabbitSeq.vols = [ 1 ];
~lsys.presets.rabbitSeq.wrapHi = [ 96 ];
~lsys.presets.rabbitSeq.wrapLo = [ 36 ];















Pdef(\parallel,
	Pbind(
		\vol, (Pfunc {|ev|
			if(ev.streamIndex == 1){ev.xfade}{1 - ev.xfade}
		}) * 1 * Pkey(\vol)
	) <> Ppar([
		Pn(Pdef(\rabbitSeq) <> Pbind(\streamIndex, 1)),
		Pn(Pdef(\rabbitSeqPerc) <> Pbind(\streamIndex, 2))
	]) <> PtimeClutch(Pbind(
		\xfade, Pseq([0,1],inf),
		// \xfade, Pwrand([0,1],[0.8,0.2],inf)

		//\xfade, Pseg([0,1,0],[10,10],0,inf)
	))
)

~lsys.presets.basicL.reveal
Pdef(\play, Pn(Pdef(\rabbitSeqPerc)))
~lsys.presets.rabbitSeqPerc.instr = \detunePluck
~lsys.presets.rabbitSeq.baseTempo = 1/8
~lsys.presets.rabbitSeq.quant = 0
~lsys.presets.rabbitSeqPerc.useGlobalPitch = false
~lsys.presets.rabbitSeqPerc.amp = 0.01
(
~newLsys.(
	name: \rabbitSeqPerc,
	axiom: "F",
	rules: ( $F: "+F-G--F++GFG", $G: "F[F]" ),
	gen: 2.0,
	opts: (
		instr: \bd1,
		baseTempo: 1/8,
		vol: 0.1
	)
);
)