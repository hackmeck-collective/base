MIDIdef.cc('knob-1b',{
	arg val, nr, src;
	row_1_bus.setAt(1, val.linexp(1,127,0.001,1));
},knob_b_start).permanent_(true);

8.do { |i|
"
MIDIdef.cc('%',{
	arg val, nr, src;
	var knob_val = val.linexp(1,127,0.001,1);
row_%_bus.setAt(1, knob_val);
	~osc_data_params['%'] = knob_val;
},knob_b_start + %).permanent_(true);
".format("knob-" ++ (i+1) ++ "b", (i+1),"knob-" ++ (i+1) ++ "b", i).postln
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