(
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
	MIDIdef.noteOn(('on' ++ name).asSymbol, {
		arg vel, num, chan, src;
		["note",chan,num,vel].postln;
		dict.synthArgs.note = num;
		dict.synthSlots[num] = Synth(dict.synthName, dict.synthArgs.asKeyValuePairs);
		NodeWatcher.register(dict.synthSlots[num]);
	}, chan: dict.chan).permanent_(true);
	MIDIdef.noteOff(('off' ++ name).asSymbol, { arg vel, num, chan, src;
		dict.synthSlots[num].set(\gate, 0)
	}, chan: dict.chan).permanent_(true);
	// topEnvironment.put(name, dict);
	dict
};

MIDIdef.cc('cc_monitor',
{
	arg vel, num, chan, src;
	["cc",chan,num,vel,src].postln;
}).permanent_(true);

"functions loaded".postln;
)