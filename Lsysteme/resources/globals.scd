// dict for everything regarding the lsys
//~lsys = ();
~lsys[\globalPitch] = 0;
~lsys[\globalPitchBalance] = 0;
~lsys[\presets] = ();
~lsys[\defaultPreset] = (
	baseTempo: 1/4,
	legatoArr: 0.95,
	branchInterval: 7,//7,
	stepInterval: 1,
	noteOffset: 0,
	wrapLo: 36,
	wrapHi: 96,
	vols: 1,
	theta: 51.45,
	quant: 4,
	maxPatDur: 36,
	instr: \simplePluck,
	useGlobalPitch: false,
	stutterVal: 1,
	baseColor: 0,
	lineScale: 10
);

//
~gui = ();
~gui.points = List.new;
~gui.scale = 20;
~gui.lastPoints = ();

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
				~gui.toProcessing = NetAddr("127.0.0.1", 12000);
				//~gui.toProcessing = NetAddr(~addrBook.at(\philipp).addr.ip, 12000);

				~targetServer = Server.remote(
					\benni,
					NetAddr(~addrBook.at(\Admin).addr.ip, 57110),
					ServerOptions.new().maxLogins_(2),
					1
				);
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
					("branchLEVEL: " ++ ev.branchLevel).postln;
					~gui.points.add([
						ev.calcPoint,
						ev.branchLevel.linlin(0,5,0,1).asFloat,
						ev.vol.asFloat ? 1.0,
						ev.baseColor,
						ev.lineScale
					]);
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
					var scale = p[4],
					wp1 = (p[0][0]) * ~gui.scale,  // ~win.bounds.bottom/2 oder so
					wp2 = (p[0][1]) * ~gui.scale,
					oscMsg = (wp1.asArray ++ wp2.asArray).asInteger ++ p[1..3];
					{~gui.toProcessing.sendMsg('/lines', *oscMsg)}.defer(~targetServer.latency - 0.2) // damit es mit server latency zusammen kommt
				};
				~gui.points.clear;
			};
			0
		})
	)
);
