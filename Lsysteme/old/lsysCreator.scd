~addrBook = AddrBook.new;
~addrBook.addMe(\daemon);
~hail = Hail.new(~addrBook);
//~registrant = Registrant(~addrBook); // execute this on all clients
~objSpace = OSCObjectSpace(~addrBook, oscPath:'/lsysArgs').acceptEvents_(true);
~objSpace.addDependant({|objectSpace, what, key, val|
	if(key == \exit){
		0.exit
	};
	//"Received new lsys args %\n writing stream ... \n".postf(val);
	"writing stream .. ".postln;
	if(key == \lsys){
		var lsys = RedLSystem(val.axiom, val.rules), lsysPattern, lsysStream;
		val.gen.do { lsys.next };
		{
			if(val.useLastV ?? false){
				lsysPattern = ~makeStream.(lsys, lastV: ~saveLastV);
			}{
				lsysPattern = ~makeStream.(lsys);
			}
		}.bench;
		~saveLastV = lsysPattern.lastVoice;
		{
			lsysStream = lsysPattern.removeAt(\stream);
			lsysStream.do { |ev ix|
				ev.writeArchive(PathName.tmp +/+ "LSYSTEM_STREAM_" ++ ix);
			};
		}.bench;
		lsysPattern.streamSize = lsysStream.size;
		~objSpace[\lsysRes] = lsysPattern;
		"lsys stream written".postln;
	}
});

~makeStream = { |lsysString, theta = 51.43, lastV = nil|
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
		var newLastVoice;
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
				keyInit: 0 /// CHECK MAL OB DAS STIMMT WENN MEHRERE KOMBINIERT WERDEN
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

		voices[..maxCur].do{|v indx|
			v.data.lastTime = v.timeStep;
			collectVoices[indx].add(v.data)
		};
		// voices[maxCur..] = nil;
		newLastVoice = (
			pitch: voices[0].pitch,
			pointNow: voices[0].pointNow,
			oldPoint: voices[0].oldPoint
		);
		[collectVoices.reject(_.isEmpty), newLastVoice]
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