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

~newLsys.(
	name: \basicL,
	axiom: "F",//"F-F-F-F-F",
	rules: ( $F: "F[FGF]-FG+F[--FF]+F-F" ),
	gen: 2.0
)

/*
F - play
G - rest
- -down
+ - up
[] - new branch
| - play no rule
*/


Pdef(\basicL).play(l)


Pdef(\play, Psym(Pseq([\basicL], inf))).play

~ctlPresets.basicL.presetName = \srrPluck




// baueme umdrehen
~newLsys.(
	name: \snowFlake,
	axiom: "F",
	rules: ($F: "F-[|4+[|4G]10F]F"),
	gen: 2.0
)

Pdef(\snowFlake).play(l)
~ctlPresets.snowFlake.baseTempo = 1/8

~newLsys.(
	name: \pausen,
	axiom: "F-G",
	rules: ( $F: "FG[F-F-GGGF-F++F]F+F", $G: "GGF" ),
	gen: 3
)