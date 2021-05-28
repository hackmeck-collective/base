~launchControlEvents = Dictionary.new;


~fxBank = 1;
~texturKlangBank = 2;
"loading launchControlXl dictionaries".postln;

"launchcontrol-xl_fxBank.scd".loadRelative;
"launchcontrol-xl_TexturKlang.scd".loadRelative;

~launchControlEvents[\launchControlXlEvent_1].value;

// ~launchcontrolXlBottomButtonsControlBusses[button + ((bank - 1) * 8)].set(1);
// ~launchcontrolXlBottomButtonsControlBusses[button + ((bank - 1) * 8)].getSynchronous;
