~lsys = (); // dict for everything regarding the lsys
~lsys.list = List.new;
~lsys.argsList = List.new;
~lsys.isReading = false;
~addrBook = AddrBook.new;
~addrBook.addMe;
~registrar = Registrar(~addrBook); // execute this only on the central machine
~objSpace = OSCObjectSpace(~addrBook, oscPath:'/lsysArgs').acceptEvents_(true);
~objSpace.addDependant({|objectSpace, what, key, val|
	"Received new Lsys Result %\n reading stream ... \n".postf(val);
	if(key == \lsysRes){
		if(~lsys.isReading){
			"CURRENTLY READING LSYS, NOT READING NEW STREAM".postln;
		}{
			~lsys.isReading = true;
			~lsys.newPattern = ~objSpace[\lsysRes].copy;
			~lsys.newPattern.stream = List.new;
			{
				~objSpace[\lsysRes].streamSize.do { |ix|
					~lsys.newPattern.stream.add(
						Object.readArchive(PathName.tmp +/+ "LSYSTEM_STREAM_" ++ ix)
					);
					0.001.wait;
				};
				~lsys.list.add(~lsys.newPattern);
				~lsys.argsList.add(~objSpace[\lsys]);
				~lsys.isReading = false;
				"finished reading lsys stream".postln;
			}.fork;
		}
	}
});
