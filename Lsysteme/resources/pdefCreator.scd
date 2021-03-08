~makePdef = { |name, lsys|
	Pdef(name,
		Pdef((name.asString ++ "_innerPdef").asSymbol, {
			var top = topEnvironment;
			var startOffsets = lsys.startTimes * ~baseTempo;
			var voices = lsys.stream.collect { |voiceEvent|
				var myKey = voiceEvent.myKey.asInteger,
				noFirstPoint = true,
				firstPoint,
				lastPoint,
				addPitch = if(~useLastPitch){top[\lsys].globalPitch + top[\lsys].globalPitchBalance}{0};
				PmonoArtic2(
					\getPreset, Pfunc{|ev| ev.putAll(top[\instrumentPresetsDictionary][ev.presetName])},
					\server, top[\targetServer],
					\instrument, Pfunc {|ev| top[\makeModularSynthDef].(ev.adsrType, ev.pitchOp, ev.osc, ev.fx, ev.filter).asSymbol},
					\group, Pfunc { top[\routing][\sourceGroup] },
					\out, Pfunc { top[\routing][\melodyBus] },
					\pitches, Pseq(voiceEvent.pitches),
					\charNow, Pseq(voiceEvent.chars),
					\dur, ~baseTempo,
					\legato, Pfunc {|ev| if(ev.sendGate){ev.legatoArr[myKey]}{ev.legatoArr[myKey].clip2(0.99)}} * Pseq([0.1,1,1, 1, 1],inf), // wenn es kein gate gibt, also ein pluck ist, dann muss legato < 1 bleiben, sonst macht pmonoartic probleme
					\amp, Pfunc {|ev| ev.amp * ev.vols[myKey]},
					\degree, Pfunc {|ev|
						(ev.pitches * ev.stepInterval) + (myKey * ev.branchInterval) + addPitch
					},
					\checkPause, Pfunc { |ev|
						if(ev.charNow == $G){Rest(ev.dur)}{0}
					},
					/// GUI PART
					\calcPoint, Pfunc { |ev|
						if(noFirstPoint){
							firstPoint = top[\gui].lastPoints[voiceEvent.parentId] ? Point(0,0);
							noFirstPoint = false
						};
						lastPoint = firstPoint;
						firstPoint = firstPoint.translate(
							Point(0, -1).rotate((ev.pitches * ev.theta).degrad)
						);
						top[\gui].lastPoints[voiceEvent.myId] = firstPoint;
						[lastPoint, firstPoint]
					},
					\draw, Pfunc { |ev|
						if(ev.amp > 0){
							if((ev.checkPause.class != Rest) || (ev.legato >= 1)){
								top[\gui].points.add([
									ev.calcPoint,
									myKey.linlin(0,5,0,1).asFloat
								]);
							};
						};
						0
					},
					\finish, { |ev|
						if(myKey == 0){top[\lsys].globalPitch = ev.pitches + addPitch};
						ev.midinote = ev.midinote.wrap(~wrapLo[myKey], ~wrapHi[myKey]);
						ev
					}
				)
			};
			Psync(Ptpar([startOffsets, voices].flop.flat), ~quant, ~maxPatDur )//ev.quant, ev.maxPatDur.postln
		}) <> ~ctlPresets[name]
	)
}