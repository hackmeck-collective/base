"initializing control busses".postln;


~dummybus ?? {~dummybus = Bus.control(Server.default, 1)};
~dummybus.set(1);


"initializing controlBusses for launchControlXl".postln;

~launchcontrolXlControlBusses ?? {~launchcontrolXlControlBusses = {Bus.control(s, 1)} ! 32};



32.do({ |i|
	~launchcontrolXlControlBusses[i].set(1);
	~routing["~launchcontrolXlControlBusses[%]".format(i).asSymbol] = ~launchcontrolXlControlBusses[i].index;
});

~launchcontrolXlControlBusses[15].set(0);

// ~launchcontrol_xl_row_8.set(0.5,0,1,1);

