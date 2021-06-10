(
var bank = ~switchesBank;
var writeMomentarySwitchButton = (1..8);
var controllerArray = ~launchcontrolXlControlBusses;
var buttonStateArray = ~launchcontrolXlBottomButtonsControlBusses;
var controllerRow = ~launchcontrolXlControlBussesRowOffset;
var button;
var buttonArray;

("loading switches on Bank " ++ bank).postln;

~launchControlEvents.add(("launchControlXlEvent_" ++ bank).asSymbol -> {

	~launchControlXlKnobLEDsSetRow.(8,3);

	~switchState ?? {~switchState = 0!8};

	("LaunchControlXlBank " ++ bank ++ " ready").postln;
}
);

writeMomentarySwitchButton.do({ |button, index|

	~launchControlEvents.add(("launchControlXlEvent_" ++ bank ++ "_" ++ button).asSymbol -> {

		buttonStateArray[(button-1) + ((bank-1) * 8)].set(1);

		("bus " ++ ((button-1) + ((bank-1) * 8)) ++ " set to 1").postln;

	});


	~launchControlEvents.add(("launchControlXlNoteOffEvent_" ++ bank ++ "_" ++ button).asSymbol -> {

		buttonStateArray[(button-1) + ((bank-1) * 8)].set(0);

		("bus " ++ ((button-1) + ((bank-1) * 8)) ++ " set to 0").postln;

	});

});

)