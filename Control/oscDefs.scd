thisProcess.openUDPPort(9010)

OSCFunc.trace(false, true)


n = NetAddr("127.0.0.1", 8080)

n.sendMsg("/legato/fader_1", 0.1)


8.do { |i|
	var addr = "/legato/fader_" ++ (i + 1);
	OSCdef(addr.asSymbol, {|msg|
		var newVal = msg[1];
		var doc = Document.current;
		var currentVar = doc.selectedString;
		if(currentVar.isEmpty){
			"no selection! ".postln;
		}{
			currentVar.interpret.legatoArr[i] = newVal
		}
	}, addr)
};

8.do { |i|
	var addr = "/volume/fader_" ++ (i + 1);
	OSCdef(addr.asSymbol, {|msg|
		var newVal = msg[1];
		var doc = Document.current;
		var currentVar = doc.selectedString;
		if(currentVar.isEmpty){
			"no selection! ".postln;
		}{
			currentVar.interpret.vols[i] = newVal
		}
	}, addr)
};

~test = 1

~test

~lsys.presets.pausen

~lsys = ()

~lsys.legatoArr = 0!8
