
Pdef(\play).play(~linkClock, quant:1 )
Pdef(\play).clear
~lsys.presets.newBranchTest.stutterVal = Pseq([3, Pn(1,4)])
// ~lsys.presets.newBranchTest.stutterVal = Pseq([3, Pn(1,4)])

Pdef(\play, Pn(Pdef(\newBranchTest)))
Pdef(\play, Pn(Pdef(\wup3slow)))
~lsys.presets[\wup3].instr = \blip
~lsys.presets[\wup3].noteOffset = 0
~lsys.presets[\wup3slow].vols = 0.4

~lsys.presets[\wup3slow].baseTempo = 1/2;
~lsys.presets[\wup3].baseTempo = 1/8;

Pdef(\play,
	Pbind(
		\vol, (Pfunc {|ev|
			var oldVol = ev.vol ? 1;
			var fade = if(ev.streamIndex == 1){ev.xfade}{1 - ev.xfade};
			oldVol * fade
		}).trace
	) <> Ppar([
		Pn(Pdef(\wup3)) <> Pbind(\streamIndex, 1),
		Pn(Pdef(\newBranchTest)) <> Pbind(\streamIndex, 2)
	]) <> PtimeClutch(Pbind(
		\xfade, Pseg([0,1,0],[10,10],0,inf)
	))
)

Pdef(\play,
	Pbind(
		\vol, (Pfunc {|ev|
			var oldVol = ev.vol ? 1;
			var fade = if(ev.streamIndex == 1){ev.xfade}{1 - ev.xfade};
			oldVol * fade
		})
	) <> Ppar([
		Pn(Pdef(\wup3)) <> Pbind(\streamIndex, 1),
		Pn(Pdef(\newBranchTest)) <> Pbind(\streamIndex, 2)
	]) <> PtimeClutch(Pbind(
		\weights, Pseg([0.99,0.01, 0.99],[20,10],0,inf),
		\xfade, Pn(Plazy {|ev| Pwrand([0, 1], [1 - ev.weights, ev.weights])})
	))
)




Pdef(\play,
	Ppar([
		Pn(Pdef(\wup3)),
		Pn(Pdef(\wup3slow))
	])
)