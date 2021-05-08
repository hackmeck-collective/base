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

~instrPreset.create(\crackle);
~instrPreset.edit(\wub);

////////////////// simpleSwitch1
Pdef(\play).clear
(
(Pbind(\controlbus, ~launchcontrol_xl_row_1)
<> Pdef(\simpleSwitchMelody)
<> Pbind(
	\external1Target, "filter_1_mod_1",
	\external1Amount, 0.5,
	\external1Target2, "fx_mod_1",
	\external1Amount2, 1,
	\external2Target, "envelope_mod",
	\external2Amount, 1,
)).play(~linkClock, quant: 1);
(Pbind(\controlbus, ~launchcontrol_xl_row_1)
<> Pdef(\simpleSwitchMelody_bd)
// <> Pbind(\external1Target, "envelope_mod",
// \external1Amount, 1)
).play(~linkClock, quant: 1);
(Pbind(\controlbus, ~launchcontrol_xl_row_1)
<> Pdef(\simpleSwitchMelody_sd)
// <> Pbind(\external1Target, "envelope_mod",
// \external1Amount, 1)
).play(~linkClock, quant: 1);
// ( Pdef(\sd2) <> Pbindef(\fifth) <> Pbindef(\pulse_4_ob)  ).play(~linkClock, quant: 1);
// ( Pdef(\bd1) <> Pbindef(\root) <> Pbindef(\pulse) ).play(~linkClock, quant: 1);
);


(
var testArray = (2..9);
var testName = "simpleSwitchMelody";
var testNameAdd = "_bd";
var testNameAdd2 = "_sd";
var baseTempo = 1/8;
var leadInstr1 = \simplePluck;
var branchInstr1 = \simplePluck;
var percInstr1 = \bdBuzz;
var percInstr2 = \metalPerc;
var testSymbols, testSymbols2, testSymbols3;

testArray.do(
	{ |item|


		~newLsys.(
			name: (testName ++ testNameAdd ++ item).asSymbol,
			axiom: "G",
			rules: ( $F: "Gf" , $f: "Gf", $G: "FG" ),
			gen: item,
			opts: (
				useGlobalPitch: false,
				noteOffset: -24,
				quant: 0,
				baseTempo: baseTempo,
				legatoArr: 0.99,
				wrapLo: [ 12 ],
				wrapHi: [ 36 ],
				instr: percInstr1,
				vols: 0.75
			)
		);

	}
);
)
