


~lsys.presets.poppe2.instr = \simpleLead

Pdef(\play, Pn(Pdef(\poppe3)).trace);
~lsys.presets.snowFlake.quant = 0
~lsys.presets.snowFlake.legatoArr = 0.6
~lsys.presets.snowFlake.useGlobalPitch = false
~lsys.presets.snowFlake.stutterVal = 3
~lsys.presets.snowFlake.stutterVal = Pseq([3, Pn(1,1)])
~lsys.presets.snowFlake.instr = \blip
Pdef(\play).play(~linkClock, quant:4 )
Pdef(\play).stop

~routing[\launchcontrol_xl_row_1]

~linkClock.tempo = 1
~poppeStretch = Pbind(\stretch, Pseq([8/5, 2/5], inf));
~poppeStretch = Pbind(\stretch, Pseq([Pseq([Pn(2/3, 6), Pn(2,2)], 3),Pseq([2/3, 4/3, 1/2, 1.5,1,1,1,1])], inf));
Pdef(\snowFlake_filter, Pbind())
Pdef(\snowFlake_benni_Control,
	Pbind(
		\envelope_mod, 0.5,
		\controlbus1, Pfunc{~routing[\launchcontrol_xl_row_1]},
		\external1Amount, 1
) <> Pn(Pdef(\snowFlake)) <> Pbind(\external1Target, "\envelope_mod"));

Pdef(\basicL_benni_Control,
	Pbind(
		\envelope_mod, 0.5,
		\controlbus1, Pfunc{~routing[\launchcontrol_xl_row_1]},
		\external1Amount, 1
	) <> Pn(Pdef(\basicL)) <> Pbind(\external1Target, "\envelope_mod"));
~lsys.presets.basicL.quant = 4
~lsys.presets.basicL.instr = \simplePluck
~lsys.presets.basicL.vols = 0.5

~lsys.presets.chaosFugue.stutterVal= Pseq([4, Pn(1,2)])

~lsys.presets.rabbitSeq.stutterVal= 1
~lsys.presets.rabbitSeq.stutterVal = Pseq([3, Pn(1,2)])
Pdefn(\weights, Pbjorklund(Pseq((1..15),inf).trace,16,inf))
~weightsTest = 0.5;

Pdef(\play,
	Pbind(
		\vol, (Pfunc {|ev|
			var oldVol = ev.vol ? 1;
			var fade = if(ev.streamIndex == 1){ev.xfade}{1 - ev.xfade};
			oldVol * fade
		})
	) <> Ppar([
		Pn(Pdef(\chaosFugue)) <> Pbind(\streamIndex, 1), //\newBranchTest
		Pn(Pdef(\rabbitSeq)) <> Pbind(\streamIndex, 2)
	]) <> PtimeClutch(Pbind(
		\weights, Pdefn(\weights),//Pseg([0,1,0],[20,20],0,inf),//Pfunc{ ~weightsTest },
		\xfade, Pn(Plazy {|ev| Pwrand([0, 1], [1 - ev.weights, ev.weights])})
	), delta: (1/4) - 0.01) // Delta mit dem baseTempo auf dem es laufen soll abstimmen
)

Pdef(\play,Pbind(\vol, Pfunc {|ev| if(ev.charNow == $F){1}{0.8}}) <>  Pn(Pdef(\chaosFugue)))
Pdef(\play, Pbind(\vol, Pfunc {|ev| if(ev.charNow == $F){0.9}{0.7}}) <>Pn(Pdef(\rabbitSeq)))


Pdef(\chaosFugue_control,
	Pbind(
		\envelope_mod, 0.5,
		\controlbus1, Pfunc{~routing[\launchcontrol_xl_row_1]},
		\external1Amount, 1
) <> Pbind(\vol, Pfunc {|ev| if(ev.charNow == $F){0.7}{0.4}}) <> Pn(Pdef(\chaosFugue)) <> Pbind(\external1Target, "\envelope_mod"));

Pdef(\rabbitSeq_control,
	Pbind(
		\envelope_mod, 0.5,
		\controlbus1, Pfunc{~routing[\launchcontrol_xl_row_1]},
		\external1Amount, 1
	) <> Pbind(\vol, Pfunc {|ev| if(ev.charNow == $F){2}{1}}) <> Pn(Pdef(\rabbitSeq)) <> Pbind(\external1Target, "\envelope_mod"));