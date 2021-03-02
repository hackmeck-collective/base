l = LinkClock.new().permanent_(true).enableMeterSync;

// dict for everything regarding the lsys
~lsys = ();
~lsys.list = List.new;
~lsys.argsList = List.new;
// how is the new lsys integrated
~lsys.integration = \replace; // \add nil
~lsys.useLastPitch = false; // geht das ueberhaupt?
~lsys.lastPitch = 0;

//
~gui = ();
~gui.points = List.new;
~gui.scale = 10;
~gui.lastPoints = ();

~ctl = (
	baseTempo: 1/4,
	legatoArr: 0.95!10,
	amp: 0.1,
	scale: Scale.harmonicMinor,
	branchInterval: 7,//7,
	stepInterval: 1,
	noteOffset: 48,
	wrapLo: 36!10,
	wrapHi: 96!10,
	vols: 1!10,
	theta: 51.45,
	quant: 4,
	instrument: [\default],
	presetName: \variedPlucks
	//setInstrument: [\simple_modes_synth_1, \sine_OD_1, \wavetable_1] ++ (\fm_1 ! 7) // fuer benni
);

// these parameters may change everytime a lsys starts again
Pbindef(\opts,
	\baseTempo, 1/4,
	\durCalc, \waitAll,	/*
	quantisation option for the whole lsys. \waitAll waits for all branches to finish
	\waitRoot waits only for root to finish
	*/
);

if(~localSetup){
	~targetServer = Server.default;
	~gui.toProcessing = NetAddr("127.0.0.1", 12000);
}{
	~addrBook = AddrBook.new;
	~addrBook.addMe;
	~hail = Hail.new(~addrBook);
	~synthDescRel = SynthDescRelay(~addrBook);

	{
		block {|break|
			inf.do {
				1.wait;
				("utopia peers: " ++ ~addrBook.names).postln;
				if(~addrBook.names.includes(\Philipp) && ~addrBook.names.includes(\Benni)){ //

					//~gui.toProcessing = NetAddr("127.0.0.1", 12000);
					~gui.toProcessing = NetAddr(~addrBook.at(\Philipp).addr.ip, 12000);

					~objSpace_philipp = OSCObjectSpace(~addrBook, oscPath:'/pitches');
					~objSpace_philipp.addDependant({|objectSpace, what, key, val|
						~ctl.scale = 4.collect { |i| ~objSpace_philipp[\pitches] + (i * 12) }.flat.sort;
						//~ctl.branchInterval = ~ctl.scale.size;
					});

					~targetServer = Server.remote(
						\benni,
						NetAddr(~addrBook.at(\Benni).addr.ip, 57110),
						ServerOptions.new().maxLogins_(2),
						1
					);
					// ~targetServer.latency = 0.5;

					~presets_benni = OSCObjectSpace(~addrBook, oscPath:'/instrumentPresets').acceptEvents_(true);
					~objSpace_benni = OSCObjectSpace(~addrBook, oscPath:'/params').acceptEvents_(true);
					~objSpace_benni.addDependant({|objectSpace, what, key, val|
						~ctl[key] = ~objSpace_benni[key];
					});
					break.value;
				};
			};
		};


	}.fork

};

