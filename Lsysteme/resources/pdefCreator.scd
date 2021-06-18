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
		Pdef((name.asString ++ "_innerPdef").asSymbol, {
			var top = topEnvironment;
			var startOffsets = lsys.startTimes * ~baseTempo;
			var voices = lsys.stream.collect { |voiceEvent|
				var myKey = voiceEvent.myKey.asInteger,
				noFirstPoint = true,
				firstPoint,
				lastPoint,
				addPitch = if(~useGlobalPitch){top[\lsys][\globalPitch] + top[\lsys][\globalPitchBalance]}{0};

				PmonoArtic2() <>
				Pdef((name.asString ++ "_filter" ++ myKey).asSymbol) <>
				Pdef((name.asString ++ "_filter").asSymbol) <>
				Pstutter(Pn(Plazy {~lsys[\presets][name].stutterVal}),
					Pbind(
						\myId, voiceEvent.myId,
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
						/*\scale, Pfunc { Scale.new(top[\pitchesRootDissonance][\pitches] % 12) },
						\degree, Pfunc {|ev|
							(ev.pitches * ev.stepInterval) + (myKey * ev.branchInterval.asArray.wrapAt(myKey)) + addPitch + ev.noteOffset
						},*/
						/*\notesArray, Pfunc { |ev| ev.philippOctaves.collect { |i| top[\pitchesRootDissonance][\pitches] + (i * 12) }.flat.sort },
						\note, Pfunc {|ev|
						ev.notesArray.wrapAt((ev.pitches * ev.stepInterval) + (myKey * ev.branchInterval.asArray.wrapAt(myKey)) + addPitch + ev.noteOffset)
						},*/
						\midinote, Pfunc{ |ev|
							var pitchIx = (ev.pitches * ev.stepInterval) + (myKey * ev.branchInterval.asArray.wrapAt(myKey));// + ev.noteOffset;
							top[\pitchesRootDissonance][\pitches].foldAt(pitchIx + ev.noteOffset)
						},
						\checkPause, Pfunc { |ev|
							if((ev.charNow == $G) || (ev.vol == 0)){Rest(ev.dur)}{0}
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
/*						\draw, Pfunc { |ev|
							if((ev.checkPause.class != Rest) || (ev.legato >= 1)){
								top[\gui].points.add([
									ev.calcPoint,
									myKey.linlin(0,5,0,1).asFloat
								]);
							};
							0
						},*/
						\wrapLo, Pn(Plazy {|ev| ev.wrapLo.asArray.wrapAt(myKey)}),
						\wrapHi, Pn(Plazy {|ev| ev.wrapHi.asArray.wrapAt(myKey)}),
						\finish, { |ev|
							if(myKey == 0){top[\lsys][\globalPitch] = ev.pitches + addPitch};
							//ev.midinote = ev.midinote.wrap(~wrapLo, ~wrapHi);
							//ev.midinote.postln;
							if(ev.midinote > ~wrapHi){ ev.midinote = (ev.midinote % 12) + ~wrapHi - 12; "wrapHI!".postln };
							if(ev.midinote < ~wrapLo){ ev.midinote = (ev.midinote % 12) + ~wrapLo; "wrapLO!".postln };
							ev
						}
					) <> Pbind(*(top[\instrumentPresetsDictionary][~instr.asArray.wrapAt(myKey)]))
				)
			};
			//top[\lsys][\presets][name].nextFinish = (thisThread.beats + (~maxPatDur * ~baseTempo)).roundUp(~quant);
			//top[\lsys][\presets][name].startOffsets = startOffsets; // fuer drum struktur?
			Psync(Ptpar([startOffsets, voices].flop.flat), ~quant, ~maxPatDur )
		}) <> ~lsys[\presets][name]
	)
}