



Pdef(\play, Pn(Pdef(\snowFlake)));
~lsys.presets.snowFlake.quant = 0
~lsys.presets.snowFlake.legatoArr = 0.6
~lsys.presets.snowFlake.useGlobalPitch = false
~lsys.presets.snowFlake.stutterVal = 1
~lsys.presets.snowFlake.stutterVal = Pseq([4, Pn(1,4)])

Pdef(\play).play(~linkClock, quant:4 )
Pdef(\play).clear

~linkClock.tempo = 1

Pdef(\play, Pn(Pdef(\basicL)));
~lsys.presets.basicL.quant = 4
~lsys.presets.basicL.instr = \blip

~lsys.presets.basicL.stutterVal= 1
~lsys.presets.basicL.stutterVal = Pseq([2, Pn(1,2)])