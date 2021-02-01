// start automatisieren
// presets speichern mit daten von allen
// (und wieder laden)

// Start Lsys stuff
(
~useDaemon = false;
~localSetup = true;
"resources/globals.scd".loadRelative;
"resources/pdef.scd".loadRelative; // load pdef which will play back lsystems
"resources/lsys_dict_text_replace.scd".loadRelative;
"resources/oscDefs.scd".loadRelative;

if(~useDaemon){
	"resources/startDaemon.scd".loadRelative; // resources to communicate with sclang daemon
}{
	"resources/lsysCreator_noDaemon.scd".loadRelative;
};
)

~addrBook.peers// CONNECT TO REMOTE SERVER

Pbind(\server, ~benniServer).play
