// ~linkClock = ~linkClock ?? { LinkClock.new().permanent_(true).enableMeterSync};

// dict for everything regarding the lsys
~lsys = ();
~lsys.globalPitch = 0;
~lsys.globalPitchBalance = 0;
~lsys.presets = ();
~lsys.defaultPreset = (
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
	philippOctaves: 4,
	maxPatDur: 36,
	instr: \simplePluck,
	useGlobalPitch: true,
	mute: 1,
	stutterVal: 1
);

~philipp_pitches = Scale.harmonicMinor;

//
~gui = ();
~gui.points = List.new;
~gui.scale = 10;
~gui.lastPoints = ();

/*~addrBook = AddrBook.new;
~addrBook.addMe;
~hail = Hail.new(~addrBook);
~synthDescRel = SynthDescRelay(~addrBook);
~instrumentPresetsDictionary = OSCObjectSpace(~addrBook, oscPath:'/instrumentPresets').acceptEvents_(true);
~routing = OSCObjectSpace(~addrBook, oscPath:'/routing').acceptEvents_(true);*/

if(~localSetup){
	~targetServer = Server.default;
	~gui.toProcessing = NetAddr("127.0.0.1", 12000);
}{
	block {|break|
		inf.do {
			1.wait;
			("utopia peers: " ++ ~addrBook.names).postln;
			if(~addrBook.names.includes(\Admin)){ //~addrBook.names.includes(\Philipp) &&

				 ~gui.toProcessing = NetAddr("127.0.0.1", 12000);
				//~gui.toProcessing = NetAddr(~addrBook.at(\Philipp).addr.ip, 12000);

				~objSpace_philipp = OSCObjectSpace(~addrBook, oscPath:'/pitches').acceptEvents_(true);
				~objSpace_philipp.addDependant({|objectSpace, what, key, val|
					if(key == \pitches){
						~philipp_pitches = Scale.new(val.mod(12))
					};
					//4.collect { |i| ~objSpace_philipp[\pitches] + (i * 12) }.flat.sort;
					//~ctl.branchInterval = ~ctl.scale.size;
				});

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

// Pdef(\rest, Pbind(\dur, Pn(Rest())));

/*Pdef(\playVisuals,
(
Pdef(\play) <>
Pbind(\getDiff, Pdiff(Pkey(\testCount))) <>
PtimeClutch(Pbind(\testCount, Pseries()))
).collect{|ev|
if(ev.getDiff == 1){
if(~gui.points.isEmpty.not){
~gui.points.do { |p|
var wp1 = (p[0][0]) * ~gui.scale,  // ~win.bounds.bottom/2 oder so
wp2 = (p[0][1]) * ~gui.scale,
branchLevel = p[1],
oscMsg = (wp1.asArray ++ wp2.asArray).asInteger ++ branchLevel;
{~gui.toProcessing.sendMsg('/lines', *oscMsg)}.defer(~targetServer.latency - 0.125) // damit es mit server latency zusammen kommt
};
~gui.points.clear;
};
};
ev
}
);*/


Pdef(\playVisuals,
	Pdef(\play) <>
	PtimeClutch(
		Pbind(\sendToGui, Pfunc {
			if(~gui.points.isEmpty.not){
				~gui.points.do { |p|
					var wp1 = (p[0][0]) * ~gui.scale,  // ~win.bounds.bottom/2 oder so
					wp2 = (p[0][1]) * ~gui.scale,
					branchLevel = p[1],
					oscMsg = (wp1.asArray ++ wp2.asArray).asInteger ++ branchLevel;
					{~gui.toProcessing.sendMsg('/lines', *oscMsg)}.defer(~targetServer.latency - 0.18) // damit es mit server latency zusammen kommt
				};
				~gui.points.clear;
			};
			0
		})
	)
);