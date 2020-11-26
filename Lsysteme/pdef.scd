Pbindef(\ctl,
	\legato, 0.95,
	\amp, 0.1,
	// \dur, Pkey(\baseTempo),
	\scale, Scale.harmonicMinor,
	\branchInterval, Pfunc { |ev| ev.scale.size },
	\stepInterval, 1,
	\noteOffset, Pfunc { |ev| ev.scale.size * -1 },
	\chanFunc, {|chanOffset myKey maxKey| chanOffset + myKey},
	\wrapLo, 36,
	\wrapHi, 96,
	\vols, [1, 1, 1, 1, 1, 1, 1]
);

~initGui = {
	~drawInstructions = List.new;
	// ~win = Window.new(bounds:Rect(0,0,2000,2000)).front;
	// ~win.view.background_(Color.white);
	// ~uview = UserView(~win, ~win.view.bounds);
	// ~uview.clearOnRefresh = false;
	~guiScale = 10;
};

~initGui.();

Pdef(\sp1,
	Pbind(\resetGui, Pfunc{|ev|
		if(ev.lsysReset.notNil){
			0//~streamNow = ~partSequencer.next;
		};
		0
	}) <>
	Ptpar([0, Pn(Plazy{ |evIn|
		Pspawner({ | sp |
			evIn[\stream].stream.do { |voiceEvent streamIndex|
				var startTime = voiceEvent.newTime,
				notes = voiceEvent.pitches,
				myKey = voiceEvent.myKey.asInteger,
				points = voiceEvent.points,
				// stepsTaken = voiceEvent.times.size,
				stepsTaken = voiceEvent.lastTime,
				placeInLevel = evIn[\stream].levelSteps[myKey].asArray.sort.indexOf(stepsTaken) ?? 0,
				newNote = voiceEvent.meltedList.flop[0],
				chars = voiceEvent.meltedList.flop[1],
				newRhy =  voiceEvent.meltedList.flop[2],
				myMidiChan = (myKey * 3) + placeInLevel; // hier muss ein limit ..;
				if(startTime > 0){
					sp.wait(startTime * evIn[\baseTempo]);
				};
				sp.par(
					Pbind(\type, \midi,
						\midiout, ~mOut,
						\cleanupFunc, {~mOut.clear},
						// \chan, evIn[\chanFunc].(chanOffset, myKey, maxKey), // damit immer erst die tiefen channels bedient werden
						\chan, myMidiChan,
						\rhyFactors, Pseq(newRhy),
						\dur, (Pkey(\baseTempo) * Pkey(\rhyFactors)),
						// \scale, Pkey(\scale), // in dieser Form nutzlos
						\clipVol, Pfunc { |ev| ev.vols.clipAt(myKey) },
						\charNow, Pseq(chars),
						\checkPause, Pfunc { |ev|
							if(ev.charNow == $G){Rest(ev.dur)}{0}
						},
						\getPoints, Pclump(Pkey(\rhyFactors), Pseq(points)),
						\draw, Pfunc { |ev|
							if(ev.checkPause.class != Rest){
								ev.getPoints.do { |p|
									~drawInstructions.add([p, myKey.linlin(0,5,0,1).asFloat]) //colors[myKey]
								};
							};
							0
						},
						\degree, Pkey(\noteOffset) +
						(Pseq(newNote) * Pkey(\stepInterval)) +
						(myKey * Pkey(\branchInterval)),
						\amp, Pkey(\amp) * Pkey(\clipVol) * Pfunc { |ev| ev.rhyFactors.lincurve(1,10, 0.5, 1, -2) } * 9, // je laenger die note desto lauter
						\finish, { |ev|
							ev.midinote = ev.midinote.wrap(ev.wrapLo, ev.wrapHi); // koennte individuell per key gestaltet werden
							ev
						}
					)
				);
			};
		})
	}, 1, \lsysReset),
	0.01, Pbind(
		\dur, Pkey(\baseTempo),
		\amp, Rest(),
		\drawAll, Pfunc {
			~drawInstructions.do { |p|
				var wp1 = (p[0][0]) * 5,  // ~win.bounds.bottom/2 oder so
				wp2 = (p[0][1]) * 5,
				branchLevel = p[1],
				// pdist = wp1.dist(wp2),
				oscMsg = (wp1.asArray ++ wp2.asArray).asInteger ++ branchLevel;
				~sendToProcessing.sendMsg('/lines', *oscMsg.postln); //M
			};
			~drawInstructions.clear;
			0
	})
	],inf) <> PtimeClutch(Pbindef(\ctl))
);