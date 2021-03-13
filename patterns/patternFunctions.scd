~metreDynamics_4_4 = {
	arg time,
	factor = 0.3,
	random = 0.05,
	static = 0.6;

	var whole, half, quarter, pattern;

	whole = 1 - (time.mod(4)/ 4);
	half = 1 - (time.mod(2) / 2);
	quarter = 1 - (time.mod(1));
	pattern = whole * 0.2 + half * 0.35 + quarter * 0.45;
	pattern = (pattern * factor) + (1.sum3rand * random) + static;
};



/*
(
Pbind(
	\amp, Pgauss(0, 0.05) + Pfunc {|time|~metreDynamics_4_4.(time)} <> Ptime().mod(4),
	\dur, Pseq([1/8], inf),
).play;
)*/