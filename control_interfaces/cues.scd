~cueEvents = Dictionary.new;

~cueEvents.add(\cue1 -> {

	~cueWindowText.string = "A 1 - 0.5 - 1, B 1 - 0.25";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlKnobLEDsSetRow.(1,1);
	~launchControlXlUpdateKnobLEDs.value;
});

~cueEvents.add(\cue2 -> {

	~cueWindowText.string = "cue_2";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlKnobLEDsSetRow.(2,1);
	~launchControlXlUpdateKnobLEDs.value;
});


(
"loading control interfaces".postln;
"control_interfaces/midi_defs_launchcontrol-xl.scd".loadRelative;
"control_interfaces/performance_programs_launchcontrol-xl/launchcontrol-xl_load_modules.scd".loadRelative;
"control_interfaces/cueWindowSetup.scd".loadRelative;
"control_interfaces/cues.scd".loadRelative;
)