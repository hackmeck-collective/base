~callPreset = {
	arg instrName;
	var preset = topEnvironment[instrName];
	Pbindef(instrName).clear;
	preset.keysValuesDo { arg keys, values;
		Pbindef(instrName, keys, values)
	};
	Pbindef(instrName,
		\instrument, Pfunc {|ev| ~makeModularDrum.(ev.drumType, ev.fx, ev.filter).asSymbol},
	);
};

