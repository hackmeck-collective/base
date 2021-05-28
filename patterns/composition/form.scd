"pdef_resources.scd".loadRelative;

Pdef(\play,
	Pspawner({ |sp|
		sp.seq(Pdef(\exposition));
		sp.seq(Pdef(\penrose_entwicklung1));
		sp.seq(Pdef(\penrose_entwicklung2));
	})
);

Pdef(\play).play(~linkClock, quant:1 )

Pdef(\play).stop