~lsys.presets.keys
Pn(Pdef(\expo)).play
((Pbind(\vol, Pfunc {|ev| if(ev.vol == 0){Rest()}{ev.vol}}.trace ) <> Pn(Pdef(\simpleWeed)))).play
~lsys.presets[\weed].instr = \simplePluck
~lsys.presets[\weed].vols = 0.9
~lsys.presets[\weed].legatoArr  = 1
~lsys.presets[\weed].numBranches

~lsysPreset.edit(\simpleWeed)

~lsysPreset.create(\philly)

Pn(Pdef(\philly)).play

Pn(Pbind(\envelope_mod, Pfunc {|ev|
	(ev[\branchLevel].postln ? 1).lincurve(0,3,5,0.3,1).postln; })
	//
<> Pdef(\weed)).play

Pn(Pdef(\philly2)).play
