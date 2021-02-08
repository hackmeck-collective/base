MIDIdef.cc('knob-1b',{
	arg val, nr, src;
	row_1_bus.setAt(1, val.linexp(1,127,0.001,1));
},knob_b_start).permanent_(true);

	var oldVal = row_busses[1].getnSynchronous(4)[1];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[1].setAt(0, knob_val);

8.do { |i|
"
MIDIdef.cc('%',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[%].getnSynchronous(4)[0];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[%].setAt(0, knob_val);
	~osc_data_params['%'] = knob_val;
},knob_a_start + %).permanent_(true);
".format("knob-" ++ (i+1) ++ "a",
		i,
		i,
		"knob-" ++ (i+1) ++ "a",
		i).postln
}

8.do { |i|
"
MIDIdef.cc('%',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[%].getnSynchronous(4)[1];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[%].setAt(1, knob_val);
	~osc_data_params['%'] = knob_val;
},knob_b_start + %).permanent_(true);
".format("knob-" ++ (i+1) ++ "b",
		i,
		i,
		"knob-" ++ (i+1) ++ "b",
		i).postln
}

8.do { |i|
"
MIDIdef.cc('%',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[%].getnSynchronous(4)[2];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[%].setAt(2, knob_val);
	~osc_data_params['%'] = knob_val;
},knob_c_start + %).permanent_(true);
".format("knob-" ++ (i+1) ++ "c",
		i,
		i,
		"knob-" ++ (i+1) ++ "c",
		i).postln
}

8.do { |i|
"
MIDIdef.cc('%',{
	arg val, nr, src;
	var knob_val = val.linlin(1,127,0,1);
	var oldVal = row_busses[%].getnSynchronous(4)[3];
	knob_val = gradualPot.(oldVal, knob_val);
	row_busses[%].setAt(3, knob_val);
	~osc_data_params['%'] = knob_val;
},fader_start + %).permanent_(true);
".format("fader-" ++ (i+1),
		i,
		i,
		"fader-" ++ (i+1),
		i).postln
}



8.do { |i|
"
MIDIdef.cc('%',{
	arg val, nr, src;
	var knob_val = val.linexp(1,127,0.001,1);
row_%_bus.setAt(2, knob_val);
	~osc_data_params['%'] = knob_val;
},knob_c_start + %).permanent_(true);
".format("knob-" ++ (i+1) ++ "c", (i+1),"knob-" ++ (i+1) ++ "c", i).postln
}


MIDIdef.cc('fader-1',{
	arg val, nr, src;
	row_1_bus.setAt(3, val.linexp(1,127,0.001,1));
},fader_start).permanent_(true);

8.do { |i|
"
MIDIdef.cc('%',{
	arg val, nr, src;
	var knob_val = val.linexp(1,127,0.001,1);
row_%_bus.setAt(3, knob_val);
	~osc_data_params['%'] = knob_val;
},fader_start + %).permanent_(true);
".format("fader-" ++ (i+1), (i+1),"fader-" ++ (i+1), i).postln
}