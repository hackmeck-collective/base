"initializing control busses".postln;

8.do({arg i;
	var rowNumber = i + 1;
	"
~launchcontrol_xl_row_% ?? {~launchcontrol_xl_row_% = Bus.control(Server.default, 4)};
~launchcontrol_xl_row_%.set(0.25,0.25,1,1);
~osc_data_params[\\launchcontrol_xl_row_%] = ~launchcontrol_xl_row_%.index;
".replace("%", rowNumber.asString).interpret;

});

~launchcontrol_xl_row_7.set(0.5,0.5,1,1);
~launchcontrol_xl_row_8.set(0.5,0,1,1);