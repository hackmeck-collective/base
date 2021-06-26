~toOpenStageControl = NetAddr("127.0.0.1", 8080);
~lsys.addDependant({|objectSpace, what, key, val|
	if(key == \currentlyPlaying){
		var namesArr = objectSpace[\currentlyPlaying].asArray;
		5.do {|i|
			if(i < namesArr.size){
				topEnvironment[\toOpenStageControl].sendMsg("/text_" ++ (i + 1), namesArr[i])
			}{
				topEnvironment[\toOpenStageControl].sendMsg("/text_" ++ (i + 1), "")
			}
		}
	};
});

thisProcess.openUDPPort(9010);

~addrBook.at(\Admin)

~volumeAddressesLed = 8.collect {|i| "/volume/led_" ++ (i + 1) };
~legatoAddressesLed = 8.collect {|i| "/legato/led_" ++ (i + 1) };
~volumeAddressesFader = 8.collect {|i| "/volume/fader_" ++ (i + 1) };
~legatoAddressesFader = 8.collect {|i| "/legato/fader_" ++ (i + 1) };


5.do {|i|
	var addr = "/select_lsys_" ++ (i + 1);
	OSCdef(addr.asSymbol, {|msg|
		var selectedVolumeArr, selectedLegatoArr;
		~selectedLsys = ~lsys[\currentlyPlaying].asArray[msg[1] - 1].postln;
		~toOpenStageControl.sendMsg("/selected_lsys", ~selectedLsys);
		selectedVolumeArr = ~lsys[~selectedLsys.asSymbol].vols;
		selectedLegatoArr = ~lsys[~selectedLsys.asSymbol].legatoArr;
		8.do { |ix|
			if(ix < selectedVolumeArr.size){
				~toOpenStageControl.sendMsg(~volumeAddressesLed[ix], 1);
				~toOpenStageControl.sendMsg(~volumeAddressesFader[ix], selectedVolumeArr[ix]);
			}{
				~toOpenStageControl.sendMsg(~volumeAddressesLed[ix], 0);
			};
			if(ix < selectedLegatoArr.size){
				~toOpenStageControl.sendMsg(~legatoAddressesFader[ix], selectedLegatoArr[ix]);
				~toOpenStageControl.sendMsg(~legatoAddressesLed[ix], 1);
			}{
				~toOpenStageControl.sendMsg(~legatoAddressesLed[ix], 0);
			};
		};
		if(~lsys[~selectedLsys.asSymbol].stutterVal.isNumber){
			~toOpenStageControl.sendMsg("/stutterVal", ~lsys[~selectedLsys.asSymbol].stutterVal);
		};
		~toOpenStageControl.sendMsg("/stepInterval", ~lsys[~selectedLsys.asSymbol].stepInterval);
		~toOpenStageControl.sendMsg("/branchInterval", ~lsys[~selectedLsys.asSymbol].branchInterval);

	}, addr).permanent_(true)
};

~volumeAddressesFader.do {|addr, ix|
	OSCdef(addr.asSymbol, {|msg|
		~lsys[~selectedLsys.asSymbol].vols[ix] = msg[1];
		~lsys[~selectedLsys.asSymbol] = ~lsys[~selectedLsys.asSymbol];
	}, addr).permanent_(true)
};

~legatoAddressesFader.do {|addr, ix|
	OSCdef(addr.asSymbol, {|msg|
		~lsys[~selectedLsys.asSymbol].legatoArr[ix] = msg[1];
		~lsys[~selectedLsys.asSymbol] = ~lsys[~selectedLsys.asSymbol];
	}, addr).permanent_(true)
};

OSCdef(\stutterVal, {|msg|
	~lsys[~selectedLsys.asSymbol].stutterVal = msg[1];
	~lsys[~selectedLsys.asSymbol] = ~lsys[~selectedLsys.asSymbol];
}, '/stutterVal').permanent_(true);

OSCdef(\stepInterval, {|msg|
	~lsys[~selectedLsys.asSymbol].stepInterval = msg[1];
	~lsys[~selectedLsys.asSymbol] = ~lsys[~selectedLsys.asSymbol];
}, '/stepInterval').permanent_(true);

OSCdef(\branchInterval, {|msg|
	~lsys[~selectedLsys.asSymbol].branchInterval = msg[1];
	~lsys[~selectedLsys.asSymbol] = ~lsys[~selectedLsys.asSymbol];
}, '/branchInterval').permanent_(true);