(
{
	"../Synthese_Sounddesign/0_main_patch.scd".loadRelative;

	~localSetup = true; // hier und bei globals ist das relevant

	"resources/globals.scd".loadRelative;
	"resources/lsysCreator_noDaemon.scd".loadRelative;
	"resources/pdefCreator.scd".loadRelative; // load pdef which will play back lsystems
	"resources/lsys_dict_text_replace.scd".loadRelative;


}.fork
)


/*
F - play
G - rest
- -down
+ - up
[] - new branch
| - play no rule
*/
(
~newLsys.(
	name: \rabbitSeq,
	axiom: "F",
	rules: ( $F: "+F-G--F++GFG", $G: "F[F]" ),
	gen: 8.0
);
)

Pdef(\rabbitSeq).play(1)
~lsys.presets.rabbitSeq.instr = \blip
~lsys.presets.rabbitSeq.baseTempo = 1/8
~lsys.presets.rabbitSeq.quant = 0
Pdef(\play, Psym(Pseq([\rabbitSeq], inf))).play(~linkClock, quant: 4)

(
~newLsys.(
	name: \theLick,
	axiom: "-F",//"F-F-F-F-F",
	rules: ( $F: "F+F+F+F--FG--F+FGG" ),
	gen: 2.0
);
)

Pdef(\basicL).play(l)
~lsys.presets.theLick.instr = \simpleBass
~lsys.presets.theLick.baseTempo = 1/7
~lsys.presets.theLick.quant = 0
Pdef(\play, Psym(Pseq([\theLick], inf))).play

(
~newLsys.(
	name: \fuenfte,
	axiom: "F-[F-F]-F-F",
	rules: ( $F: "GFFF--FGGG" ),
	gen: 2.0
);
)

Pdef(\basicL).play(l)
~ctlPresets.fuenfte.presetName = \simplePluck
~ctlPresets.theLick.baseTempo = 1/4
Pdef(\play, Psym(Pseq([\fuenfte], inf))).play




\srrLead
\formantLead
\noisyLead



// baueme umdrehen
~newLsys.(
	name: \snowFlake,
	axiom: "F",
	rules: ($F: "F-[|4+[|4G]10F]F"),
	gen: 2.0
)

Pdef(\snowFlake).play(l)
~ctlPresets.snowFlake.baseTempo = 1/8
~ctlPresets.snowFlake.presetName = \srrLead
Pdef(\play, Psym(Pseq([\snowFlake], inf))).play

(
~newLsys.(
	name: \pausen,
	axiom: "G",
	rules: ( $F: "-F++F-F", $G: "G--X++G[X-X+F]", $X: "[XG-F]----XG++++F" ),
	gen: 2,
	opts: (
		instr: [\simplePluck, \simplePluck, \srrPluck],
		useGlobalPitch: false,
		noteOffset: 28,
		vols: [0.8, 0.7, 0.7],
		legatoArr: 1,
		quant: 0
	)
)
)
~lsys.presets.pausen.numBranches
Pdef(\play, Pn(Pdef(\pausen))).play

// es gibt fuer jedes lsystem pdef ein pdef mit dem namen + _filter
// außerdem für jedes "branchLevel" ein pdef mit dem namen + _filter0 (_filter1, _filter2 .. )
// alle werden mit leerem Pbind initialisiert (bewirken also keine änderung)

// fuer das gesamte lsys den wert \oscillator_mod_1 ändern wenn der char F ist
Pdef(\pausen_filter,
	Pbind(\oscillator_mod_1, Pfunc {|ev|
		if(ev.charNow == $F){0}{ev.oscillator_mod_1}
})
)
Pdef(\pausen_filter, Pbind()) // rückgängig machen

// fuer branchlevel 0 (root) midinote random ändern
Pdef(\pausen_filter0,
	Pbind(\midinote, Pkey(\midinote) + Prand([0,7],inf))
)
Pdef(\pausen_filter0, Pbind()) // rückgängig machen

// bei level 2 alle X rausfiltern
Pdef(\pausen_filter1,
	Pbind(\vol, Pfunc{|ev|
		if(ev.charNow == $X){0}{ev.vol}})
)
Pdef(\pausen_filter1, Pbind())

// bei level 3 alle F rausfiltern
Pdef(\pausen_filter2,
	Pbind(\vol, Pfunc{|ev|
		if(ev.charNow == $F){0}{ev.vol}})
)
Pdef(\pausen_filter2, Pbind())
