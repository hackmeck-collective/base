~muteGroups = ();
~softLimit = 2;
~hardLimit = 5;
~strategies = (
	\oldest: {
		|playing, current|
		playing.minItem({ |e| e.startTime })
	},
	\newest: {
		|playing, current|
		playing.maxItem({ |e| e.startTime })
	},
	\nearest: {
		|playing, current|
		playing.minItem({
			|e|
			(e.use(_.freq) - current.use(_.freq)).abs
		})
	},
	\random: {
		|playing, current|
		playing.choose
	}
);

Pdef(\pattern, Pbind(
	\dur, 1/4,
	\degree, Prand([0, 2, 5, 7, 10], inf),
	\octave, Pseq([3, 4, 5], inf),
	\muteGroup, \a,
	\release, 3,
	\sustain, 10,
	\sendGate, false,
));

Pdef(\muteGroup).clear;
Pdef(\muteGroup, Pfunc({
	|event|
	var voiceToFree, voices = ~muteGroups[event.muteGroup];

	event[\startTime] = thisThread.clock.beats;

	voices = voices.select(_[\isPlaying]); // purge any non-playing voices
	while { voices.size > (~softLimit - 1) } {
		voiceToFree = ~strategies[\random].(voices, event);
		if (voices.size > (~hardLimit - 1)) {
			"Way too many voices, freeing voice at %".format(voiceToFree.nodeID).postln;
			voiceToFree.free; // free immediately
		} {
			"Gating voice at %".format(voiceToFree.nodeID).postln;
			voiceToFree.set(\gate, 0); // let envelope free in due course
		};
		voices.remove(voiceToFree);
	};

	voices = voices.add(event);
	~muteGroups[event.muteGroup] = voices;

	event; // pass the event along
}));


Pdef(\player, Pdef(\muteGroup) <> Pdef(\pattern)).play;