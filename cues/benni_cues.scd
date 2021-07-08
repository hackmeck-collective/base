"loading benni cues".postln;

~benniCues = Dictionary.new;

~benniCues.add('weed buildup 1' -> {
	~cueWindowText.string = "Weed: 1 -> 0; masterFilter: 0.5 -> 1";
	/*~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlKnobLEDsSetRow.([1,8],1);
	~launchControlXlUpdateKnobLEDs.value;*/
	"weed buildup 1".postln;
}
);



~benniCues.add('penrose buildup 1' -> {
	~cueWindowText.string = "SimpleSwitch: X -> 0";
		/*~launchControlXlKnobLEDsSetRow.((1..8),0);
		~launchControlXlKnobLEDsSetRow.([3,8],3);
		~launchControlXlUpdateKnobLEDs.value;*/
	"penrose buildup 1".postln;
}
);

"benni cues loaded".postln;
