"initializing control busses".postln;

~launchcontrol_xl_row_1 ?? {~launchcontrol_xl_row_1 = Bus.control(Server.default, 4)};
~launchcontrol_xl_row_2 ?? {~launchcontrol_xl_row_2 = Bus.control(Server.default, 4)};
~launchcontrol_xl_row_3 ?? {~launchcontrol_xl_row_3 = Bus.control(Server.default, 4)};
~launchcontrol_xl_row_4 ?? {~launchcontrol_xl_row_4 = Bus.control(Server.default, 4)};
~launchcontrol_xl_row_5 ?? {~launchcontrol_xl_row_5 = Bus.control(Server.default, 4)};
~launchcontrol_xl_row_6 ?? {~launchcontrol_xl_row_6 = Bus.control(Server.default, 4)};
~launchcontrol_xl_row_7 ?? {~launchcontrol_xl_row_7 = Bus.control(Server.default, 4)};
~launchcontrol_xl_row_8 ?? {~launchcontrol_xl_row_8 = Bus.control(Server.default, 4)};

~launchcontrol_xl_row_1.set(0.25,0.25,1,1);
~launchcontrol_xl_row_2.set(0.25,0.25,1,1);
~launchcontrol_xl_row_3.set(0.25,0.25,1,1);
~launchcontrol_xl_row_4.set(0.25,0.25,1,1);
~launchcontrol_xl_row_5.set(0.25,0.25,1,1);
~launchcontrol_xl_row_6.set(0.25,0.25,1,1);
~launchcontrol_xl_row_7.set(0.5,0.5,1,1);
~launchcontrol_xl_row_8.set(0.5,0,1,1);
