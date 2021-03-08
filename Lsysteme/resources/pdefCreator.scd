~makePdef = { |name, lsys|
	Pdef(name,
		Pdef((name.asString ++ "_innerPdef").asSymbol, {
			var gui = topEnvironment[\gui];
			var topL = topEnvironment[\lsys];
			var routing = topEnvironment[\routing];
			var startOffsets = lsys.startTimes * ~baseTempo;
			var voices = lsys.stream.collect { |voiceEvent|
				var myKey = voiceEvent.myKey.asInteger,
				firstPoint = gui.lastPoints[voiceEvent.parentId] ? Point(0,0),
				lastPoint,
				addPitch = if(~useLastPitch){topL.globalPitch + topL.globalPitchBalance}{0};
				Pbind(//PmonoArtic2(\default, // muss // Pbind
					\getPreset, Pfunc{|ev| ev.putAll(topEnvironment[\presets_benni][ev.presetName])},
					\server, topEnvironment[\targetServer],
/*					\adsrType, \pluck,
					\sendGate, false,
					\pitchOp, Pseq([\slide, \fm, \unisonoDetune], inf),
					\osc, Pseq([\pulsar, \fm], inf),
					\fx, \shelvedOverdriveSoft,
					\filter, \noFilter,*/
					\instrument, Pfunc {|ev| topEnvironment[\makeModularSynthDef].(ev.adsrType, ev.pitchOp, ev.osc, ev.fx, ev.filter).asSymbol},
					\group, Pfunc { routing[\sourceGroup] },
					\out, Pfunc { routing[\melodyBus] },
					\pitches, Pseq(voiceEvent.pitches),
					\charNow, Pseq(voiceEvent.chars),
					\dur, ~baseTempo,
					\legato, Pfunc {|ev| ev.legatoArr[myKey]},
					\amp, Pfunc {|ev| ev.amp * ev.vols[myKey]},
					\degree, Pfunc {|ev|
						(ev.pitches * ev.stepInterval) + (myKey * ev.branchInterval) + addPitch
					},
					\checkPause, Pfunc { |ev|
						if(ev.charNow == $G){Rest(ev.dur)}{0}
					},
					\finish, { |ev|
						if(myKey == 0){topL.globalPitch = ev.pitches + addPitch};
						ev.midinote = ev.midinote.wrap(~wrapLo[myKey], ~wrapHi[myKey]);
						ev
					}
				)
			};
			// topL.globalPitch = (topL.globalPitch + lsys.lastPitch).postln;
			Psync(Ptpar([startOffsets, voices].flop.flat), ~quant, ~maxPatDur)
		}) <> ~ctlPresets[name]
	)
}