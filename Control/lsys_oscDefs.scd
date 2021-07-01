thisProcess.openUDPPort(9010);

/*~selectedLsys = \dummy;
~lsys[\dummy] = ();*/

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
		if(~lsys[\overwriteOnOff].vols.not){
			~lsys[~selectedLsys.asSymbol].vols[ix] = msg[1];
		};
		~lsys[\overwriteValues].vols[ix] = msg[1];
	}, addr).permanent_(true)
};

~legatoAddressesFader.do {|addr, ix|
	OSCdef(addr.asSymbol, {|msg|
		if(~lsys[\overwriteOnOff].legatoArr.not){
			~lsys[~selectedLsys.asSymbol].legatoArr[ix] = msg[1];
		};
		~lsys[\overwriteValues].legatoArr[ix] = msg[1];
	}, addr).permanent_(true)
};

OSCdef(\stutterVal, {|msg|
	if(~lsys[\overwriteOnOff].stutterVal.not){
		~lsys[~selectedLsys.asSymbol].stutterVal = msg[1];
	};
	~lsys[\overwriteValues].stutterVal = msg[1];
}, '/stutterVal').permanent_(true);

OSCdef(\stepInterval, {|msg|
	if(~lsys[\overwriteOnOff].stepInterval.not){
		~lsys[~selectedLsys.asSymbol].stepInterval = msg[1];
	};
	~lsys[\overwriteValues].stepInterval = msg[1];
}, '/stepInterval').permanent_(true);

OSCdef(\branchInterval, {|msg|
	if(~lsys[\overwriteOnOff].branchInterval.not){
		~lsys[~selectedLsys.asSymbol].branchInterval = msg[1];
	};
	~lsys[\overwriteValues].branchInterval = msg[1];
}, '/branchInterval').permanent_(true);

OSCdef(\shuffleArray, {|msg|
	if(~lsys[\overwriteOnOff].shuffleArray.not){
		~lsys[~selectedLsys.asSymbol].shuffleArray = [msg[1], 1 - msg[1]] * 2;
	};
	~lsys[\overwriteValues].shuffleArray = [msg[1], 1 - msg[1]] * 2;
}, '/shuffleArray').permanent_(true);

[
	['/overwriteStutterVal', \stutterVal],
	['/overwriteStepInterval', \stepInterval],
	['/overwriteBranchInterval', \branchInterval],
	['/overwriteVolume', \vols],
	['/overwriteLegato', \legatoArr],
	['/overwriteShuffleArray', \shuffleArray]
].do { |arr|
	OSCdef(arr[0].asSymbol, {|msg|
		~lsys[\overwriteOnOff][arr[1]] = msg[1].asBoolean;
	}, arr[0]).permanent_(true);
};