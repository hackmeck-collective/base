~makePdef = { |name, lsys|
	Pdef((name.asString ++ "Inf").asSymbol, Pn(Pdef(name)));
	Pdef(name,
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

		Pdefn((name.asString ++ "_stutter").asSymbol, Pn(Plazy {~lsys.presets[name].stutterVal}));

		Pdef((name.asString ++ "_innerPdef").asSymbol, {
			var top = topEnvironment;
			var startOffsets = lsys.startTimes * ~baseTempo;
			var voices = lsys.stream.collect { |voiceEvent|
				var myKey = voiceEvent.myKey.asInteger,
				noFirstPoint = true,
				muteMe = ~mute.asArray.wrapAt(myKey).next,
				firstPoint,
				lastPoint,
				addPitch = if(~useGlobalPitch){top[\lsys].globalPitch + top[\lsys].globalPitchBalance}{0};
				PmonoArtic2() <>
				Pdef((name.asString ++ "_filter" ++ myKey).asSymbol) <>
				Pdef((name.asString ++ "_filter").asSymbol) <>
				Pstutter(Pdefn((name.asString ++ "_stutter").asSymbol),
					Pbind(
						\branchLevel, myKey,
						\branchTotalDur, ~baseTempo * (voiceEvent.lastTime - voiceEvent.firstTime),
						\dur, ~baseTempo * Pn(Plazy {|ev| 1 / ev.stutterVal}),
						\server, top[\targetServer],
						\instrument, Pfunc {|ev|
							top[\makeModularSynthDef].valueWithEnvir(ev)
						},
						\group, Pfunc { top[\routing][\sourceGroup] },
						\out, Pfunc { top[\routing][\melodyBus] },
						\pitches, Pseq(voiceEvent.pitches),
						\charNow, Pseq(voiceEvent.chars),
						\scale, Pfunc { Scale.new(top[\pitchesRootDissonance][\pitches] % 12) },
						\legatoArr, Pn(Plazy {|ev| ev.legatoArr.asArray.wrapAt(myKey)}),
						\legato, Pfunc {|ev|
							if(ev.sendGate ? true){
								ev.legatoArr
							}{
								ev.legatoArr.clip2(0.99)
							}
						},
						\vols, Pn(Plazy {|ev| ev.vols.asArray.wrapAt(myKey)}),
						\vol, Pfunc {|ev| ev.vol * ev.vols * muteMe},
						\degree, Pfunc {|ev|
							(ev.pitches * ev.stepInterval) + (myKey * ev.branchInterval.asArray.wrapAt(myKey)) + addPitch + ev.noteOffset
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
							if(ev.vol > 0){ // muesste vol testen damit es wie gewuenscht funktioniert
								if((ev.checkPause.class != Rest) || (ev.legato >= 1)){
									top[\gui].points.add([
										ev.calcPoint,
										myKey.linlin(0,5,0,1).asFloat
									]);
								};
							};
							0
						},
						\wrapLo, Pn(Plazy {|ev| ev.wrapLo.asArray.wrapAt(myKey)}),
						\wrapHi, Pn(Plazy {|ev| ev.wrapHi.asArray.wrapAt(myKey)}),
						\finish, { |ev|
							if(myKey == 0){top[\lsys].globalPitch = ev.pitches + addPitch};
							ev.midinote = ev.midinote.wrap(~wrapLo, ~wrapHi);
							ev
						}
					) <> Pbind(*(top[\instrumentPresetsDictionary][~instr.asArray.wrapAt(myKey)]))
				)
			};
			//top[\lsys][\presets][name].nextFinish = (thisThread.beats + (~maxPatDur * ~baseTempo)).roundUp(~quant);
			//top[\lsys][\presets][name].startOffsets = startOffsets; // fuer drum struktur?
			Psync(Ptpar([startOffsets, voices].flop.flat), ~quant, ~maxPatDur )
		}) <> ~lsys.presets[name]
	)
}