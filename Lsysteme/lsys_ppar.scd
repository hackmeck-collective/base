Pdef(\play).play(~linkClock, quant:4)

Pdef(\play, Pn(Pdef(\parallel)))

Pdef(\parallel,
	Pbind(
		\vol, (Pfunc {|ev|
			if(ev.streamIndex == 1){ev.xfade}{1 - ev.xfade}
		}) * 0.5
	) <> Ppar([
		Pn(Pdef(\simpleRhythm) <> Pbind(\streamIndex, 1)),
		Pn(Pdef(\simpleRhythmPerc) <> Pbind(\streamIndex, 2))
	]) <> PtimeClutch(Pbind(
		\xfade, Pseg([0,1,0],[10,10],0,inf)
		//\xfade, Pwrand([0,1],[0.8,0.2],inf),
	))
)

~lsys.presets.basicL.reveal

