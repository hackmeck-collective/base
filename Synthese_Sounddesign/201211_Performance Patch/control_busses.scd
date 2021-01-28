(
SynthDef.new(\control_busses,
	{
		~row1_controlbus ?? {~row1_controlbus = Bus.control(Server.default, 4)};
		~row2_controlbus ?? {~row2_controlbus = Bus.control(Server.default, 4)};
		~row3_controlbus ?? {~row3_controlbus = Bus.control(Server.default, 4)};
		~row4_controlbus ?? {~row4_controlbus = Bus.control(Server.default, 4)};
		~row5_controlbus ?? {~row5_controlbus = Bus.control(Server.default, 4)};
		~row6_controlbus ?? {~row6_controlbus = Bus.control(Server.default, 4)};
		~row7_controlbus ?? {~row7_controlbus = Bus.control(Server.default, 4)};
		~row8_controlbus ?? {~row8_controlbus = Bus.control(Server.default, 4)};
	};
);

)