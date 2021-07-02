~cueEvents = Dictionary.new;

~cueEvents.add(\cue1 -> {

	~cueWindowText.string = "A 1 - 0.5 - 1, B 1 - 0.25";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlKnobLEDsSetRow.(1,1);
	~launchControlXlUpdateKnobLEDs.value;
}.fork(AppClock));

~cueEvents.add(\cue2 -> {

	~cueWindowText.string = "cue_2";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlKnobLEDsSetRow.(2,1);
	~launchControlXlUpdateKnobLEDs.value;
}.fork(AppClock));

