"loading vincent cues".postln;

~cueWindow ?? {~cueWindow =  Window.new("cues", Rect(100,450,1400,400)).front};
~cueWindowText = StaticText(~cueWindow, Rect(10,10,1390,350));
~cueWindowText.background=Color.white;
~cueWindowText.align = \center;
~cueWindowText.font = Font("Monaco", 56);
~cueWindowText.string = "cues";

~vincentCues = Dictionary.new;

~vincentCues.add('weed buildup 1' -> {
	~cueWindowText.string = "Weed: 1 -> 0.66; masterFilter: 0.5 -> 1";
	"weed buildup 1".postln;
}
);

~vincentCues.add('weed buildup 1_2' -> {
	~cueWindowText.string = "Weed: 0.66 -> 0.33";
	"weed buildup 1".postln;
}
);

~vincentCues.add('weed buildup 1_3' -> {
	~cueWindowText.string = "Weed: 0.33 -> 0;";
	"weed buildup 1".postln;
}
);

~vincentCues.add('penrose buildup 1' -> {
	~cueWindowText.string = "SimpleSwitch: X -> 0";
	"penrose buildup 1".postln;
}
);

~vincentCues.add('simpleSwitch buildup 1' -> {
	~cueWindowText.string = "SimpleSwitch: 0 -> 1";
	"simpleSwitch buildup 1".postln;
}
);

~vincentCues.add('weed and penrose' -> {
	~cueWindowText.string = "Weed: 0; SimpleSwitch: 1";
	"weed and penrose".postln;
}
);

~vincentCues.add('weed and simpleswitch' -> {
	~cueWindowText.string = "Weed: 0 -> 1; SimpleSwitch: 1 -> 0";
	"weed and simpleswitch".postln;
}
);

~vincentCues.add('weed and penrose 2' -> {
	~cueWindowText.string = "SimpleSwitch: 0";
	"weed and penrose 2".postln;
}
);

~vincentCues.add('simpleSwitch and weed' -> {
	~cueWindowText.string = "SimpleSwitch: 0 -> 1";
	"simpleSwitch and weed".postln;
}
);

~vincentCues.add('simpleSwitch to penrose' -> {
	~cueWindowText.string = "SimpleSwitch: 1 -> 0";
	"simpleSwitch to penrose".postln;
}
);

~vincentCues.add('weed' -> {
	~cueWindowText.string = "Wait";
	"weed".postln;
}
);

~vincentCues.add('penrose to pause' -> {
	~cueWindowText.string = "Wait";
	"penrose to pause".postln;
}
);

~vincentCues.add('penrose to pause2' -> {
	~cueWindowText.string = "Wait";
	"penrose to pause2".postln;
}
);

~vincentCues.add('penrose to pause3' -> {
	~cueWindowText.string = "Wait";
	"penrose to pause3".postln;
}
);

~vincentCues.add('penrose_pauses_gen1' -> {
	~cueWindowText.string = "Wait";
	"penrose_pauses_gen1".postln;
}
);

~vincentCues.add('penrose_pauses_gen2' -> {
	~cueWindowText.string = "Wait";
	"penrose_pauses_gen2".postln;
}
);

~vincentCues.add('penrose_pauses_gen3' -> {
	~cueWindowText.string = "Wait";
	"penrose_pauses_gen3".postln;
}
);

~vincentCues.add('penrose to pause3' -> {
	~cueWindowText.string = "Wait";
	"penrose to pause3".postln;
}
);

~vincentCues.add('penrose_pauses_gen4' -> {
	~cueWindowText.string = "Masterfilter: 1 -> 0.75,
Res: 0 -> 0.8";
	"penrose_pauses_gen4".postln;
}
);

~vincentCues.add('penrose_canon' -> {
	~cueWindowText.string = "Masterfilter: 0.5 slow sine,
Resonance: 0.9";
	"penrose_canon".postln;
}
);

~vincentCues.add('penrose_canon_pausen x fade' -> {
	~cueWindowText.string = "Masterfilter: 0.5 slow sine,
Resonance: 0.9";
	"penrose_canon_pausen x fade".postln;
}
);

~vincentCues.add('penrose_canon_pausen1' -> {
	~cueWindowText.string = "Masterfilter: 0.5 slow sine,
Resonance: 0.9";
	"penrose_canon_pausen1".postln;
}
);

~vincentCues.add('penrose_canon_mehr_pausen x-fade' -> {
	~cueWindowText.string = "Masterfilter: 0.5 -> 1";
	"penrose_canon_mehr_pausen x-fade".postln;
}
);

~vincentCues.add('halftime fade in' -> {
	~cueWindowText.string = "Wait";
	"halftime fade in".postln;
}
);

~vincentCues.add('normaltime fade out' -> {
	~cueWindowText.string = "Wait";
	"normaltime fade out".postln;
}
);

~vincentCues.add('penrose_canon_mehr_pausen' -> {
	~cueWindowText.string = "Wait";
	"penrose_canon_mehr_pausen".postln;
}
);

~vincentCues.add('penrose_canon_mehr_pausen2' -> {
	~cueWindowText.string = "Wait";
	"penrose_canon_mehr_pausen2".postln;
}
);

~vincentCues.add('penrose_canon_mehr_pausen3' -> {
	~cueWindowText.string = "Wait";
	"penrose_canon_mehr_pausen3".postln;
}
);

~vincentCues.add('transition_penrose_simpleSwitch' -> {
	~cueWindowText.string = "SimpleSwitch: 1, Fraktal_1: 0";
	"transition_penrose_simpleSwitch".postln;
}
);

~vincentCues.add('ss_dev_1' -> {
	~cueWindowText.string = "SimpleSwitch: 1 -> 0.5";
	"ss_dev_1".postln;
}
);

~vincentCues.add('ss_dev_1_x_triangle' -> {
	~cueWindowText.string = "SimpleSwitch: 1 -> 0.5; Fraktal_1: 0 -> 0.5";
	"ss_dev_1_x_triangle".postln;
}
);

~vincentCues.add('fraktal_1_half' -> {
	~cueWindowText.string =  "Fraktal_1: 0.5 -> 1";
	"fraktal_1_half".postln;
}
);

~vincentCues.add('simpleSwitch_fadeOut' -> {
	~cueWindowText.string = "SimpleSwitch: 0.5 -> 0";
	"simpleSwitch_fadeOut".postln;
}
);

~vincentCues.add('ss_dev_2' -> {
	~cueWindowText.string = "Fraktal_1: 0";
	"ss_dev_2".postln;
}
);

~vincentCues.add('fraktal_12' -> {
	~cueWindowText.string = "Fraktal_1: 0 -> 1";
	"fraktal_12".postln;
}
);

~vincentCues.add('fraktal_1_inverse7' -> {
	~cueWindowText.string = "Fraktal_1: 1 -> 0 -> 1,
MasterResonance: 0.75";
	"fraktal_1_inverse7".postln;
}
);

~vincentCues.add('fraktal_13 A' -> {
	~cueWindowText.string = "MasterFilter: 1 -> 0.5 in steps,
MasterResonance: 0.75";
	"fraktal_13 A".postln;
}
);

~vincentCues.add('fraktal_13 B' -> {
	~cueWindowText.string = "MasterFilter: 0.5 -> 1,
MasterResonance: 0.75 -> 0";
	"fraktal_13 B".postln;
}
);

~vincentCues.add('fraktal_1_inverse7_2nd' -> {
	~cueWindowText.string = "Fraktal_1: 1 -> 0";
	"fraktal_1_inverse7_2nd".postln;
}
);

~vincentCues.add('Fuge_1_1st' -> {
	~cueWindowText.string = "Fuge_1: 0 -> 1";
	"Fuge_1_1st".postln;
}
);

~vincentCues.add('Fuge_1_2nd' -> {
	~cueWindowText.string = "Fuge_2: 0 -> 1";
	"Fuge_1_2nd".postln;
}
);

~vincentCues.add('Fuge_1_3rd' -> {
	~cueWindowText.string = "Fuge_3: 0 -> 1, MasterResonance: X -> 0.75";
	"Fuge_1_3rd".postln;
}
);

~vincentCues.add('Fuge_1_4th' -> {
	~cueWindowText.string = "Fuge_4: 0 -> 1";
	"Fuge_1_4th".postln;
}
);







"vincent cues loaded".postln;
