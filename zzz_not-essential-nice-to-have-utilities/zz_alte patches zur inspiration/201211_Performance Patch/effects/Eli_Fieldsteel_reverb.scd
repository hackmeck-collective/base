((
	SynthDef(\ef_reverb, {
		arg in = ~ef_reverb

		, predelay=1, revtime=10, lpf=4500,mix=0.5,amp=1,out=0;

		var wet,temp,sig;

		temp = In.ar(~ef_reverb, 2);

		wet=0;

		temp=DelayN.ar(temp, 0.2, predelay);

		32.do {
			temp=AllpassN.ar(temp, 0.05, {Rand(0.001,0.05)}!2,revtime);
			temp=LPF.ar(temp,lpf);
			wet=wet+temp;
		};

		sig = wet;

		Out.ar(~effect_bus,sig);

	}).add;
);
)