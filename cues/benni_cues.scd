"loading benni cues".postln;

~cueWindow ?? {~cueWindow =  Window.new("cues", Rect(100,450,1400,400)).front};
~cueWindowText = StaticText(~cueWindow, Rect(10,10,1390,350));
~cueWindowText.background=Color.white;
~cueWindowText.align = \center;
~cueWindowText.font = Font("Monaco", 48);
~cueWindowText.string = "cues";
~meterWindow ?? {~meterWindow =  Window.new("meter", Rect(100,50,1400,250)).front};
~cueWindowMeter = ServerMeterView.new(s,~meterWindow, 0@0, 0, s.options.numOutputBusChannels);
~cueWindowText.string = "Weed: 1, SimpleSwitch: 0, masterFilter: 0.5, res: 0";
~launchControlXlKnobLEDsSetRow.((1..8),0);
~launchControlXlKnobLEDsSetRow.([1,2,3,4,5,8],3);
~launchControlXlUpdateKnobLEDs.value;

~benniCues = Dictionary.new;

~benniCues.add('weed buildup 1' -> {
	~cueWindowText.string = "Weed: 1 -> 0; masterFilter: 0.5 -> 1";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlKnobLEDsSetRow.([1,8],1);
	~launchControlXlUpdateKnobLEDs.value;
	"weed buildup 1".postln;
}
);

~benniCues.add('penrose buildup 1' -> {
	~cueWindowText.string = "SimpleSwitch: X -> 0";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlKnobLEDsSetRow.(3,3);
	~launchControlXlUpdateKnobLEDs.value;
	"penrose buildup 1".postln;
}
);

~benniCues.add('simpleSwitch buildup 1' -> {
	~cueWindowText.string = "SimpleSwitch: 0 -> 1";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlKnobLEDsSetRow.(3,1);
	~launchControlXlUpdateKnobLEDs.value;
	"simpleSwitch buildup 1".postln;
}
);

~benniCues.add('weed and penrose' -> {
	~cueWindowText.string = "Weed: 0; SimpleSwitch: 1";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlKnobLEDsSetRow.([1,3],3);
	~launchControlXlUpdateKnobLEDs.value;
	"weed and penrose".postln;
}
);

~benniCues.add('weed and simpleswitch' -> {
	~cueWindowText.string = "Weed: 0 -> 1; SimpleSwitch: 1 -> 0";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlKnobLEDsSetRow.([1,3],1);
	~launchControlXlUpdateKnobLEDs.value;
	"weed and simpleswitch".postln;
}
);

~benniCues.add('weed and penrose 2' -> {
	~cueWindowText.string = "Wait";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlUpdateKnobLEDs.value;
	"weed and penrose 2".postln;
}
);

~benniCues.add('simpleSwitch and weed' -> {
	~cueWindowText.string = "SimpleSwitch: 1";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlKnobLEDsSetRow.(3,3);
	~launchControlXlUpdateKnobLEDs.value;
	"simpleSwitch and weed".postln;
}
);

~benniCues.add('simpleSwitch to penrose' -> {
	~cueWindowText.string = "SimpleSwitch: 1 -> 0";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlKnobLEDsSetRow.(3,1);
	~launchControlXlUpdateKnobLEDs.value;
	"simpleSwitch to penrose".postln;
}
);

~benniCues.add('weed' -> {
	~cueWindowText.string = "Wait";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlUpdateKnobLEDs.value;
	"weed".postln;
}
);

~benniCues.add('penrose to pause' -> {
	~cueWindowText.string = "Wait";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlUpdateKnobLEDs.value;
	"penrose to pause".postln;
}
);

~benniCues.add('penrose to pause2' -> {
	~cueWindowText.string = "Wait";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlUpdateKnobLEDs.value;
	"penrose to pause2".postln;
}
);

~benniCues.add('penrose to pause3' -> {
	~cueWindowText.string = "Wait";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlUpdateKnobLEDs.value;
	"penrose to pause3".postln;
}
);

~benniCues.add('penrose_pauses_gen1' -> {
	~cueWindowText.string = "Wait";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlUpdateKnobLEDs.value;
	"penrose_pauses_gen1".postln;
}
);

~benniCues.add('penrose_pauses_gen2' -> {
	~cueWindowText.string = "Wait";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlUpdateKnobLEDs.value;
	"penrose_pauses_gen2".postln;
}
);

~benniCues.add('penrose_pauses_gen3' -> {
	~cueWindowText.string = "Wait";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlUpdateKnobLEDs.value;
	"penrose_pauses_gen3".postln;
}
);

~benniCues.add('penrose to pause3' -> {
	~cueWindowText.string = "Wait";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlUpdateKnobLEDs.value;
	"penrose to pause3".postln;
}
);

~benniCues.add('penrose_pauses_gen4' -> {
	~cueWindowText.string = "Wait";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlUpdateKnobLEDs.value;
	"penrose_pauses_gen2".postln;
}
);

~benniCues.add('penrose_canon' -> {
	~cueWindowText.string = "Wait";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlUpdateKnobLEDs.value;
	"penrose_canon".postln;
}
);

~benniCues.add('penrose_canon_pausen x fade' -> {
	~cueWindowText.string = "Wait";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlUpdateKnobLEDs.value;
	"penrose_canon_pausen x fade".postln;
}
);

~benniCues.add('penrose_canon_pausen1' -> {
	~cueWindowText.string = "Wait";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlUpdateKnobLEDs.value;
	"penrose_canon_pausen1".postln;
}
);

~benniCues.add('penrose_canon_mehr_pausen x-fade' -> {
	~cueWindowText.string = "Wait";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlUpdateKnobLEDs.value;
	"penrose_canon_mehr_pausen x-fade".postln;
}
);

~benniCues.add('halftime fade in' -> {
	~cueWindowText.string = "Wait";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlUpdateKnobLEDs.value;
	"halftime fade in".postln;
}
);

~benniCues.add('normaltime fade out' -> {
	~cueWindowText.string = "Wait";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlUpdateKnobLEDs.value;
	"normaltime fade out".postln;
}
);

~benniCues.add('penrose_canon_mehr_pausen' -> {
	~cueWindowText.string = "Wait";
	~launchControlXlKnobLEDsSetRow.((1..~benniCues.add('transition_penrose_simpleSwitch' -> {
		~cueWindowText.string = "Wait";
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		~launchControlXlUpdateKnobLEDs.value;
		"transition_penrose_simpleSwitch".postln;
	}
	);8),0);
	~launchControlXlUpdateKnobLEDs.value;
	"penrose_canon_mehr_pausen".postln;
}
);

~benniCues.add('penrose_canon_mehr_pausen2' -> {
	~cueWindowText.string = "Wait";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlUpdateKnobLEDs.value;
	"penrose_canon_mehr_pausen2".postln;
}
);

~benniCues.add('penrose_canon_mehr_pausen3' -> {
	~cueWindowText.string = "Wait";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlUpdateKnobLEDs.value;
	"penrose_canon_mehr_pausen3".postln;
}
);

~benniCues.add('transition_penrose_simpleSwitch' -> {
	~cueWindowText.string = "SimpleSwitch: 1, Fraktal_1: 0";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlKnobLEDsSetRow.([3,4],3);
	~launchControlXlUpdateKnobLEDs.value;
	"transition_penrose_simpleSwitch".postln;
}
);

~benniCues.add('ss_dev_1' -> {
	~cueWindowText.string = "SimpleSwitch: 1 -> 0.5";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlKnobLEDsSetRow.([3],1);
	~launchControlXlUpdateKnobLEDs.value;
	"ss_dev_1".postln;
}
);

~benniCues.add('ss_dev_1_x_triangle' -> {
	~cueWindowText.string = "SimpleSwitch: 1 -> 0.5; Fraktal_1: 0 -> 0.5";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlKnobLEDsSetRow.([3,4],1);
	~launchControlXlUpdateKnobLEDs.value;
	"ss_dev_1_x_triangle".postln;
}
);

~benniCues.add('fraktal_1_half' -> {
	~cueWindowText.string =  "Fraktal_1: 0.5 -> 1";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlKnobLEDsSetRow.(4,1);
	~launchControlXlUpdateKnobLEDs.value;
	"fraktal_1_half".postln;
}
);

~benniCues.add('simpleSwitch_fadeOut' -> {
	~cueWindowText.string = "SimpleSwitch: 0.5 -> 0";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlKnobLEDsSetRow.(3,1);
	~launchControlXlUpdateKnobLEDs.value;
	"simpleSwitch_fadeOut".postln;
}
);

~benniCues.add('ss_dev_2' -> {
	~cueWindowText.string = "Fraktal_1: 0";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlKnobLEDsSetRow.([4],3);
	~launchControlXlUpdateKnobLEDs.value;
	"ss_dev_2".postln;
}
);

~benniCues.add('fraktal_12' -> {
	~cueWindowText.string = "Fraktal_1: 0 -> 1";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlKnobLEDsSetRow.([4],1);
	~launchControlXlUpdateKnobLEDs.value;
	"fraktal_12".postln;
}
);

~benniCues.add('fraktal_1_inverse7' -> {
	~cueWindowText.string = "Fraktal_1: 0 -> 1; MasterResonance: 0.75";
	~launchControlXlKnobLEDsSetRow.((1..8),0);
	~launchControlXlKnobLEDsSetRow.(4,1);
	~launchControlXlKnobLEDsSetRow.(8,3);
	~launchControlXlUpdateKnobLEDs.value;
	"fraktal_1_inverse7".postln;
}
);

~benniCues.add('fraktal_13 A' -> {
	~cueWindowText.string = "MasterFilter: 1 -> 0.5; MasterResonance: 0.75";
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		~launchControlXlKnobLEDsSetRow.(8,1);
		~launchControlXlUpdateKnobLEDs.value;
	"fraktal_13 A".postln;
}
);

~benniCues.add('fraktal_13 B' -> {
	~cueWindowText.string = "MasterFilter: 0.5 -> 1; MasterResonance: 0.75 -> 0";
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		~launchControlXlKnobLEDsSetRow.(8,1);
		~launchControlXlUpdateKnobLEDs.value;
	"fraktal_13 B".postln;
}
);

~benniCues.add('fraktal_1_inverse7_2nd' -> {
	~cueWindowText.string = "Fraktal_1: 0 -> 1";
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		~launchControlXlKnobLEDsSetRow.(4,1);
		~launchControlXlUpdateKnobLEDs.value;
	"fraktal_1_inverse7_2nd".postln;
}
);

~benniCues.add('Fuge_1_1st' -> {
	~cueWindowText.string = "Fuge_1: 0 -> 1";
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		8.do({|i|
		~toLaunchControlXl.noteOn(0, (41 + i), 12);
		});
		~toLaunchControlXl.noteOn(0, 41, 60);
		~launchControlXlUpdateKnobLEDs.value;
	"Fuge_1_1st".postln;
}
);

~benniCues.add('Fuge_1_2nd' -> {
	~cueWindowText.string = "Fuge_2: 0 -> 1";
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		8.do({|i|
		~toLaunchControlXl.noteOn(0, (41 + i), 12);
		});
		~toLaunchControlXl.noteOn(0, 42, 60);
		~launchControlXlUpdateKnobLEDs.value;
	"Fuge_1_2nd".postln;
}
);

~benniCues.add('Fuge_1_3rd' -> {
	~cueWindowText.string = "Fuge_3: 0 -> 1, MasterResonance: X -> 0.75";
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		8.do({|i|
		~toLaunchControlXl.noteOn(0, (41 + i), 12);
		});
		~toLaunchControlXl.noteOn(0, 43, 60);
		~launchControlXlUpdateKnobLEDs.value;
	"Fuge_1_3rd".postln;
}
);

~benniCues.add('Fuge_1_4th' -> {
	~cueWindowText.string = "Fuge_4: 0 -> 1";
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		8.do({|i|
		~toLaunchControlXl.noteOn(0, (41 + i), 12);
		});
		~toLaunchControlXl.noteOn(0, 44, 60);
		~launchControlXlUpdateKnobLEDs.value;
	"Fuge_1_4th".postln;
}
);







"benni cues loaded".postln;
