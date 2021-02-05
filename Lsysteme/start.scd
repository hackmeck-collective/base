(
~useDaemon = false;
~localSetup = true;
"resources/globals.scd".loadRelative;
"resources/pdef.scd".loadRelative; // load pdef which will play back lsystems
"resources/lsys_dict_text_replace.scd".loadRelative;
"resources/oscDefs.scd".loadRelative;

if(~useDaemon){
	// brauch ueberarbeitung weil die points rausgefallen sind und wegen starting pitch als int
	"resources/startDaemon.scd".loadRelative; // resources to communicate with sclang daemon
}{
	"resources/lsysCreator_noDaemon.scd".loadRelative;
};
)
