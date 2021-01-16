~makeStream = { |lsysString, theta = 20, lastV = nil|
	var newVoice = { | timeInit = 0, pitchInit = 0, pointInit = (Point(0, 0)), oldPointInit = (Point(0, 0)), keyInit|
		(
			timeStep: timeInit,
			incTime: {|self| self.timeStep = self.timeStep + 1},
			pitch: pitchInit,
			incPitch: {|self| self.pitch = self.pitch + 1},
			decPitch: {|self| self.pitch = self.pitch - 1},
			pointNow: pointInit,
			oldPoint: oldPointInit,
			incPoint: { |self|
				self.oldPoint = self.pointNow;
				self.pointNow = self.pointNow.translate(Point(0, -1).rotate((self.pitch * theta).degrad))
			},
			data: (chars: List.new, pitches: List.new, points: List.new, myKey: keyInit, firstTime: timeInit),
			addData: {|self charNow|
				self.incTime;
				self.incPoint;
				self.data.chars.add(charNow);
				self.data.pitches.add(self.pitch);
				self.data.points.add([self.pointNow, self.oldPoint]);
			}
		)
	};

	var benchPrint = { |func label|
		var res;
		("starting " ++ label).postln;
		{res = func.value}.bench;
		res
	};

	var searchStr = { |str, lastVoice = nil|
		var searchIndex = 0, cur = 0, maxCur = 0;
		var voices = nil!100;
		var collectVoices = (List.new)!100;
		var prevVoices = (List.new)!100;
		var charNow;
		var commands = (
			$[: {
				var oldVoice = voices[cur];
				prevVoices[cur].add(voices[cur]);
				cur = cur + 1;
				if(cur > maxCur){maxCur = cur};
				voices[cur] = newVoice.(
					oldVoice.timeStep,
					oldVoice.pitch,
					oldVoice.pointNow,
					oldVoice.oldPoint,
					cur
				);
			},
			$]: {
				voices[cur].data.lastTime = voices[cur].timeStep;
				collectVoices[cur].add(voices[cur].data);
				cur = cur - 1;
				voices[cur] = prevVoices[cur].pop;
			},
			$-: { voices[cur].decPitch },
			$+: { voices[cur].incPitch },
			$F: { voices[cur].addData(charNow) },
			$G: { voices[cur].addData(charNow) },
			$|: { voices[cur].addData(charNow) }
		);

		if(lastVoice.isNil){
			voices[0] = newVoice.(0, 0, keyInit: 0);
		}{
			voices[0] = newVoice.(
				0,
				lastVoice.pitch,
				lastVoice.pointNow,
				lastVoice.oldPoint,
			);
		};


		while ({(searchIndex < str.size)}, {
			var n;
			charNow = str[searchIndex];
			if(charNow.isDecDigit){
				n = charNow.digit;
				searchIndex = searchIndex + 1;
				while {str[searchIndex].isDecDigit}{
					n = (10 * n) + str[searchIndex].digit;
					searchIndex = searchIndex + 1;
				};
				charNow = str[searchIndex];
			}{
				n = 1;
			};
			n.do {
				commands[charNow].value;
			};
			searchIndex = searchIndex + 1;
		});

		searchIndex.postln;

		voices[..maxCur].do{|v indx|
			v.data.lastTime = v.timeStep;
			collectVoices[indx].add(v.data)
		};
		voices[maxCur..] = nil;

		[
			collectVoices.reject(_.isEmpty),
			voices[0].atAll([\pitch, \pointNow, \oldPoint]) // only the needed values, no open functions
		]

	};

	var meltList = { |listIn|
		var newList = List.new;
		//bei 0 sind pitches bei 1 sind chars
		newList.add([listIn[0][0], listIn[0][1], 1]);
		listIn.doAdjacentPairs { |last new|
			if(new[1] == $G){
				newList.add([new[0], new[1], 1])
			}{
				if((new[0] != last[0]) || (last[1] == $G)){
					newList.add([new[0], new[1], 1])
				}{
					newList.last[2] = newList.last[2] + 1 //dur verlaengern wenn letztes auch F war
				}
			}
		};
		newList
	};

	var editVoices = { |lsys|
		var startTimes = List.new, timesOrdered;
		var stringResult = searchStr.(lsys.asString, lastV);
		var voices = stringResult[0];
		var lastVoice = stringResult[1];
		var collectAgain = List.new;
		var maxKey = voices.size;
		var levelSteps = List.new;
		// Alle Startpunkte in eine Liste packen
		voices.do { |voiceLevel voiceIndex|
			levelSteps.add(Set.new);
			voiceLevel.do { |voice|
				// levelSteps.last.add(voice.times.size);
				levelSteps.last.add((voice.lastTime - voice.firstTime));
				// startTimes.add(voice.times[0] - 1);
				startTimes.add(voice.firstTime - 1);
				voice.meltedList = meltList.([voice.pitches, voice.chars].flop)
			}
		};

		timesOrdered = startTimes.quickOrder;

		startTimes = (startTimes[timesOrdered].differentiate);
		// mit den sortier indizes alle voices in der richtigen reihenfolge sammeln

		voices.flat[timesOrdered].do { |voice indx|
			voice.newTime = startTimes[indx];
			collectAgain.add(voice.copy);
		};
		// [maxKey, collectAgain, levelSteps, lastVoices];
		(maxKey: maxKey, stream: collectAgain, levelSteps: levelSteps, lastVoice: lastVoice)
	};
	editVoices.(lsysString);
};

Pbindef(\ctl,
	\legato, 0.95,
	\amp, 0.1,
	\baseTempo, 1/4,
	// \dur, Pkey(\baseTempo),
	\scale, Scale.harmonicMinor,
	\branchInterval, Pfunc { |ev| ev.scale.size },
	\stepInterval, 1,
	\noteOffset, Pfunc { |ev| ev.scale.size * -1 },
	\chanFunc, {|chanOffset myKey maxKey| chanOffset + myKey},
	\wrapLo, 36,
	\wrapHi, 88,
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
		// ev.lsysReset.postln;
		if(ev.lsysReset.notNil){
			// ~nextPart = ~choosePart.next;
			// {~uview.clearDrawing}.fork(AppClock)
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
						\scale, Pkey(\scale), // in dieser Form nutzlos
						\clipVol, Pfunc { |ev| ev.vols.clipAt(myKey) },
						\charNow, Pseq(chars),
						\checkPause, Pfunc { |ev|
							if(ev.charNow == $G){Rest(ev.dur)}{0}
						},
						\getPoints, Pclump(Pkey(\rhyFactors), Pseq(points)),
						\draw, Pfunc { |ev|
							if(ev.checkPause.class != Rest){
								ev.getPoints.do { |p|
									~drawInstructions.add([p, myKey.linlin(0,5,0,1)]) //colors[myKey]
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
			/*			{
			~uview.drawFunc = {
			Pen.width = 2;
			Pen.translate(1000,1000);
			~drawInstructions.do { |p|
			var wp1 = (p[0][0] * ~guiScale).wrap(-1000, 1000),  // ~win.bounds.bottom/2 oder so
			wp2 = (p[0][1] * ~guiScale).wrap(-1000, 1000),
			pdist = wp1.dist(wp2),
			oscMsg = (wp1.asArray ++ wp2.asArray).asInteger + 500;
			~sendToProcessing.sendMsg('/lines', *oscMsg.postln); //M
			if(abs(pdist) < (~guiScale * 2)){ // wenn es springt nicht zeichnen
			Pen.strokeColor = p[1];
			Pen.line(
			wp1,
			wp2
			);
			Pen.stroke;
			}
			};
			~drawInstructions.clear;
			};
			~uview.refresh;
			}.fork(AppClock);*/
			0
	})
	],inf) <> PtimeClutch(Pbindef(\ctl))
);