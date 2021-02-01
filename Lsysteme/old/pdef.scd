Pbindef(\ctl,
	\legatoArr, 0.95!10,
	\amp, 0.1,
	\scale, Scale.harmonicMinor,
	\branchInterval, Pfunc { |ev| ev.scale.size * -1 },
	\stepInterval, 1,
	\noteOffset, Pfunc { |ev| ev.scale.size * -1 },
	\chanFunc, {|chanOffset myKey maxKey| chanOffset + myKey},
	\wrapLo, 36!10,
	\wrapHi, 96!10,
	\vols, [1, 1, 1, 1, 1, 1, 1],
	\setInstrument, [\simple_modes_synth_1, \sine_OD_1, \wavetable_1] ++ (\fm_1 ! 7) // fuer benni
);

// das problem bei diesem ding ist, dass zweige mit selben branchlevel parallel laufen, daher
// ueberschreiben die sich gegenseitig
~lastPoints = (Point(0, 0))!10;

~pchain = Plazy({ |evIn|
	Pspawner({ | sp |
		evIn[\stream].stream.do { |voiceEvent streamIndex|
			var startTime = voiceEvent.newTime,
			notes = voiceEvent.pitches,
			myKey = voiceEvent.myKey.asInteger,
			points = voiceEvent.points,
			stepsTaken = voiceEvent.lastTime,
			placeInLevel = evIn[\stream].levelSteps[myKey].asArray.sort.indexOf(stepsTaken) ?? 0,
			newNote = voiceEvent.meltedList.flop[0],
			chars = voiceEvent.meltedList.flop[1],
			newRhy =  voiceEvent.meltedList.flop[2],
			myMidiChan = myKey, //(myKey * 3) + placeInLevel; // hier muss ein limit ..;
			firstPoint = ~lastPoints[myKey],
			lastPoint;//Point(0, 0);

			if(startTime > 0){
				sp.wait(startTime * evIn[\baseTempo]);
			};
			sp.par(
				// PmonoArtic(\default) <> koennte durch pause rausgehauen werden?
				Pbind(
					\testKey, myKey,
					\type, Pkey(\setType),
					\instrument,  Pfunc { |ev| ev.setInstrument.clipAt(myKey) },
					\midiout, ~mOut,
					\cleanupFunc, {~mOut.clear},
					\chan, myMidiChan,
					\rhyFactors, Pseq(newRhy),
					\dur, (Pkey(\baseTempo) * Pkey(\rhyFactors)),
					\clipVol, Pfunc { |ev| ev.vols.clipAt(myKey) },
					\legato, Pfunc { |ev| ev.legatoArr.clipAt(myKey) },
					\charNow, Pseq(chars),
					\checkPause, Pfunc { |ev|
						if(ev.charNow == $G){Rest(ev.dur)}{0}
					},
					\pitches, Pseq(newNote),
					\calcPoint, Pfunc { |ev|
						lastPoint = firstPoint;
						firstPoint = firstPoint.translate(
							Point(0, -1 * ev.rhyFactors).rotate((ev.pitches * ev.theta).degrad)
						);
						~lastPoints[myKey + 1] = firstPoint;
						[lastPoint, firstPoint]
					},
					\getPoints, Pclump(Pkey(\rhyFactors), Pseq(points)),
					\draw, Pfunc { |ev|
						if(ev.checkPause.class != Rest){
							~gui.points.add([ev.calcPoint, myKey.linlin(0,5,0,1).asFloat]) //colors[myKey]
							/*ev.getPoints.do { |p|
							~gui.points.add([p, myKey.linlin(0,5,0,1).asFloat]) //colors[myKey]
							};*/
						};
						0
					},
					\degree, Pkey(\noteOffset) +
					(Pseq(newNote) * Pkey(\stepInterval)) +
					(myKey * Pkey(\branchInterval)),
					\amp, Pkey(\amp) * Pkey(\clipVol) * Pfunc { |ev| ev.rhyFactors.lincurve(1,10, 0.5, 1, -2) }, // je laenger die note desto lauter
					\finish, { |ev|
						ev.midinote = ev.midinote.wrap(ev.wrapLo[myKey], ev.wrapHi[myKey]); // koennte individuell per key gestaltet werden
						ev
					}
				)
			);
		};
	})
/*	.collect { |ev|
		if(ev.testKey.notNil){~lastPoints[ev.testKey + 1] =	ev.calcPoint[1]
			/*			ev.calcPoint[1].translate(
			Point(0, -1 * ev.rhyFactors).rotate((ev.pitches * ev.theta.postln).degrad)
			)*/
		};
		ev
	};*/
}) <> PtimeClutch(Pbindef(\ctl));

Pbindef(\opts,
	\baseTempo, 1/4,
	\durCalc, \waitAll,
	\theta, 51.45
);

Pdef(\partPlayer,
	Pbind(
		\counter, Pn(Plazy({ Pseries(1, length: Pbindef(\opts).source[\part].source.list.size)})),
		\dur, Pfunc { |ev|
			"\n#### Now playing: ####".postln;
			"list index % of %\n".postf(ev.counter, Pbindef(\opts).source[\part].source.list.size);
			"active branchLevels now: %\n".postf(ev.part.maxKey);
			if(ev.part.maxKey >= 10) { "Too many branch Levels, not Playing!".warn; 1}{
				~lastPoints = (Point(0, 0))!10;
				(~pchain <> (stream: ev.part, baseTempo: ev.baseTempo, theta: ev.theta)).play(l, quant: 0); // quant??
				"duration of this part: ".post;
				if(ev.durCalc == \waitAll){
					// FLOOR FUER BESSERE SYNC
					(ev.part.stream.last.lastTime * ev.baseTempo).floor.postln
				}{
					(ev.part.stream[0].lastTime * ev.baseTempo).postln
				}
			}
		},
		\amp, Rest()
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
				~gui.toProcessing.sendMsg('/lines', *oscMsg); //M
			};
			~gui.points.clear;
		};
		Pbindef(\opts).source[\baseTempo].source.wait;
	}
});
