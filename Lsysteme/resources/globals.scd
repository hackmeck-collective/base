~addrBook = AddrBook.new;
~addrBook.addMe;//(Peer(\vincent, NetAddr("192.168.178.28",57120)));
~hail = Hail.new(~addrBook);

~lsys = (); // dict for everything regarding the lsys
~lsys.list = List.new;
~lsys.argsList = List.new;
l = LinkClock.new(1).permanent_(true);
~gui = ();
~gui.points = List.new;
~gui.scale = 10;
~gui.lastPoints = ();
~useLastPitch = true;
~lastPitch = 0;
~newLsysMode = \replace; // \add nil

~ctl = (
	legatoArr: 0.95!10,
	amp: 0.1,
	scale: Scale.harmonicMinor,
	branchInterval: 7,
	stepInterval: 1,
	noteOffset: -7,
	wrapLo: 36!10,
	wrapHi: 96!10,
	tempoMod: 1,
	vols: 1!10,
	theta: 51.45,
	setInstrument: [\simple_modes_synth_1, \sine_OD_1, \wavetable_1] ++ (\fm_1 ! 7) // fuer benni
);

if(~localSetup){
	~targetServer = Server.default;
	~gui.toProcessing = NetAddr("127.0.0.1", 12000);
}{
	var checkConnection = Condition.new;
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
			//("processing IP = " ++ ~addrBook.at(\Philipp).addr.ip).warn;
			~gui.toProcessing = NetAddr(~addrBook.at(\Philipp).addr.ip, 12000);
			~targetServer = Server(
				\benni,
				NetAddr(~addrBook.at(\Benni).addr.ip, 57110),
				ServerOptions.new().maxLogins_(4),
				1
			);
		}.fork
	};

};

