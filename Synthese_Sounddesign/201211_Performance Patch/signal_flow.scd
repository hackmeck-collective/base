~source_group ?? {~source_group = Group.new};
~sc_group ?? {~sc_group = Group.after(~source_group)};
~bus_group ?? {~bus_group = Group.after(~sc_group)};
~effect_group ?? {~effect_group = Group.after(~bus_group)};
~master_group ?? {~master_group = Group.tail};
~melody_bus ?? {~melody_bus = Bus.audio(s,2)};
~chords_bus ?? {~chords_bus = Bus.audio(s,2)};
~drums_bus ?? {~drums_bus = Bus.audio(s,2)};
~aux_bus ?? {~aux_bus = Bus.audio(s,2)};
~instruments_bus ?? {~instruments_bus = Bus.audio(s,2)};
~effect_bus ?? {~effect_bus = Bus.audio(s,2)};
~master ?? {~master = Bus.audio(s,2)};
~sidechain_bus ?? {~sidechain_bus = Bus.control(Server.default, 1)};

SynthDef(\melody_bus, {
    var melody_bus_in, sidechain;

	var sidechain_trigger = Lag.kr(
		In.kr(
			~sidechain_bus,
			3),
		0.1);

	melody_bus_in = In.ar(~melody_bus, 2);

	sidechain = melody_bus_in * sidechain_trigger[0];

	Out.ar(~instruments_bus, sidechain);

}).add;

SynthDef(\chords_bus, {
    var chords_bus_in, sidechain;

	var sidechain_trigger = Lag.kr(
		In.kr(
			~sidechain_bus,
			3),
		0.1);

	chords_bus_in = In.ar(~chords_bus, 2);

	sidechain = chords_bus_in * 1-sidechain_trigger;

	Out.ar(~instruments_bus, sidechain);

}).add;

SynthDef(\drums_bus, {
    var drums_bus_in;

	drums_bus_in = In.ar(~drums_bus, 2);

	Out.ar(~instruments_bus, drums_bus_in);

}).add;

SynthDef(\aux_bus, {
    var aux_bus_in;

	aux_bus_in = In.ar(~aux_bus, 2);

	Out.ar(~instruments_bus, aux_bus_in);

}).add;

SynthDef(\instruments_bus, {
    var instruments_bus_in;

	instruments_bus_in = In.ar(~instruments_bus, 2);

	Out.ar(~master, instruments_bus_in);

}).add;

SynthDef(\effect_bus, {
    var effect_bus_in;

	effect_bus_in = In.ar(~effect_bus, 2);

	Out.ar(~master, effect_bus_in);

}).add;

SynthDef(\Master, {
    var master_in, soft_clip, hard_clip, sig;

	sig = In.ar(~master, 2);

	// sig = sig / (1+ sig.abs)
	//
	// sig = (1.5 * sig) - (0.5 * sig.cubed);

	sig = tan(sig);

	Out.ar([0,1], sig);

}).add;

s.sync;

z = Synth.new(\Master,target: ~master_group);
y = Synth.new(\effect_bus,target: ~effect_group);
x = Synth.new(\instruments_bus,target: ~bus_group);
w = Synth.new(\melody_bus,target: ~source_group);
v = Synth.new(\chords_bus,target: ~source_group);
u = Synth.new(\drums_bus,target: ~source_group);
t = Synth.new(\aux_bus,target: ~source_group);
/*s = Synth.new(\sc_bus,target: ~sc_group);
r*/
