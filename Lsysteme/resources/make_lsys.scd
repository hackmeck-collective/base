~makeStream = { |lsysString|
	var idMaker = Pseries().asStream;
	var newVoice = {|timeInit = 0, pitchInit = 0, keyInit, parentId|
		var myId = idMaker.next();
		(
			timeStep: timeInit,
			incTime: {|self| self.timeStep = self.timeStep + 1},
			pitch: pitchInit,
			incPitch: {|self| self.pitch = self.pitch + 1},
			decPitch: {|self| self.pitch = self.pitch - 1},
			data: (
				chars: List.new,
				pitches: List.new,
				myKey: keyInit,
				firstTime: timeInit,
				myId: myId,
				parentId: parentId
			),
			addData: {|self charNow|
				self.incTime;
				self.data.chars.add(charNow);
				self.data.pitches.add(self.pitch);
			}
		)
	};

	var searchStr = { |str|
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
				maxCur = maxCur.max(cur);
				voices[cur] = newVoice.(
					oldVoice.timeStep,
					oldVoice.pitch,
					cur,
					oldVoice.data.myId
				);
			},
			$]: {
				voices[cur].data.lastTime = voices[cur].timeStep;
				if(voices[cur].data.chars.notEmpty){
					collectVoices[cur].add(voices[cur].data);
				};
				cur = cur - 1;
				voices[cur] = prevVoices[cur].pop;
			},
			$-: { voices[cur].decPitch },
			$+: { voices[cur].incPitch },
			$F: { voices[cur].addData(charNow) },
			$G: { voices[cur].addData(charNow) },
			$|: { voices[cur].addData(charNow) }
		);

		// make root voice
		voices[0] = newVoice.(0, 0, parentId: 0, keyInit: 0);

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

		// die root stimme hinzufuegen
		voices[0].data.lastTime = voices[0].timeStep;
		if(voices[0].data.chars.notEmpty){
			collectVoices[0].add(voices[0].data);
		};

		collectVoices.reject(_.isEmpty)
	};

	var stringToObject = { |lsys|
		var voices = searchStr.(lsys.asString);
		var startTimes = voices.collect{ |branch| branch.collect { |v| v.firstTime} }.flat;
		var lastTimes = voices.collect{ |branch| branch.collect { |v| v.lastTime} }.flat;
		var timesOrdered = startTimes.order;
		(
			maxKey: voices.size,
			stream: voices.flat[timesOrdered],
			startTimes: startTimes[timesOrdered],
			lastTimes: lastTimes[timesOrdered]
		)
	};
	stringToObject.(lsysString);
};