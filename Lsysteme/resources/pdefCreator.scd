~makePdef = { |name, lsys|
	Pdef(name, {
		var gui = topEnvironment[\gui];
		var topL = topEnvironment[\lsys];
		var topCtl = topEnvironment[\ctl];
		var startOffsets = lsys.startTimes * topCtl.baseTempo;
		var voices = lsys.stream.collect { |ev|
				var voiceEvent = ev,
				myKey = voiceEvent.myKey.asInteger,
				firstPoint = gui.lastPoints[voiceEvent.parentId] ? Point(0,0),
				lastPoint,
				addPitch = if(topL.useLastPitch){topL.lastPitch}{0};
				// if(myKey == 0){~lastPitch = ~lastPitch + voiceEvent.pitches.last};
				if(myKey == 0){topL.lastPitch = voiceEvent.pitches.last}; // welche version macht mehr sinn?
				PmonoArtic2(\default, // muss // Pbind
					\pitches, Pseq(voiceEvent.pitches),
					\charNow, Pseq(voiceEvent.chars),
					\dur, Pfunc { topCtl.baseTempo },
					\legato, Pfunc { topCtl.legatoArr[myKey] },
					\amp, Pfunc { topCtl.amp * topCtl.vols[myKey] },
					\degree, Pfunc { |ev|
						(ev.pitches * topCtl.stepInterval) +
						(myKey * topCtl.branchInterval)
						// ctl.branchInterval +
					},
					\checkPause, Pfunc { |ev|
						if(ev.charNow == $G){Rest(ev.dur)}{0}
					},
					\finish, { |ev|
						ev.midinote = ev.midinote.wrap(topCtl.wrapLo[myKey], topCtl.wrapHi[myKey]);
						ev
					}
				)
		};
		Psync(Ptpar([startOffsets, voices].flop.flat.postln), topCtl.quant, 36)
	})
}