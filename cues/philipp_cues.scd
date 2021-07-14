"loading philipp cues".postln;
//address_book_all.scd enthält ~cueSymbols. Die führt immer wenn etwas neues durch Utopia kommt die Funktion ~cueFunction aus.


//w ?? {w =  Window.new("cues", Rect(100, 0, 1600, 800)).front};
~cueWindowText = StaticText(w, Rect(20,400,1200,280));
~cueWindowText.background=Color.white;
~cueWindowText.align = \center;
~cueWindowText.font = Font("Monaco", 48);
~cueWindowText.string = "gleich: 8-0-7-Bartok-36-84";


~cueFunction = {|cue|
	if(~philippCues[cue.asSymbol].notNil) {
		~philippCues[cue.asSymbol].fork(AppClock);
	}{ "cue not in Dictionary".warn; };
};


~philippCues = Dictionary.new;

~philippCues.add('weed buildup 1' -> {
	~cueWindowText.string = "8-0-7-Bartok-36-84";
	"weed buildup 1".postln;
}
);


~philippCues.add('penrose buildup 1' -> {
	~cueWindowText.string = "Wait";
	"penrose buildup 1".postln;
}
);


~philippCues.add('simpleSwitch to penrose' -> {
	~cueWindowText.string = "Wait";
	"simpleSwitch to penrose".postln;
}
);

~philippCues.add('weed' -> {
	~cueWindowText.string = "6-0-5-Bartok-36-84";
	"weed".postln;
}
);

~philippCues.add('weed and simpleswitch' -> {
	~cueWindowText.string = "gleich: 7-0-4-Bartok-36-84";
	"weed and simpleswitch".postln;
}
);

~philippCues.add('weed and penrose 2' -> {
	~cueWindowText.string = "7-0-4-Bartok-36-84";
	"weed and penrose 2".postln;
}
);

~philippCues.add('simpleSwitch and weed' -> {
	~cueWindowText.string = "Wait";
	"simpleSwitch and weed".postln;
}
);

~philippCues.add('penrose to pause' -> {
	~cueWindowText.string = "Wait";
	"penrose to pause".postln;
}
);


~philippCues.add('penrose_pauses_gen1' -> {
	~cueWindowText.string = "Wait";
	"penrose_pauses_gen1".postln;
}
);

~philippCues.add('penrose_pauses_gen2' -> {
	~cueWindowText.string = "Wait";
	"penrose_pauses_gen2".postln;
}
);

~philippCues.add('penrose_pauses_gen2_bd_solo' -> {
	~cueWindowText.string = "gleich: 6-0-5-Major-24-84
8-0-5-Major
6-0-6-Major
8-0-6-Major";
	"penrose_pauses_gen2_bd_solo".postln;
}
);

~philippCues.add('penrose_pauses_gen3' -> {
	~cueWindowText.string = "6-0-5-Major-24-84
8-0-5-Major
6-0-6-Major
8-0-6-Major
SOLO";
	"penrose_pauses_gen3".postln;
}
);


~philippCues.add('penrose_pauses_gen4' -> {
	~cueWindowText.string = "6-0-5-Major-36-84
8-0-5-Major-48-84
6-0-6-Major
8-0-6-Major
SOLO";
	"penrose_pauses_gen4".postln;
}
);


~philippCues.add('penrose_canon' -> {
	~cueWindowText.string = "6-0-5-Major-36-84
8-0-5-Major-48-84
6-0-6-Major
8-0-6-Major
SOLO";
	"penrose_canon".postln;
}
);

~philippCues.add('penrose_canon_pausen x fade' -> {
	~cueWindowText.string = "6-0-5-Bartok-36-84
8-0-6-Diminished-36-84
SOLO";
	"penrose_canon_pausen x fade".postln;
}
);

~philippCues.add('penrose_canon_pausen1' -> {
	~cueWindowText.string = "6-0-5-Bartok-36-84
8-0-6-Diminished-36-84
SOLO";
	"penrose_canon_pausen1".postln;
}
);

~philippCues.add('penrose_canon_pausen2' -> {
	~cueWindowText.string = "6-0-5-Bartok-36-84
8-0-6-Diminished-36-84
SOLO";
	"penrose_canon_pausen2".postln;
}
);

~philippCues.add('penrose_canon_mehr_pausen x-fade' -> {
	~cueWindowText.string = "6-0-5-Bartok-36-84
8-0-6-Diminished-36-84
SOLO";
	"penrose_canon_mehr_pausen x-fade".postln;
}
);

~philippCues.add('halftime fade in' -> {
	~cueWindowText.string = "6-0-5-Bartok-36-84
8-0-6-Diminished-36-84";
	"halftime fade in".postln;
}
);

~philippCues.add('normaltime fade out' -> {
	~cueWindowText.string = "6-0-5-Bartok-36-84
8-0-6-Diminished-36-84";
	"normaltime fade out".postln;
}
);

~philippCues.add('penrose_canon_mehr_pausen' -> {
	~cueWindowText.string = "6-0-5-Bartok-36-84
8-0-6-Diminished-36-84";
	"penrose_canon_mehr_pausen".postln;
}
);

~philippCues.add('transition_penrose_simpleSwitch' -> { //Hier nichts ändern
	~cueWindowText.string = "gleich: 9-0-7-Chromatisch-36-96
9-0-6-Chromatisch-36-96".postln;
}
);

~philippCues.add('ss_dev_1' -> {
	~cueWindowText.string = "9-0-7-Chromatisch-36-96
9-0-6-Chromatisch-36-96";
	"simpleswitch_dev_1".postln;
}
);

~philippCues.add('ss_dev_1_x_triangle' -> {
	~cueWindowText.string = "gleich: 6-0-7-Minor-36-96";
	"ss_dev_1_x_triangle".postln;
}
);

~philippCues.add('fraktal_1_half' -> {
	~cueWindowText.string =  "6-0-7-Minor-36-96";
	"fraktal_1_half".postln;
}
);

~philippCues.add('simpleSwitch_fadeOut' -> {
	~cueWindowText.string = "6-0-7-Minor-36-96";
	"simpleSwitch_fadeOut".postln;
}
);

~philippCues.add('ss_dev_2' -> {
	~cueWindowText.string = "WAIT";
	"ss_dev_2".postln;
}
);

~philippCues.add('fraktal_12' -> {
	~cueWindowText.string = "WAIT";
	"fraktal_12".postln;
}
);

~philippCues.add('fraktal_1_inverse7' -> {
	~cueWindowText.string = "gleich: 9-0-6-diminished-36-96"; //"6-0-6-chromatic-36-84";
	"fraktal_1_inverse7".postln;
}
);

~philippCues.add('fraktal_13 A' -> {
	~cueWindowText.string = "gleich: 9-0-6-diminished-36-96";
	"fraktal_13 A".postln;
}
);

~philippCues.add('fraktal_13 B' -> {
	~cueWindowText.string = "9-0-6-diminished-36-96";
	"fraktal_13 B".postln;
}
);


~philippCues.add('fraktal_1_inverse7_2nd' -> {
	~cueWindowText.string = "9-0-6-diminished-36-96";
	//"6-0-5-Bartok-36-84 6-0-5-Bartok-60-108 6-0-5-Chromatisch-60-108";
	"fraktal_1_inverse7_2nd".postln;
}
);
~philippCues.add('fraktal_philipp' -> {
	~cueWindowText.string = "5-0-5-Whole Tone-36-96";
	"fraktal_philipp".postln;
}
);


~philippCues.add('Fuge_1_1st' -> {
	~cueWindowText.string = "8-0-6-Bartok-36-96
teste
AMBITUS";
	"Fuge_1_1st".postln;
}
);


~philippCues.add('Fuge_1_2nd' -> {
	~cueWindowText.string = "8-0-6-Bartok-36-96
teste
AMBITUS";
	"Fuge_1_2nd".postln;
}
);

~philippCues.add('Fuge_1_3rd' -> {
	~cueWindowText.string = "8-0-6-Bartok-60-96
teste
AMBITUS";
	"Fuge_1_3rd".postln;
}
);

~philippCues.add('Fuge_1_4th' -> {
	~cueWindowText.string = "8-0-6-Bartok-36-96
AMBITUS";
	"Fuge_1_4th".postln;
}
);

"philipp cues loaded".postln;
