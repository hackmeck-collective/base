"initializing control busses".postln;


~dummybus ?? {~dummybus = Bus.control(Server.default, 1)};
~dummybus.set(1);


"initializing controlBusses for launchControlXl".postln;

~launchcontrolXlControlBusses ?? {~launchcontrolXlControlBusses = {Bus.control(s, 1)} ! 32};
~launchcontrolXlBottomButtonsControlBusses ?? {~launchcontrolXlBottomButtonsControlBusses = {Bus.control(s, 1)} ! 64};


32.do({ |i|
	~launchcontrolXlControlBusses[i].set(1);
	~routing["~launchcontrolXlControlBusses[%]".format(i).asSymbol] = ~launchcontrolXlControlBusses[i].index;
});

~launchcontrolXlControlBusses[15].set(0);
~launchcontrolXlControlBussesRowOffset = [0,8,16,24];

64.do({ |i|
	~launchcontrolXlBottomButtonsControlBusses[i].set(0);
	~routing["~launchcontrolXlBottomButtonsControlBusses[%]".format(i).asSymbol] = ~launchcontrolXlBottomButtonsControlBusses[i].index;
});
