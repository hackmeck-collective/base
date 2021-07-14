~makePdef = { |name, lsys|
	Pdef((name.asString ++ "Inf").asSymbol, Pn(Pdef(name)));
	// filter fuer das komplette lsys
	Pdef((name.asString ++ "_filter").asSymbol).source ?? {
		Pdef((name.asString ++ "_filter").asSymbol, Pbind())
	};
	// filter fuer die einzelnen branches
	lsys.maxKey.do {|i|
		Pdef((name.asString ++ "_filter" ++ i).asSymbol).source ?? {
			Pdef((name.asString ++ "_filter" ++ i).asSymbol, Pbind())
		}
	};

	Pdef(name,
		Pfset(
			pattern: (
				Pdef((name.asString ++ "_innerPdef").asSymbol, {
					var top = topEnvironment;
					var startOffsets = lsys.startTimes * ~baseTempo;
					var voices = lsys.stream.collect { |voiceEvent|
						var myKey = voiceEvent.myKey.asInteger,
						noFirstPoint = true,
						setRootPointOnce = true,
						firstPoint,
						lastPoint,
						addPitch = if(~useGlobalPitch){top[\lsys][\globalPitch] + top[\lsys][\globalPitchBalance]}{0};

						PmonoArtic2() <>
						Pdef((name.asString ++ "_filter" ++ myKey).asSymbol) <>
						Pdef((name.asString ++ "_filter").asSymbol) <>
						Pstutter(Pn(Plazy {if(~lsys[\overwriteOnOff].stutterVal){~lsys[\overwriteValues].stutterVal}{~lsys[name].stutterVal}}),
							Pbind(
								\myId, voiceEvent.myId,
								\branchLevel, myKey,
								\branchTotalDur, ~baseTempo * (voiceEvent.lastTime - voiceEvent.firstTime),
								\dur, ~baseTempo * Pn(Plazy {|ev| (1 / ev.stutterVal) * Pseq(ev.shuffleArray)}),
								\server, top[\targetServer],
								\instrument, Pfunc {|ev|
									top[\makeModularSynthDef].valueWithEnvir(ev)
								},
								\group, Pfunc { top[\routing][\sourceGroup] },
								\out, Pfunc { top[\routing][\melodyBus] },
								\pitches, Pseq(voiceEvent.pitches),
								\charNow, Pseq(voiceEvent.chars),
								\legatoArr, Pn(Plazy {|ev| ev.legatoArr.asArray.wrapAt(myKey)}),
								\legato, Pfunc {|ev|
									if(ev.sendGate ? true){
										ev.legatoArr * (ev.legato ? 1)
									}{
										(ev.legatoArr * (ev.legato ? 1)).clip2(0.99)
									}
								},
								\vols, Pn(Plazy {|ev| ev.vols.asArray.wrapAt(myKey)}),
								\vol, Pfunc {|ev| ev.vol * ev.vols},
								\midinote, Pfunc{ |ev|
									var pitchIx = (ev.pitches * ev.stepInterval) + (myKey * ev.branchInterval.asArray.wrapAt(myKey));
									top[\pitchesRootDissonance][\pitches].foldAt(pitchIx + ev.noteOffset)
								},
								\checkPause, Pfunc { |ev|
									if((ev.charNow == $G) || (ev.vol == 0)){Rest(ev.dur)}{0}
								},
								/// GUI PART
								\calcPoint, Pfunc { |ev|
									if(noFirstPoint){
										firstPoint = top[\gui].lastPoints[voiceEvent.parentId] ? top[\gui].lastPoints[\rootPoint];
										noFirstPoint = false
									};
									lastPoint = firstPoint;
									firstPoint = firstPoint.translate(
										Point(0, ev.lineSize).rotate((ev.pitches * ev.theta).degrad)
									);
									if(ev.ignorePoints.not){
										top[\gui].lastPoints[voiceEvent.myId] = firstPoint;
									};
									[lastPoint, firstPoint]
								},
								\wrapLo, Pn(Plazy {|ev| ev.wrapLo.asArray.wrapAt(myKey)}),
								\wrapHi, Pn(Plazy {|ev| ev.wrapHi.asArray.wrapAt(myKey)}),
								\finish, { |ev|
									if(myKey == 0){
										if(setRootPointOnce){
											top[\gui].lastPoints[\rootPoint] = ev.calcPoint[1];
											setRootPointOnce = false
										};
										top[\lsys][\globalPitch] = ev.pitches + addPitch
									};
									if(ev.midinote > ~wrapHi){ ev.midinote = (ev.midinote % 12) + ~wrapHi - 12;
										// "wrapHI!".postln

									};
									if(ev.midinote < ~wrapLo){ ev.midinote = (ev.midinote % 12) + ~wrapLo;
										// "wrapLO!".postln

									};
									ev
								}
							) <> Pbind(*(top[\instrumentPresetsDictionary][~instr.asArray.wrapAt(myKey)]))
						)

					};
					// add this lsys to Set as it starts playing
					top[\lsys][\currentlyPlaying] = top[\lsys][\currentlyPlaying].add(name);
					top[\lsys][\updateCurrentlyPlaying].value;
					//top[\lsys][\presets][name].nextFinish = (thisThread.beats + (~maxPatDur * ~baseTempo)).roundUp(~quant);
					//top[\lsys][\presets][name].startOffsets = startOffsets; // fuer drum struktur?
					Psync(Ptpar([startOffsets, voices].flop.flat), ~quant, ~maxPatDur )
				}) <> Pbind(
					\stutterVal, Pfunc { |ev|
						if(~lsys[\overwriteOnOff].stutterVal){~lsys[\overwriteValues].stutterVal}{ev.stutterVal}
					},
					\legatoArr, Pfunc { |ev|
						if(~lsys[\overwriteOnOff].legatoArr){~lsys[\overwriteValues].legatoArr}{ev.legatoArr}
					},
					\stepInterval, Pfunc { |ev|
						if(~lsys[\overwriteOnOff].stepInterval){~lsys[\overwriteValues].stepInterval}{ev.stepInterval}
					},
					\branchInterval, Pfunc { |ev|
						if(~lsys[\overwriteOnOff].branchInterval){~lsys[\overwriteValues].branchInterval}{ev.branchInterval}
					},
					\vols, Pfunc { |ev|
						if(~lsys[\overwriteOnOff].vols){~lsys[\overwriteValues].vols}{ev.vols}
					},
					\shuffleArray, Pfunc { |ev|
						if(~lsys[\overwriteOnOff].shuffleArray){~lsys[\overwriteValues].shuffleArray}{ev.shuffleArray}
					}
				) <> ~lsys[name] //[\presets]
			),
			cleanupFunc: {
				topEnvironment[\lsys][\currentlyPlaying] = topEnvironment[\lsys][\currentlyPlaying].remove(name);
				topEnvironment[\lsys][\updateCurrentlyPlaying].value;
			}
		)
	)
}