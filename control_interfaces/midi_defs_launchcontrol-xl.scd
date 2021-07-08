var buttonMidiNoteoffsetRow1 = 41;
var buttonMidiNoteoffsetRow2 = 73;

var knobRow1Offset = 13;
var knobRow2Offset = 29;
var knobRow3Offset = 49;
var faderOffset = 77;

~gradualControllerValueChange = { |oldVal, newVal|
	var diff = newVal - oldVal;
	oldVal + (diff * diff.lincurve(0.1,0.9,1,0.5,-2));
};

"connecting launchControlXl".postln;

if(MIDIClient.initialized.not){
	MIDIClient.init;
	MIDIIn.connectAll;
};

if (~launchcontrol_xl_port.isNil) {
	~launchcontrol_xl_port = MIDIClient.destinations.detectIndex({|item| item.asString.contains("Launch Control XL")});
	~toLaunchControlXl = MIDIOut.new(~launchcontrol_xl_port);
	~toLaunchControlXl.connect(~launchcontrol_xl_port);
	"launchControlXl connected"
};

"mapping knobs and faders on launchcontrol xl".postln;

MIDIdef.cc(\knobsAndFaders, {
	|val, num|

	var approachValue = val.linlin(1,127,0,1)/*.postln*/;
	var busIndex;
	var savedValue;
	var smoothedValue;

	case
	{(num >= knobRow1Offset ) && (num <= (knobRow1Offset + 7))} {busIndex = (num - knobRow1Offset)}
	{(num >= knobRow2Offset ) && (num <= (knobRow2Offset + 7))} {busIndex = (num - knobRow2Offset + 8)}
	{(num >= knobRow3Offset ) && (num <= (knobRow3Offset + 7))} {busIndex = (num - knobRow3Offset + 16)}
	{(num >= faderOffset ) && (num <= (faderOffset + 7))} {busIndex = (num - faderOffset + 24)}
	{true}{nil};

	savedValue = ~launchcontrolXlControlBusses[busIndex].getSynchronous;

	smoothedValue = ~gradualControllerValueChange.(savedValue, approachValue);

	~launchcontrolXlControlBusses[busIndex].set(smoothedValue);

	// not used?
	// ~osc_data_params["launchControlXlBus_%".format(busIndex).asSymbol] = smoothedValue;

}).permanent_(true);



"initializing LEDs on launchControlXl".postln;

"setting up sysex message for LEDs on launchControlXl".postln;

~launchcontrolXlSetLedMsg = {|button, state|
	Int8Array[240, 0, 32, 41, 2, 17, 120, 0, button, state, 247]
};

~launchControlXlBank = 0;

"setting up Knob LEDs on launchControlXl".postln;

~launchControlXlKnobLEDs = 0!192;

~launchControlXlKnobLEDsSetRow = {|row, state|
	3.do{|i|
		~launchControlXlKnobLEDs.put((row - 1) + ((i * 8) + (~launchControlXlBank * 24)), state);
	};
};

~launchControlXlUpdateKnobLEDs = {
	24.do { |i|
		var bankIndex = i + (~launchControlXlBank * 24);
		var knobLedSysexOffset = 0;

		switch (~launchControlXlKnobLEDs[bankIndex],
			0, { ~toLaunchControlXl.sysex(~launchcontrolXlSetLedMsg.(knobLedSysexOffset + i, 12)) },
			1, { ~toLaunchControlXl.sysex(~launchcontrolXlSetLedMsg.(knobLedSysexOffset + i, 60)) },
			2, { ~toLaunchControlXl.sysex(~launchcontrolXlSetLedMsg.(knobLedSysexOffset + i, 63)) },
			3, { ~toLaunchControlXl.sysex(~launchcontrolXlSetLedMsg.(knobLedSysexOffset + i, 15)) },
			4, { ~toLaunchControlXl.sysex(~launchcontrolXlSetLedMsg.(knobLedSysexOffset + i, 62)) },
			1.1, { ~toLaunchControlXl.sysex(~launchcontrolXlSetLedMsg.(knobLedSysexOffset + i, 28)) },
			2.1, { ~toLaunchControlXl.sysex(~launchcontrolXlSetLedMsg.(knobLedSysexOffset + i, 29)) },
			3.1, {~toLaunchControlXl.sysex(~launchcontrolXlSetLedMsg.(knobLedSysexOffset + i, 13))  },
		);
	};
};



"setting up bottom row button LEDs on launchControlXl".postln;

~launchControlXlBottomLEDs = 0!64;

~launchControlXlUpdateBottomLEDs = {
	8.do { |i|
		var bankIndex = i + (~launchControlXlBank*8);
		var buttonsLedSysexOffset = 32;

		switch (~launchControlXlBottomLEDs[bankIndex],
			0, { ~toLaunchControlXl.sysex(~launchcontrolXlSetLedMsg.(buttonsLedSysexOffset + i, 12)) },
			1, { ~toLaunchControlXl.sysex(~launchcontrolXlSetLedMsg.(buttonsLedSysexOffset + i, 60)) },
			2, { ~toLaunchControlXl.sysex(~launchcontrolXlSetLedMsg.(buttonsLedSysexOffset + i, 63)) },
			3, { ~toLaunchControlXl.sysex(~launchcontrolXlSetLedMsg.(buttonsLedSysexOffset + i, 15)) },
			4, { ~toLaunchControlXl.sysex(~launchcontrolXlSetLedMsg.(buttonsLedSysexOffset + i, 62)) },
			1.1, { ~toLaunchControlXl.sysex(~launchcontrolXlSetLedMsg.(buttonsLedSysexOffset + i, 28)) },
			2.1, { ~toLaunchControlXl.sysex(~launchcontrolXlSetLedMsg.(buttonsLedSysexOffset + i, 29)) },
			3.1, {~toLaunchControlXl.sysex(~launchcontrolXlSetLedMsg.(buttonsLedSysexOffset + i, 13))  },
		);
	};
};

~launchControlXlUpdateBottomLEDs.value;



"setting up Device, Mute, Solo, Record buttons LEDs on launchControlXl".postln;

~launchControlXlDMSRButtons = 0!4;

~launchControlXlUpdateDMSRButtons = {
	4.do { |i|
		var buttonsLedSysexOffset = 40;

		switch (~launchControlXlDMSRButtons[i],
			0, { ~toLaunchControlXl.sysex(~launchcontrolXlSetLedMsg.(buttonsLedSysexOffset + i, 0)) },
			1, { ~toLaunchControlXl.sysex(~launchcontrolXlSetLedMsg.(buttonsLedSysexOffset + i, 62)) },
			1.1, { ~toLaunchControlXl.sysex(~launchcontrolXlSetLedMsg.(buttonsLedSysexOffset + i, 29)) },
		);
	};
};

~launchControlXlUpdateDMSRButtons.value;



"setting up select button LEDs on launchControlXl".postln;

~launchControlXlSelectButtons = 0!4;

~launchControlXlUpdateSelectButtons = {
	4.do { |i|
		var buttonsLedSysexOffset = 44;

		switch (~launchControlXlSelectButtons[i],
			0, { ~toLaunchControlXl.sysex(~launchcontrolXlSetLedMsg.(buttonsLedSysexOffset + i, 0)) },
			1, { ~toLaunchControlXl.sysex(~launchcontrolXlSetLedMsg.(buttonsLedSysexOffset + i, 127)) },
			1.1, { ~toLaunchControlXl.sysex(~launchcontrolXlSetLedMsg.(buttonsLedSysexOffset + i, 62)) },
		);
	};
};

~launchControlXlUpdateSelectButtons.value;



"creating event triggers on launchControlXl Device, Mute, Solo, Record buttons".postln;

MIDIdef.noteOn(\dmsrButtons, {
	|val, num|
	var buttonsOffset = 105;
	var buttonID = num - buttonsOffset;

	"".postln;

	switch (~launchControlXlDMSRButtons[buttonID],
		0, { ~launchControlXlDMSRButtons.put(buttonID, 1);
			("dmsr button " ++ buttonID ++ " on").postln;
		},
		1, { ~launchControlXlDMSRButtons.put(buttonID, 0);
			("dmsr button " ++ buttonID ++ " off").postln; },
	);

	~launchControlXlUpdateDMSRButtons.value;
}).permanent_(true);



"creating event triggers on launchControlXl select buttons".postln;

MIDIdef.cc(\selectButtons, {
	|val, num|
	var buttonsOffset = 104;
	var buttonID = num - buttonsOffset;

	switch (val,
		127, {
			"".postln;
			switch (~launchControlXlSelectButtons[buttonID],
				0, { ~launchControlXlSelectButtons.put(buttonID, 1);
					("select button " ++ buttonID ++ " on").postln;
				},
				1, { ~launchControlXlSelectButtons.put(buttonID, 0);
					("select button " ++ buttonID ++ " off").postln; },
			);

	});

	~launchControlXlUpdateSelectButtons.value;
}).permanent_(true);



"creating event triggers on launchControlXl buttons".postln;

~launchControlXlButton;
~launchControlXlButtonStates = 0!8;

MIDIdef.noteOn(\launchControlButtons, {
	|val, num|

	case
	{(num >= 41) && (num <=48)}{
		~launchControlXlBank = num - buttonMidiNoteoffsetRow1;
		"lcXl_bank: ".post;
		(~launchControlXlBank+1).postln;

		if ( ~launchControlXlBank.isNil.not ) {
			~launchControlEvents["launchControlXlEvent_%".format((~launchControlXlBank + 1)).asSymbol.postln;].value;

		};

		8.do({|i|
			~toLaunchControlXl.noteOn(0, (buttonMidiNoteoffsetRow1 + i), 12);
		});
		~toLaunchControlXl.noteOn(0, num, 63); //bernstein hell

		~launchControlXlUpdateKnobLEDs.value;
		~launchControlXlUpdateBottomLEDs.value;
		~launchControlXlUpdateSelectButtons.value;

	}
	{(num >= 73) && (num <=80)}	{
		~launchControlXlButton = num - buttonMidiNoteoffsetRow2;

		~launchControlXlButtonStates.put(~launchControlXlButton, 1);

		"lcXl_button: ".post;
		(~launchControlXlButton + 1).postln;

		if ( ((~launchControlXlBank.isNil || ~launchControlXlButton.isNil).not ) || ((num >= 41) && (num <=48)) )
		{~launchControlEvents["launchControlXlEvent_%_%".format((~launchControlXlBank + 1),
			(~launchControlXlButton + 1)).asSymbol.postln;].value;};

		~launchControlXlUpdateKnobLEDs.value;
		~launchControlXlUpdateBottomLEDs.value;
		~launchControlXlUpdateSelectButtons.value;
	}
	{true} {nil};
}).permanent_(true);

MIDIdef.noteOff(\launchControlButtonsOff, {
	|val, num|

	if ((num >= 73) && (num <= 80)){
		~launchControlXlButton = num - buttonMidiNoteoffsetRow2;

		~launchControlXlButtonStates.put(~launchControlXlButton, 0);

		if ( ((~launchControlXlBank.isNil || ~launchControlXlButton.isNil).not ) || ((num >= 41) && (num <=48)) )
		{~launchControlEvents["launchControlXlNoteOffEvent_%_%".format((~launchControlXlBank + 1),
			(~launchControlXlButton + 1)).asSymbol.postln;].value;};

		~launchControlXlUpdateKnobLEDs.value;
		~launchControlXlUpdateBottomLEDs.value;
		~launchControlXlUpdateSelectButtons.value;
	}
	{true} {nil};
}).permanent_(true);




// MIDIdef.cc('knob-1a',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[0].getnSynchronous(4)[0];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[0].setAt(0, knob_val);
// 	~osc_data_params['knob-1a'] = knob_val;
// },knobRow1Offset + 0).permanent_(true);
//
//
// MIDIdef.cc('knob-2a',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[1].getnSynchronous(4)[0];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[1].setAt(0, knob_val);
// 	~osc_data_params['knob-2a'] = knob_val;
// },knobRow1Offset + 1).permanent_(true);
//
//
// MIDIdef.cc('knob-3a',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[2].getnSynchronous(4)[0];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[2].setAt(0, knob_val);
// 	~osc_data_params['knob-3a'] = knob_val;
// },knobRow1Offset + 2).permanent_(true);
//
//
// MIDIdef.cc('knob-4a',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[3].getnSynchronous(4)[0];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[3].setAt(0, knob_val);
// 	~osc_data_params['knob-4a'] = knob_val;
// },knobRow1Offset + 3).permanent_(true);
//
//
// MIDIdef.cc('knob-5a',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[4].getnSynchronous(4)[0];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[4].setAt(0, knob_val);
// 	~osc_data_params['knob-5a'] = knob_val;
// },knobRow1Offset + 4).permanent_(true);
//
//
// MIDIdef.cc('knob-6a',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[5].getnSynchronous(4)[0];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[5].setAt(0, knob_val);
// 	~osc_data_params['knob-6a'] = knob_val;
// },knobRow1Offset + 5).permanent_(true);
//
//
// MIDIdef.cc('knob-7a',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[6].getnSynchronous(4)[0];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[6].setAt(0, knob_val);
// 	~osc_data_params['knob-7a'] = knob_val;
// },knobRow1Offset + 6).permanent_(true);
//
//
// MIDIdef.cc('knob-8a',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[7].getnSynchronous(4)[0];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[7].setAt(0, knob_val);
// 	~osc_data_params['knob-8a'] = knob_val;
// },knobRow1Offset + 7).permanent_(true);
//
//
//
// //b knobs
//
// MIDIdef.cc('knob-1b',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[0].getnSynchronous(4)[1];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[0].setAt(1, knob_val);
// 	~osc_data_params['knob-1b'] = knob_val;
// },knobRow2Offset + 0).permanent_(true);
//
//
// MIDIdef.cc('knob-2b',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[1].getnSynchronous(4)[1];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[1].setAt(1, knob_val);
// 	~osc_data_params['knob-2b'] = knob_val;
// },knobRow2Offset + 1).permanent_(true);
//
//
// MIDIdef.cc('knob-3b',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[2].getnSynchronous(4)[1];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[2].setAt(1, knob_val);
// 	~osc_data_params['knob-3b'] = knob_val;
// },knobRow2Offset + 2).permanent_(true);
//
//
// MIDIdef.cc('knob-4b',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[3].getnSynchronous(4)[1];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[3].setAt(1, knob_val);
// 	~osc_data_params['knob-4b'] = knob_val;
// },knobRow2Offset + 3).permanent_(true);
//
//
// MIDIdef.cc('knob-5b',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[4].getnSynchronous(4)[1];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[4].setAt(1, knob_val);
// 	~osc_data_params['knob-5b'] = knob_val;
// },knobRow2Offset + 4).permanent_(true);
//
//
// MIDIdef.cc('knob-6b',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[5].getnSynchronous(4)[1];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[5].setAt(1, knob_val);
// 	~osc_data_params['knob-6b'] = knob_val;
// },knobRow2Offset + 5).permanent_(true);
//
//
// MIDIdef.cc('knob-7b',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[6].getnSynchronous(4)[1];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[6].setAt(1, knob_val);
// 	~osc_data_params['knob-7b'] = knob_val;
// },knobRow2Offset + 6).permanent_(true);
//
//
// MIDIdef.cc('knob-8b',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[7].getnSynchronous(4)[1];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[7].setAt(1, knob_val);
// 	~osc_data_params['knob-8b'] = knob_val;
// },knobRow2Offset + 7).permanent_(true);
//
//
//
//
// //c knobs
//
// MIDIdef.cc('knob-1c',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[0].getnSynchronous(4)[2];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[0].setAt(2, knob_val);
// 	~osc_data_params['knob-1c'] = knob_val;
// },knobRow3Offset + 0).permanent_(true);
//
//
// MIDIdef.cc('knob-2c',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[1].getnSynchronous(4)[2];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[1].setAt(2, knob_val);
// 	~osc_data_params['knob-2c'] = knob_val;
// },knobRow3Offset + 1).permanent_(true);
//
//
// MIDIdef.cc('knob-3c',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[2].getnSynchronous(4)[2];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[2].setAt(2, knob_val);
// 	~osc_data_params['knob-3c'] = knob_val;
// },knobRow3Offset + 2).permanent_(true);
//
//
// MIDIdef.cc('knob-4c',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[3].getnSynchronous(4)[2];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[3].setAt(2, knob_val);
// 	~osc_data_params['knob-4c'] = knob_val;
// },knobRow3Offset + 3).permanent_(true);
//
//
// MIDIdef.cc('knob-5c',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[4].getnSynchronous(4)[2];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[4].setAt(2, knob_val);
// 	~osc_data_params['knob-5c'] = knob_val;
// },knobRow3Offset + 4).permanent_(true);
//
//
// MIDIdef.cc('knob-6c',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[5].getnSynchronous(4)[2];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[5].setAt(2, knob_val);
// 	~osc_data_params['knob-6c'] = knob_val;
// },knobRow3Offset + 5).permanent_(true);
//
//
// MIDIdef.cc('knob-7c',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[6].getnSynchronous(4)[2];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[6].setAt(2, knob_val);
// 	~osc_data_params['knob-7c'] = knob_val;
// },knobRow3Offset + 6).permanent_(true);
//
//
// MIDIdef.cc('knob-8c',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[7].getnSynchronous(4)[2];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[7].setAt(2, knob_val);
// 	~osc_data_params['knob-8c'] = knob_val;
// },knobRow3Offset + 7).permanent_(true);
//
//
//
// //faders
//
// MIDIdef.cc('fader-1',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[0].getnSynchronous(4)[3];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[0].setAt(3, knob_val);
// 	~osc_data_params['fader-1'] = knob_val;
// },faderOffset + 0).permanent_(true);
//
//
// MIDIdef.cc('fader-2',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[1].getnSynchronous(4)[3];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[1].setAt(3, knob_val);
// 	~osc_data_params['fader-2'] = knob_val;
// },faderOffset + 1).permanent_(true);
//
//
// MIDIdef.cc('fader-3',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[2].getnSynchronous(4)[3];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[2].setAt(3, knob_val);
// 	~osc_data_params['fader-3'] = knob_val;
// },faderOffset + 2).permanent_(true);
//
//
// MIDIdef.cc('fader-4',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[3].getnSynchronous(4)[3];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[3].setAt(3, knob_val);
// 	~osc_data_params['fader-4'] = knob_val;
// },faderOffset + 3).permanent_(true);
//
//
// MIDIdef.cc('fader-5',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[4].getnSynchronous(4)[3];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[4].setAt(3, knob_val);
// 	~osc_data_params['fader-5'] = knob_val;
// },faderOffset + 4).permanent_(true);
//
//
// MIDIdef.cc('fader-6',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[5].getnSynchronous(4)[3];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[5].setAt(3, knob_val);
// 	~osc_data_params['fader-6'] = knob_val;
// },faderOffset + 5).permanent_(true);
//
//
// MIDIdef.cc('fader-7',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[6].getnSynchronous(4)[3];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[6].setAt(3, knob_val);
// 	~osc_data_params['fader-7'] = knob_val;
// },faderOffset + 6).permanent_(true);
//
//
// MIDIdef.cc('fader-8',{
// 	arg val, nr, src;
// 	var knob_val = val.linlin(1,127,0,1);
// 	var oldVal = row_busses[7].getnSynchronous(4)[3];
// 	knob_val = gradualPot.(oldVal, knob_val);
// 	row_busses[7].setAt(3, knob_val);
// 	~osc_data_params['fader-8'] = knob_val;
// },faderOffset + 7).permanent_(true);


"launchcontrol xl mididefs loaded".postln;


