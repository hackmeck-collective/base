"make_lsys.scd".loadRelative;
~addrBook = AddrBook.new;
~addrBook.addMe(\daemon);
~hail = Hail.new(~addrBook);
//~registrant = Registrant(~addrBook); // execute this on all clients
~objSpace = OSCObjectSpace(~addrBook, oscPath:'/lsysArgs').acceptEvents_(true);
~objSpace.addDependant({|objectSpace, what, key, val|
	if(key == \exit){
		0.exit
	};
	//"Received new lsys args %\n writing stream ... \n".postf(val);
	"writing stream .. ".postln;
	if(key == \lsys){
		var lsys = RedLSystem(val.axiom, val.rules), lsysPattern, lsysStream;
		val.gen.do { lsys.next };
		{
			if(val.useLastV ?? false){
				lsysPattern = ~makeStream.(lsys, lastV: ~saveLastV);
			}{
				lsysPattern = ~makeStream.(lsys);
			}
		}.bench;
		~saveLastV = lsysPattern.lastVoice;
		{
			lsysStream = lsysPattern.removeAt(\stream);
			lsysStream.do { |ev ix|
				ev.writeArchive(PathName.tmp +/+ "LSYSTEM_STREAM_" ++ ix);
			};
		}.bench;
		lsysPattern.streamSize = lsysStream.size;
		~objSpace[\lsysRes] = lsysPattern;
		"lsys stream written".postln;
	}
});

