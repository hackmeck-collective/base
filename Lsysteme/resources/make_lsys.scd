~makeStream = { |lsysString, theta = 51.43, lastV = nil|
	var idMaker = Pseries().asStream;
	var newVoice = {
		arg timeInit = 0,
		pitchInit = 0,
		pointInit = (Point(0, 0)),
		oldPointInit = (Point(0, 0)),
		keyInit,
		parentId;
		var myId = idMaker.next();
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
			data: (
				chars: List.new,
				pitches: List.new,
				points: List.new,
				myKey: keyInit,
				firstTime: timeInit,
				myId: myId,
				parentId: parentId
			),
			addData: {|self charNow|
				self.incTime;
				self.incPoint;
				self.data.chars.add(charNow);
				self.data.pitches.add(self.pitch);
				self.data.points.add([self.pointNow, self.oldPoint]);
			}
		)
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
				maxCur = maxCur.max(cur);
				voices[cur] = newVoice.(
					oldVoice.timeStep,
					oldVoice.pitch,
					oldVoice.pointNow,
					oldVoice.oldPoint,
					cur,
					oldVoice.data.myId //(1..cur).collect {|num|	prevVoices[num].size} // vom Parent, daher - 1
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
			voices[0] = newVoice.(0, 0, parentId: 0, keyInit: 0);
		}{
			voices[0] = newVoice.(
				0,
				lastVoice.pitch,
				lastVoice.pointNow,
				lastVoice.oldPoint,
				parentId: 0,
				keyInit: 0
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

		// die root stimme hinzufuegen
		voices[0].data.lastTime = voices[0].timeStep;
		collectVoices[0].add(voices[0].data);

		newLastVoice = (
			pitch: voices[0].pitch,
			pointNow: voices[0].pointNow,
			oldPoint: voices[0].oldPoint
		);
		[collectVoices.reject(_.isEmpty), newLastVoice]
	};

	var stringToObject = { |lsys|
		var stringResult = searchStr.(lsys.asString, lastV);
		var voices = stringResult[0];
		var lastVoice = stringResult[1];
		var startTimes = voices.collect{|branch| branch.collect{|v| v.firstTime}}.flat;
		var timesOrdered = startTimes.order;
		(
			maxKey: voices.size,
			stream: voices.flat[timesOrdered],
			lastVoice: lastVoice,
			startTimes: startTimes[timesOrdered].differentiate
		)
	};
	stringToObject.(lsysString);
};