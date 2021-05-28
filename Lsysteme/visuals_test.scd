Pdef(\play, Pn(Pdef(\penrose)))

~lsys.presets.pausen.instr = \simplePluck
~lsys.presets.pausen.noteOffset = -20
~lsys.presets.pausen.vols = 0.5
~lsys.presets.pausen.baseTempo = 1/8
~lsys.presets.pausen.useGlobalPitch = false
//axiom: "a+k+f+k+k+a-a-k-f-k-k-a"
//rules: ($a: "b", $b: "c", $c: "d", $d: "e", $e: "f", $f: "h[i]", $i: "j+l", $l: "mn", $n: "o+l")

~lsysPreset.create(\triangle)


~lsys.presets.simpleSwitchMelodie
Pdef(\playVisuals).play(~linkClock, quant:2 )
Pdef(\playVisuals).stop

~gui.points

~gui.toProcessing.sendMsg('/scale', 5.5)

~gui.toProcessing.sendMsg('/scale', 0.9)

~linkClock.tempo = 1

~gui.toProcessing.sendMsg('/linesMax', 140)


~gui.toProcessing.sendMsg('/lerpFactor', 1.0)

~gui.toProcessing.sendMsg('/reset')


~lsys.presets.chaosFugue.theta = 20


~lsys.presets.penrose.theta = 12


Pdef(\play,
	Pn(
		Pspawner({ |sp|
			sp.seq(Pn(Pdef(\weed), 4));
			sp.seq(Pn(Pdef(\penrose), 8));
			sp.seq(Pn(Pdef(\simpleSwitch), 8));
		})
	)
)

// Weiteres Vorgehen:

// bei den loops einmal kurz hoerere generation einbauen.

// zweite wdh (vom perc wieder auf weed) mit hoeherer gen als basis

// fuer jedes ein parameter auf bennis dings (bei weed verzerrung, bei simpleSwitch envelope)

// pdef wrapping?

// bei 2ter wdh die reihenfolge aendern (von weed nach simpleSwitch)


