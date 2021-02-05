~pchain = { |ctl|
	Pbind(
		\dur, Plazy {|ev|
			if(ev.part.startTimes.size == 1){
				0 // nur ein Branch (root)
			}{
				Pseq(ev.part.startTimes[1..] * ev.baseTempo)
			} * Rest()
		},
		\cnt, Pseries(),
		\playNext, Pfunc { |ev|
			var voiceEvent = ev.part.stream[ev.cnt],
			myKey = voiceEvent.myKey.asInteger,
			firstPoint = ~gui.lastPoints[voiceEvent.parentId] ? Point(0,0),
			lastPoint,
			addPitch = if(~useLastPitch){~lastPitch}{0};
			// if(myKey == 0){~lastPitch = ~lastPitch + voiceEvent.pitches.last};
			if(myKey == 0){~lastPitch = voiceEvent.pitches.last}; // welche version macht mehr sinn?
			PmonoArtic(\default,
				\server, ~targetServer,
				\legato, Pfunc { ctl.legatoArr[myKey] },
				\pitches, Pseq(voiceEvent.pitches),
				\dur, Pfunc { |evInner| evInner.baseTempo },
				\amp, Pfunc { ctl.amp * ctl.vols[myKey] },
				\charNow, Pseq(voiceEvent.chars),
				\checkPause, Pfunc { |evInner|
					if(evInner.charNow == $G){Rest(evInner.dur)}{0}
				},
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
				\degree, Pfunc { |ev|
					ctl.branchInterval +
					(ev.pitches * ctl.stepInterval) +
					(myKey * ctl.noteOffset) +
					addPitch
				},
				\finish, { |evInner|
					evInner.midinote = evInner.midinote.wrap(ctl.wrapLo[myKey], ctl.wrapHi[myKey]);
					evInner
				}
			).play(l, protoEvent: ev)
		}
	)
};

Pbindef(\opts,
	\baseTempo, 1/4,
	\durCalc, \waitAll,
);

Pdef(\partPlayer,
	Pbind(
		\counter, Pn(Plazy({ Pseries(1, length: Pbindef(\opts).source[\part].source.list.size)})),
		\dur, Pfunc { |ev|
			"\n#### Now playing: ####".postln;
			"list index % of %\n".postf(ev.counter, Pbindef(\opts).source[\part].source.list.size);
			"active branchLevels now: %\n".postf(ev.part.maxKey);
			if(ev.part.maxKey >= 10) { "Too many branch Levels, not Playing!".warn; 1}{
				/*if(ev.counter == 1){
					~gui.toProcessing.sendMsg('/reset'); // fragwuerdig? ja wenn es mehrere parts gibt schlecht
				};*/
				~pchain.(~ctl).play(l, protoEvent: ev, quant: 0);
				"duration of this part: ".post;
				if(ev.durCalc == \waitAll){
					// FLOOR FUER BESSERE SYNC
					(ev.part.stream.last.lastTime * ev.baseTempo).floor.postln
				}{
					(ev.part.stream[0].lastTime * ev.baseTempo).postln
				}
			}
		} * Rest(),
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
