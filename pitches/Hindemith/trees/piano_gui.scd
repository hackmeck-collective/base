~startPiano = (
	init: {|self, startChord|
		//self.win = Window("PianoLayout", Rect(0, 200, 710, 150)).front;
		// sort black before white keys so we draw them on top
		self.layouts = Piano.layout(36, 84).sort { |a, b| a.color > b.color };
		// draw MPadViews as keys
		self.pianoKeys = self.layouts.collect { |ev|
			var color = Color.perform(ev.color);
			var height = ev.h * 60;
			var rect = Rect(ev.x + (1-ev.w/2) * 24 + 4 + 600, 4 + 300, 24 * ev.w, height).postln;
			var pad = MPadView(/*self.win, rect*/w,rect).mode_(\noteOnOff);
			pad.baseColor_(color).hiliteColor_(Color(0.9, 0, 0.7, 0.85)); //.label_(ev.note);
		};
		self.keyIndex = self.layouts.collect{|in| in.asArray}.flop[2].order;
		self.showKeys(startChord ? [0, 4, 7]);
	},
	showKeys: { |self, chosenKeys|
		{
			self.lastChosenKeys !? {
				self.lastChosenKeys.do {|nn|
					self.pianoKeys[self.keyIndex[nn]].valueAction = 0
				};
			};
			chosenKeys.do {|nn|
				self.pianoKeys[self.keyIndex[nn]].valueAction = 1
			};
			self.lastChosenKeys = chosenKeys
		}.defer
	};
)



	