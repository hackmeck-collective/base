(
"benni_pdef_resources.scd".loadRelative;
"benni_formteile.scd".loadRelative;
)
(

Pdef(\play,
	Pspawner({ |sp|
		sp.seq(Pdef(\exposition));
		sp.seq(Pdef(\layers));
		sp.seq(Pdef(\penrose_entwicklung1));
		sp.seq(Pdef(\penProse_entwicklung2));

	})
);
)

Pdef(\play).play(~linkClock, quant:1 )
Pdef(\playVisuals).stop

Pdef(\playVisuals).source