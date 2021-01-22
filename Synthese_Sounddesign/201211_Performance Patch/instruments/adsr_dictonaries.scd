dict1 plucks

~adsr_plucks

amp_a = 0.001,
amp_r = macro_3.lincurve(0,1,0.1,2,-2),
amp_d = amp_r,
amp_s = macro_3.lincurve(0,0.8,0.8,0,-3),
amp_c = 2;
EnvGen.kr(
	Env.adsr(
		attackTime: amp_a,
		decayTime: amp_d,
		sustainLevel: amp_s,
		releaseTime: amp_r,
		curve: amp_c
	),
	gate: gate,
	doneAction:2
)

dict2 pads

amp_a = macro_3.lincurve(0,1,0.1,1,-3),
amp_d = 0.1,
amp_s = 1,
amp_r = 2 - (1 * macro_3),
amp_c = 2;

