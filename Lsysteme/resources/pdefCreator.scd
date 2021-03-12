~makePdef = { |name, lsys|
	Pdef((name.asString ++ "Inf").asSymbol, Pn(Pdef(name)));
	Pdef(name,
		Pdef((name.asString ++ "_filter").asSymbol, Pbind());
		Pdef((name.asString ++ "_innerPdef").asSymbol, {
			var top = topEnvironment;
			var startOffsets = lsys.startTimes * ~baseTempo;
			var voices = lsys.stream.collect { |voiceEvent|
				var myKey = voiceEvent.myKey.asInteger,
				noFirstPoint = true,
				firstPoint,
				lastPoint,
				addPitch = if(~useGlobalPitch){top[\lsys].globalPitch + top[\lsys].globalPitchBalance}{0};
				PmonoArtic2() <> Pdef((name.asString ++ "_filter").asSymbol) <> Pbind(
					\dur, ~baseTempo,
/*					\pats, List.new,
					\getPreset, Pfunc{|ev|
						ev.pats.clear;
						top[\instrumentPresetsDictionary][ev.presetName].keysValuesDo { |k, v|
							if(v.isKindOf(Pattern)){
								ev.pats.add([k, v])
							}{
								ev[k] = v
							}
						};
						ev
					},*/
					\server, top[\targetServer],
					\instrument, Pfunc {|ev| top[\makeModularSynthDef].(ev.adsrType, ev.pitchOp, ev.osc, ev.fx, ev.filter).asSymbol},
					\group, Pfunc { top[\routing][\sourceGroup] },
					\out, Pfunc { top[\routing][\melodyBus] },
					\pitches, Pseq(voiceEvent.pitches),
					\charNow, Pseq(voiceEvent.chars),
					\legato, Pfunc {|ev| if(ev.sendGate){ev.legatoArr[myKey]}{ev.legatoArr[myKey].clip2(0.99)}},
					\vol, Pfunc {|ev| ev.vol * ev.vols[myKey]},
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
						if(ev.amp > 0){ // muesste vol testen damit es wie gewuenscht funktioniert
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
				) <> top[\instrumentPresetsDictionary][~presetName[myKey]]
			};
			top[\lsys][\presets][name].nextFinish = (thisThread.beats + (~maxPatDur * ~baseTempo)).roundUp(~quant);
			top[\lsys][\presets][name].startOffsets = startOffsets; // fuer drum struktur?
			Psync(Ptpar([startOffsets, voices].flop.flat), ~quant, ~maxPatDur )//ev.quant, ev.maxPatDur.postln
		}) <> ~lsys.presets[name]
	)
}