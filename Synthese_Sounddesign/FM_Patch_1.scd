(
o = Server.default.options;
o.device = "ASIO : ASIO Fireface USB";
Server.default.reboot;
)

// Für alle gleich
(
if(MIDIClient.initialized.not){
	MIDIClient.init;
	MIDIIn.connectAll;
};
~createSynthDictionary = { arg name, synthArgs, chan;
	var dict = ();
	dict.synthArgs = synthArgs;
	dict.synthName = name;
	dict.chan = chan;
	dict.synthSlots = Array.newClear(128);
	dict.setSynthArgsAndUpdateDictionary = { arg val, name;
		dict.synthArgs[name] = val;
		dict.synthSlots.collect{ arg syn;
			if(syn.notNil){
				if(syn.isRunning){
					syn.set(name, val)
				}
			}
		};
	};
	MIDIdef.noteOn(('on' ++ dict.name).asSymbol, {
		arg vel, num, chan, src;
		["note",chan,num,vel].postln;
		dict.synthArgs.note = num;
		dict.synthSlots[num] = Synth(dict.synthName, dict.synthArgs.asKeyValuePairs);
		NodeWatcher.register(dict.synthSlots[num]);
	}, chan: dict.chan);
	MIDIdef.noteOff(('off' ++ dict.name).asSymbol, { arg vel, num, chan, src;
		dict.synthSlots[num].set(\gate, 0)
	}, chan: dict.chan);
	// topEnvironment.put(name, dict);
	dict
};
)

// Hier per SynthDef ändern
(
var dict = ~createSynthDictionary.(
	name: \fm_1,
	chan: 0,
	synthArgs: (
		note: 60,
		vib_f: 0.2,
		vib_w: 0.01,
		mod1_amp: 2
	)
);
MIDIdef.cc(('knob1' ++ dict.name).asSymbol,{
	arg val, nr, src;
	dict[\setSynthArgsAndUpdateDictionary].(val.linexp(1,127,0.2,30), \vib_f);
	dict[\setSynthArgsAndUpdateDictionary].(val.linexp(1,127,0.01,0.02), \vib_w);
	dict[\setSynthArgsAndUpdateDictionary].(val.linexp(1,127,2,40), \mod1_amp);
},13);
MIDIdef.cc(('fader1' ++ dict.name).asSymbol,{
	arg val, nr, src;
	dict[\setSynthArgsAndUpdateDictionary].(val.linexp(1,127,0.001,0.2!2), \vol);
},77);
)



(SynthDef.new(\fm_1,
	{
		arg gate = 1;
		var note= \note.kr(60,0), vib_f = \vib_f.kr(0.2, 0.1), vib_w= \vib_w.kr(0.2, 0.1), mod1_ratio= \mod1_ratio.kr(2, 0.1), mod1_amp= \mod1_amp.kr(10, 0.1), amp_a= \amp_a.kr(0.2, 0.1), amp_d= \amp_d.kr(2, 0.1), amp_s= \amp_s.kr(0.5, 0.1), amp_r= \amp_r.kr(2, 0.1), amp_c= \amp_c.kr(3, 0.1), vol= \vol.kr(0.2, 0.1);

		var carrier_f, mod1_f, vibrato, modulator1, carrier, filter, adsr;

		// var vib_f = \vib_f.kr(0.2, 0.1);

		carrier_f= note.midicps; //wie konvertiere ich note zu hz

		vibrato=SinOsc.ar(vib_f, mul:carrier_f*vib_w);

		mod1_f=carrier_f*mod1_ratio;

		modulator1=SinOsc.ar(mod1_f, mul:carrier_f*mod1_amp);

		carrier=SinOsc.ar(carrier_f + vibrato + modulator1);

		filter=carrier;

		adsr= vol * filter * EnvGen.kr(
			Env.adsr(
				attackTime: amp_a,
				decayTime: amp_d,
				sustainLevel: amp_s,
				releaseTime: amp_r,
				curve: amp_c
			),
			gate: gate,
			doneAction:2);

		Out.ar([0,1],adsr);

}).add)

z=Synth(\FM1, ~synthArgs.asKeyValuePairs) //wie bekomme ich es mit MIDI direkt hin?
z.set(\gate, 0)

s.freeAll