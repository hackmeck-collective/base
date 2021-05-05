(
var opts = (
	useGlobalPitch: false,
	noteOffset: 12,
	branchInterval: 5,
	quant: 1/2,
	vols: [1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0],
	baseTempo: 1/8,
	instr: [\blip, \blip, \blip, \blip] // erstes \variedPlucks geht auch
);
~newLsys.(
	name: \newBranchTest,
	axiom: "F", //"XF",
	rules: ( $F: "--FGXXG[++XX--FGYGGYGGY]+F++XGGX+GX---GX", $X: "GY"),
	gen: 5,
	opts: opts
)

)
Pdef(\play, Pdef(\newBranchTest))
~lsys.presets.newBranchTest.maxPatDur
~lsys.presets.newBranchTest.reveal
(
Pbind(\dur, 1/2, \note, 24, \legato, 0.2).play(~linkClock, quant:1 );
Pdef(\play).play(~linkClock, quant:1);
)
~linkClock.tempo = 1.15
Pdef(\play).clear

Pdef(\newBranchTest_filter, Pbind(\stretch, Pn(Plazy{~stretchPat})))
~stretchPat = Prand([Pseq([4,3].normalizeSum * 2), Pseq([1,1].normalizeSum * 2)]);
// bisschen janky aber man kann sich dran gewoehnen
~stretchPat = Prand([Pseq([3,5].normalizeSum * 2), Pseq([1,1].normalizeSum * 2)]);
~stretchPat = Pseq([5,4].normalizeSum * 2);
~stretchPat = Pseq([4,3].normalizeSum * 2);
~stretchPat = Pseq([3,2].normalizeSum * 2);
~stretchPat = Pseq([1,3].normalizeSum * 2);

~stretchPat = Pseq([1,2,3].normalizeSum * 3);
~stretchPat = Pseq([4,1,1].normalizeSum * 3);
~stretchPat = Pseq([7,1,2].normalizeSum * 3);

~stretchPat = Pseq([1,1,2,4].normalizeSum * 4);

~stretchPat = Pseq([3,2,2,2].normalizeSum * 4);
~stretchPat = Pseq([1,3,3,1].normalizeSum * 4);

~stretchPat = Pseq([1,3,6,12].normalizeSum * 4);
~stretchPat = Pseq([1,2,1,4].normalizeSum * 4);
