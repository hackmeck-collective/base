Pdef(\play, Pn(Pdef(\philly)))
~lsys.presets.snowFlake.instr = \simpleBass

~lsys.presets.snowFlake.noteOffset = 12
Pdef(\playVisuals).play(~linkClock, quant:0 )
Pdef(\playVisuals).stop

~gui.points

~gui.toProcessing.sendMsg('/scale', 1.3)

~gui.toProcessing.sendMsg('/scale', 0.9)

~linkClock.tempo = 1

~gui.toProcessing.sendMsg('/linesMax', 150)


~gui.toProcessing.sendMsg('/lerpFactor', 1.0)

~gui.toProcessing.sendMsg('/reset')


~lsys.presets.chaosFugue.theta = 20
