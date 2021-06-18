~launchControlEvents = Dictionary.new;

~switchesBank = 1;
~fxBank = 2;
~texturKlangBank = 3;
"loading launchControlXl dictionaries".postln;

"launchcontrol-xl_switchesBank.scd".loadRelative;
"launchcontrol-xl_fxBank.scd".loadRelative;
"launchcontrol-xl_TexturKlang.scd".loadRelative;

~launchControlEvents[\launchControlXlEvent_1].value;

// ~launchcontrolXlBottomButtonsControlBusses[button + ((bank - 1) * 8)].set(1);
// ~launchcontrolXlBottomButtonsControlBusses[button + ((bank - 1) * 8)].getSynchronous;
