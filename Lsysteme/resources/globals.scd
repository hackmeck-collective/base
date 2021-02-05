l = LinkClock.new(1).permanent_(true);

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
	legatoArr: 0.95!10,
	amp: 0.1,
	scale: Scale.harmonicMinor,
	branchInterval: 7,
	stepInterval: 1,
	noteOffset: -7,
	wrapLo: 36!10,
	wrapHi: 96!10,
	vols: 1!10,
	theta: 51.45,
	instrument: \default,
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
	var checkConnection = Condition.new;
	~addrBook = AddrBook.new;
	~addrBook.addMe;
	~hail = Hail.new(~addrBook);
	block {|break|
		{
			inf.do {
				1.wait;
				("utopia peers: " ++ ~addrBook.names).postln;
				if(~addrBook.names.includes(\Philipp) && ~addrBook.names.includes(\Benni)){
					checkConnection.unhang;
					break.value;
				};
			};
			checkConnection.hang;

			~gui.toProcessing = NetAddr(~addrBook.at(\Philipp).addr.ip, 12000);

			~objSpace_philipp = OSCObjectSpace(~addrBook, oscPath:'/data');
			~objSpace_philipp.addDependant({|objectSpace, what, key, val|
				~ctl.scale = Scale.new(~objSpace_philipp[\data]);
				~ctl.branchInterval = ~ctl.scale.size;
			});

			~targetServer = Server(
				\benni,
				NetAddr(~addrBook.at(\Benni).addr.ip, 57110),
				ServerOptions.new().maxLogins_(4),
				1
			);

			~objSpace_benni = OSCObjectSpace(~addrBook, oscPath:'/params');
			~objSpace_benni.addDependant({|objectSpace, what, key, val|
				if(key == \sourceGroup){
					~ctl.group = ~objSpace_benni[\sourceGroup];
				}
			});

		}.fork
	};
};

