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

~newLsys.(
	name: \pausen,
	axiom: "F-G",
	rules: ( $F: "FG[F-F-GGGF-F++F]F+F", $G: "GGF" ),
	gen: 3
)