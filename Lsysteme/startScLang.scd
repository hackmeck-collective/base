// start automatisieren
// hail statt central
// presets speichern mit daten von allen
// (und wieder laden)

// NETWORK PREP
// UTOPIA CONNECTION

~addrBook.peers// CONNECT TO REMOTE SERVER
(
var remoteIP = ~addrBook.at(\Benni).addr.ip;
~benniServer = Server(
	\benni,
	NetAddr(remoteIP, 57110),
	ServerOptions.new().maxLogins_(4),
	1
);
)

Pbind(\server, ~benniServer).play
Pbindef(\ctl,
	\setInstrument, \default!10
);

~objSpace[\exit] = 1
~objSpace[\exit] = nil
~objSpace[\lsysRes] = nil
~objSpace[\lsys] = nil
// Start Lsys stuff
(
var midi = true;
~mOut = ConnectVirmidi();
if(midi){
	Pbindef(\ctl,
		\setType, \midi
	);
}{
	Pbindef(\ctl,
		\setType, \note,
		\server, ~benniServer
	);
};

l = LinkClock.new(1).permanent_(true);

Pbindef(\opts, \baseTempo, 1/4);
Pbindef(\opts, \durCalc, \waitAll);

"utopia_central_machine.scd".loadRelative; // resources to communicate with sclang daemon
"guiDict.scd".loadRelative;
"pdef.scd".loadRelative; // load pdef which will play back lsystems

"lsys_dict_text_replace.scd".loadRelative;

thisProcess.openUDPPort(9010); // listening to open stage control
"oscDefs.scd".loadRelative;

// start daemon sclang process
"sclang -D -u 9876 %/lsysCreator.scd".format(thisProcess.nowExecutingPath.dirname).runInTerminal;
)

