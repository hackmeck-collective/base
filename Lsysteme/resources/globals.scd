// dict for everything regarding the lsys
//~lsys = ();
~lsys[\globalPitch] = 0;
~lsys[\globalPitchBalance] = 0;
~lsys[\presets] = ();
~lsys[\defaultPreset] = (
	baseTempo: 1/4,
	legatoArr: 1,
	branchInterval: 7,//7,
	stepInterval: 1,
	noteOffset: 0,
	wrapLo: 24,
	wrapHi: 108,
	vols: 1,
	theta: 51.45,
	quant: 4,
	maxPatDur: 36,
	instr: \simplePluck,
	useGlobalPitch: false,
	stutterVal: 1,
	lerpLines: false,
	baseColor: 0,
	ignorePoints: false
);

~lsys[\currentlyPlaying] = Set.new;

//
~gui = ();
~gui.points = List.new;
~gui.scale = 20;
~gui.lastPoints = ();
~gui.lastPoints[\rootPoint] = Point();

if(~localSetup){
	~targetServer = Server.default;
	~gui.toProcessing = NetAddr("127.0.0.1", 12000);
}{
	block {|break|
		inf.do {
			1.wait;
			("utopia peers: " ++ ~addrBook.names).postln;
			if(~addrBook.names.includes(\Admin)){ //~addrBook.names.includes(\Philipp) &&
				//~addrBook.names.includes(\philipp) &&
				//~gui.toProcessing = NetAddr("127.0.0.1", 12000);
				~gui.toProcessing = NetAddr(~addrBook.at(\vincent).addr.ip, 12000);
				~toOpenStageControl = NetAddr(~addrBook.at(\vincent).addr.ip, 8080);

				/*~targetServer = Server.remote(
				\benni,
				NetAddr(~addrBook.at(\Admin).addr.ip, 57110),
				ServerOptions.new().maxLogins_(2),
				1
				);*/
				~targetServer = Server.default;

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
				break.value;
			};
		};
	};

};

Pdef(\playVisuals,
	Pbind(
		\draw, Pfunc { |ev|
			if(ev.dur.isRest.not){
				if((ev.checkPause.class != Rest) || (ev.legato >= 1)){
					if(ev.branchLevel.notNil){
						//("branchLEVEL: " ++ ev.branchLevel).postln;
						~gui.points.add([
							ev.calcPoint,
							ev.branchLevel.linlin(0,5,0,1).asFloat,
							ev.vol.asFloat ? 1.0,
							ev.baseColor,
							(~linkClock.tempo/ ev.dur),
							ev.lerpLines.asInteger
						]);
					}
				};
			};
			0
		}
	) <>
	Pdef(\play) <>
	PtimeClutch(
		Pbind(\sendToGui, Pfunc {
			if(~gui.points.isEmpty.not){
				~gui.points.do { |p|
					var wp1 = (p[0][0]) * ~gui.scale,  // ~win.bounds.bottom/2 oder so
					wp2 = (p[0][1]) * ~gui.scale,
					oscMsg = (wp1.asArray ++ wp2.asArray).asInteger ++ p[1..];
					{~gui.toProcessing.sendMsg('/lines', *oscMsg)}.defer(~targetServer.latency - 0.19) // damit es mit server latency zusammen kommt
				};
				~gui.points.clear;
			};
			0
		})
	)
);


thisProcess.openUDPPort(9010);
