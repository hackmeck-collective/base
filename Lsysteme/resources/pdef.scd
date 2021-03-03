~pchain = { |ctl|
	Pbind(
		\dur, Plazy {|ev|
			if(ev.part.startTimes.size == 1){
				0 // nur ein Branch (root)
			}{
				Pseq(ev.part.startTimes[1..] * ev.baseTempo)
			} * Rest() // no sound pls
		},
		\cnt, Pseries(),
		\playNext, Pfunc { |ev|
			var voiceEvent = ev.part.stream[ev.cnt],
			myKey = voiceEvent.myKey.asInteger,
			firstPoint = ~gui.lastPoints[voiceEvent.parentId] ? Point(0,0),
			lastPoint,
			addPitch = if(~lsys.useLastPitch){~lsys.lastPitch}{0};
			ctl.keys.postln;
			// if(myKey == 0){~lastPitch = ~lastPitch + voiceEvent.pitches.last};
			if(myKey == 0){~lsys.lastPitch = voiceEvent.pitches.last}; // welche version macht mehr sinn?
			Pbind(//PmonoArtic2(\default, // muss
				\server, ~targetServer,
				//\controlbus, 0,
				/*				Pfunc {
				[
				ctl.launchcontrol_xl_row_4,
				ctl.launchcontrol_xl_row_5,
				ctl.launchcontrol_xl_row_6
				][myKey]
				},*/
				\out, Pfunc { ctl.melodyBus },
				\group, Pfunc { ctl.sourceGroup },
				/*				\adsrType, \pluck,
				\pitchOp, Pseq([\slide, \fm, \unisonoDetune], inf),
				\osc, Pseq([\pulsar, \fm], inf),
				\fx, \shelvedOverdriveSoft,
				\filter, \lpf_moog,
				\instrument, Pfunc {|ev| "%_%_%_%_%".format(ev.adsrType, ev.pitchOp, ev.osc, ev.fx, ev.filter).asSymbol },*/
				\instrument, Pfunc { ctl.instrument.choose }.stutter(8),
				\pitches, Pseq(voiceEvent.pitches),
				\charNow, Pseq(voiceEvent.chars),
				\dur, Pfunc { |evInner| evInner.baseTempo },
				\legato, Pfunc { ctl.legatoArr[myKey] },
				\amp, Pfunc { ctl.amp * ctl.vols[myKey] },
				\midinote, Pfunc { |ev|
				ctl.scale.wrapAt(ev.pitches * ctl.stepInterval) + ctl.noteOffset +
				(myKey * 12)
				// ctl.branchInterval +
				},
				//\vol, 0.5,
/*				\scale, Pfunc { ctl.scale },
				\degree, Pfunc { |ev|
					ctl.branchInterval +
					(ev.pitches * ctl.stepInterval) +
					(myKey * ctl.noteOffset) +
					addPitch
				},*/
				\checkPause, Pfunc { |evInner|
					if(evInner.charNow == $G){Rest(evInner.dur)}{0}
				},
				// gui stuff ab hier
				\calcPoint, Pfunc { |ev|
					lastPoint = firstPoint;
					firstPoint = firstPoint.translate(
						Point(0, -1).rotate((ev.pitches * ctl.theta).degrad)
					);
					~gui.lastPoints[voiceEvent.myId] = firstPoint;
					[lastPoint, firstPoint]
				},
				\draw, Pfunc { |ev|
					if(ev.amp > 0){
						if((ev.checkPause.class != Rest) || (ev.legato >= 1)){
							~gui.points.add([ev.calcPoint, myKey.linlin(0,5,0,1).asFloat]);
						};
					};
					0
				},

				\finish, { |evInner|
					//evInner.postln;
					evInner.midinote = evInner.midinote.wrap(ctl.wrapLo[myKey], ctl.wrapHi[myKey]);
					evInner
				}
			).play(l, protoEvent: ev)
		}
	)
};

Pdef(\partPlayer,
	Pbind(
		// \test, Pfunc { |ev| ev.postln},
		\counter, Pn(Plazy({ Pseries(1, length: Pbindef(\opts).source[\part].source.list.size)})),
		\dur, Pfunc { |ev|
			"\n#### Now playing: ####".postln;
			"list index % of %\n".postf(ev.counter, Pbindef(\opts).source[\part].source.list.size);
			"active branchLevels now: %\n".postf(ev.part.maxKey);
			if(ev.part.maxKey >= 10) { "Too many branch Levels, not Playing!".warn; 1}{
				/*if(ev.counter == 1){
				~gui.toProcessing.sendMsg('/reset'); // fragwuerdig? ja wenn es mehrere parts gibt schlecht
				};*/
				~pchain.(~ctl).play(l, protoEvent: (ev.putAll(~presets_benni[~ctl.presetName]))); // quant
				"duration of this part: ".post;
				if(ev.durCalc == \waitAll){
					// FLOOR FUER BESSERE SYNC
					(ev.part.stream.last.lastTime * ev.baseTempo).floor.postln
				}{
					(ev.part.stream[0].lastTime * ev.baseTempo).postln
				}
			}
		} * Rest() // no sound pls,
	) <> Pbindef(\opts)
);

Tdef(\drawLines, {
	loop {
		if(~gui.points.isEmpty.not){
			~gui.points.do { |p|
				var wp1 = (p[0][0]) * ~gui.scale,  // ~win.bounds.bottom/2 oder so
				wp2 = (p[0][1]) * ~gui.scale,
				branchLevel = p[1],
				oscMsg = (wp1.asArray ++ wp2.asArray).asInteger ++ branchLevel;
				~gui.toProcessing.sendMsg('/lines', *oscMsg);
			};
			~gui.points.clear;
		};
		Pbindef(\opts).source[\baseTempo].source.wait;
	}
});
