Pdef(\play).play(~linkClock, quant:4 )
Pdef(\play).stop

~cueData[\lsysBeats1] = (~lsys.presets.rabbitSeq.maxPatDur * ~lsys.presets.rabbitSeq.baseTempo).roundUp(~lsys.presets.rabbitSeq.quant)

Pdef(\play, Pn(Pdef(\rabbitSeq)))
Pdef(\play, Pbind(\vol, Pfunc {|ev| if(ev.charNow == $F){1}{ 0.7}}) <> Pn(Pdef(\rabbitSeq)))

Pdef(\play).play(~linkClock, quant: 1)
~lsys.presets.rabbitSeq.maxPatDur
(81 / 21)

/////////// erkenntnis
"+F-G--F++GFG"
// wenn es mit branch sein soll muss dieser zusaetzlich eingefuegt werden
// und keine der urspruenglichen elemente beeinhalten
"+F[F]-G--F++GFG" // JA
"+[F]-G--F++GFG" // NEIN

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
	name: \rabbitSeq,
	axiom: "F-F",
	rules: ( $F: "+F[F---FG--F]-G--F++GFG", $G: "F" ),
	gen: 3.0,
	opts: (
		noteOffset: 28,
		quant: 0,
		baseTempo: 1/8,
		useGlobalPitch: false
	)
);
)
~linkClock.tempo =0.7
~lsys.presets.rabbitSeq.instr = [ 'simplePluck', 'detunePluck', 'srrPluck' ];
~lsys.presets.rabbitSeq.vols = [ 1 ,1, 1, 1];

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
	name: \rabbitSeq,
	axiom: "F",
	rules: ( $F: "+F-G--[x]++GdGF", $x: "xG-xG----dG", $d: "5-dd5+dF"), //, $G: "F"
	gen: 3.0,
	opts: (
		instr: [\detuneLead, \simplePluck],
		legatoArr: 1,
		vols: [0.3, 0.8],
		noteOffset: 38,
		quant: 0,
		baseTempo: 1/6,
		useGlobalPitch: false
	)
);
)

(
~newLsys.(
	name: \rabbitSeq,
	axiom: "xF",
	rules: ( $F: "+F-[x]3GdGF", $x: "xG-d[d]G", $d: "5-d5+[x]F"), //, $G: "F"
	gen: 4,
	opts: (
		instr: [\simplePluck, \srrPluck,\detunePluck,\detuneLead],
		legatoArr: 1,
		branchInterval: 4,
		vols: [0.8, 0.8, 0.8, 0.4],
		noteOffset: 36,
		quant: 0,
		baseTempo: 1/5,
		useGlobalPitch: false
	)
);
)

(
~newLsys.(
	name: \rabbitSeq,
	axiom: "x",
	rules: ( $F: "+F[----x]3G++x2G---F", $x: "x3G-x+[F--[x]]"), //, $G: "F"
	gen: 4,
	opts: (
		instr: [\simplePluck, \srrPluck,\detunePluck,\detuneLead],
		legatoArr: 1,
		branchInterval: 4,
		vols: [0.8, 0.8, 0.8, 0.4],
		noteOffset: 36,
		quant: 0,
		baseTempo: 1/6,
		useGlobalPitch: false
	)
);
)

~lsys.presets.rabbitSeq.maxPatDur
~lsys.presets.rabbitSeq.numBranches

~lsys.presets.rabbitSeq.baseTempo = 0.125;
~lsys.presets.rabbitSeq.branchInterval = 5;
~lsys.presets.rabbitSeq.instr = [ 'simplePluck', 'detunePluck', 'srrPluck' ];
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
~lsys.presets.rabbitSeq.vols = [ 1 ,1, 1, 1];
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