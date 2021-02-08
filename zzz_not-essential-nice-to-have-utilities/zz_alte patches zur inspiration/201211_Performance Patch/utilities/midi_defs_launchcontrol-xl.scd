(

var knob_a_start = 13,
knob_b_start = 29,
knob_c_start = 49,
fader_start = 77;
var row_busses = Array.newClear(8);

var gradualPot = { |oldVal newVal|
	var diff = newVal - oldVal;
	oldVal + (diff * diff.lincurve(0.1,0.9,1,0.5,-2));
};

~switchRows = { arg presetName;
	var presets = (

		pr1: [
			~bd_808_1_controlbus,
			~clicks_1_controlbus,
			~combo_controlbus,
			~rect_controlbus,
			~saw_controlbus,
			~sine_OD_controlbus,
			~reverb_controlbus,
			~mixer_controlbus
		],

		pr2: [
			~bd_808_1_controlbus,
			~clicks_1_controlbus,
			~fm_vib_controlbus,
			~granular_1_controlbus,
			~wavetable_1_controlbus,
			~synchronus_grains_1_controlbus,
			~reverb_controlbus,
			~mixer_controlbus
		],

		pr3: [
			~row1_controlbus,
			~row2_controlbus,
			~row3_controlbus,
			~row4_controlbus,
			~row5_controlbus,
			~row6_controlbus,
			~reverb_controlbus,
			~mixer_controlbus
		],
	);

	8.do { arg index;
		row_busses[index] = presets[presetName][index];
		presets[presetName][index].postln
	};
};

~switchRows.(\pr3);


MIDIdef.cc('knob-1a',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[0].getnSynchronous(4)[0];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[0].setAt(0, knob_val);
	~osc_data_params['knob-1a'] = knob_val;
},knob_a_start + 0).permanent_(true);


MIDIdef.cc('knob-2a',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[1].getnSynchronous(4)[0];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[1].setAt(0, knob_val);
	~osc_data_params['knob-2a'] = knob_val;
},knob_a_start + 1).permanent_(true);


MIDIdef.cc('knob-3a',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[2].getnSynchronous(4)[0];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[2].setAt(0, knob_val);
	~osc_data_params['knob-3a'] = knob_val;
},knob_a_start + 2).permanent_(true);


MIDIdef.cc('knob-4a',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[3].getnSynchronous(4)[0];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[3].setAt(0, knob_val);
	~osc_data_params['knob-4a'] = knob_val;
},knob_a_start + 3).permanent_(true);


MIDIdef.cc('knob-5a',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[4].getnSynchronous(4)[0];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[4].setAt(0, knob_val);
	~osc_data_params['knob-5a'] = knob_val;
},knob_a_start + 4).permanent_(true);


MIDIdef.cc('knob-6a',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[5].getnSynchronous(4)[0];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[5].setAt(0, knob_val);
	~osc_data_params['knob-6a'] = knob_val;
},knob_a_start + 5).permanent_(true);


MIDIdef.cc('knob-7a',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[6].getnSynchronous(4)[0];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[6].setAt(0, knob_val);
	~osc_data_params['knob-7a'] = knob_val;
},knob_a_start + 6).permanent_(true);


MIDIdef.cc('knob-8a',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[7].getnSynchronous(4)[0];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[7].setAt(0, knob_val);
	~osc_data_params['knob-8a'] = knob_val;
},knob_a_start + 7).permanent_(true);



//b knobs

MIDIdef.cc('knob-1b',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[0].getnSynchronous(4)[1];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[0].setAt(1, knob_val);
	~osc_data_params['knob-1b'] = knob_val;
},knob_b_start + 0).permanent_(true);


MIDIdef.cc('knob-2b',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[1].getnSynchronous(4)[1];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[1].setAt(1, knob_val);
	~osc_data_params['knob-2b'] = knob_val;
},knob_b_start + 1).permanent_(true);


MIDIdef.cc('knob-3b',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[2].getnSynchronous(4)[1];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[2].setAt(1, knob_val);
	~osc_data_params['knob-3b'] = knob_val;
},knob_b_start + 2).permanent_(true);


MIDIdef.cc('knob-4b',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[3].getnSynchronous(4)[1];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[3].setAt(1, knob_val);
	~osc_data_params['knob-4b'] = knob_val;
},knob_b_start + 3).permanent_(true);


MIDIdef.cc('knob-5b',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[4].getnSynchronous(4)[1];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[4].setAt(1, knob_val);
	~osc_data_params['knob-5b'] = knob_val;
},knob_b_start + 4).permanent_(true);


MIDIdef.cc('knob-6b',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[5].getnSynchronous(4)[1];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[5].setAt(1, knob_val);
	~osc_data_params['knob-6b'] = knob_val;
},knob_b_start + 5).permanent_(true);


MIDIdef.cc('knob-7b',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[6].getnSynchronous(4)[1];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[6].setAt(1, knob_val);
	~osc_data_params['knob-7b'] = knob_val;
},knob_b_start + 6).permanent_(true);


MIDIdef.cc('knob-8b',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[7].getnSynchronous(4)[1];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[7].setAt(1, knob_val);
	~osc_data_params['knob-8b'] = knob_val;
},knob_b_start + 7).permanent_(true);




//c knobs

MIDIdef.cc('knob-1c',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[0].getnSynchronous(4)[2];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[0].setAt(2, knob_val);
	~osc_data_params['knob-1c'] = knob_val;
},knob_c_start + 0).permanent_(true);


MIDIdef.cc('knob-2c',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[1].getnSynchronous(4)[2];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[1].setAt(2, knob_val);
	~osc_data_params['knob-2c'] = knob_val;
},knob_c_start + 1).permanent_(true);


MIDIdef.cc('knob-3c',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[2].getnSynchronous(4)[2];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[2].setAt(2, knob_val);
	~osc_data_params['knob-3c'] = knob_val;
},knob_c_start + 2).permanent_(true);


MIDIdef.cc('knob-4c',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[3].getnSynchronous(4)[2];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[3].setAt(2, knob_val);
	~osc_data_params['knob-4c'] = knob_val;
},knob_c_start + 3).permanent_(true);


MIDIdef.cc('knob-5c',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[4].getnSynchronous(4)[2];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[4].setAt(2, knob_val);
	~osc_data_params['knob-5c'] = knob_val;
},knob_c_start + 4).permanent_(true);


MIDIdef.cc('knob-6c',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[5].getnSynchronous(4)[2];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[5].setAt(2, knob_val);
	~osc_data_params['knob-6c'] = knob_val;
},knob_c_start + 5).permanent_(true);


MIDIdef.cc('knob-7c',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[6].getnSynchronous(4)[2];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[6].setAt(2, knob_val);
	~osc_data_params['knob-7c'] = knob_val;
},knob_c_start + 6).permanent_(true);


MIDIdef.cc('knob-8c',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[7].getnSynchronous(4)[2];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[7].setAt(2, knob_val);
	~osc_data_params['knob-8c'] = knob_val;
},knob_c_start + 7).permanent_(true);



//faders

MIDIdef.cc('fader-1',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[0].getnSynchronous(4)[3];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[0].setAt(3, knob_val);
	~osc_data_params['fader-1'] = knob_val;
},fader_start + 0).permanent_(true);


MIDIdef.cc('fader-2',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[1].getnSynchronous(4)[3];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[1].setAt(3, knob_val);
	~osc_data_params['fader-2'] = knob_val;
},fader_start + 1).permanent_(true);


MIDIdef.cc('fader-3',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[2].getnSynchronous(4)[3];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[2].setAt(3, knob_val);
	~osc_data_params['fader-3'] = knob_val;
},fader_start + 2).permanent_(true);


MIDIdef.cc('fader-4',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[3].getnSynchronous(4)[3];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[3].setAt(3, knob_val);
	~osc_data_params['fader-4'] = knob_val;
},fader_start + 3).permanent_(true);


MIDIdef.cc('fader-5',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[4].getnSynchronous(4)[3];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[4].setAt(3, knob_val);
	~osc_data_params['fader-5'] = knob_val;
},fader_start + 4).permanent_(true);


MIDIdef.cc('fader-6',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[5].getnSynchronous(4)[3];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[5].setAt(3, knob_val);
	~osc_data_params['fader-6'] = knob_val;
},fader_start + 5).permanent_(true);


MIDIdef.cc('fader-7',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[6].getnSynchronous(4)[3];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[6].setAt(3, knob_val);
	~osc_data_params['fader-7'] = knob_val;
},fader_start + 6).permanent_(true);


MIDIdef.cc('fader-8',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[7].getnSynchronous(4)[3];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[7].setAt(3, knob_val);
	~osc_data_params['fader-8'] = knob_val;
},fader_start + 7).permanent_(true);


"launchcontrol mididefs loaded".postln;

)

