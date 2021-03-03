(
~useDaemon = false;
~localSetup = true;
"resources/globals.scd".loadRelative;
"resources/pdef.scd".loadRelative; // load pdef which will play back lsystems
"resources/lsys_dict_text_replace.scd".loadRelative;
"resources/oscDefs.scd".loadRelative;

if(~useDaemon){
	// brauch ueberarbeitung weil die points rausgefallen sind und wegen starting pitch als int
	"resources/startDaemon.scd".loadRelative; // resources to communicate with sclang daemon
}{
	"resources/lsysCreator_noDaemon.scd".loadRelative;
};
)
~ctl.scale  = 4.collect { |i| ~objSpace_philipp[\pitches] + (i * 12) }.flat.sort
~addrBook.peers
~targetServer.latency
~targetServer = Server(
	\benni2,
	NetAddr(~addrBook.at(\Benni).addr.ip, 57110),
	ServerOptions.new().maxLogins_(4),
	1
);
l.tempo
l.isSyncingMeter
~objSpace_philipp[\pitches]
~ctl.noteOffset =  36
[~presets_benni[\variedLeads].values,
~presets_benni[\variedPlucks].values
].flop.do(_.postln)
~ctl.scale = Scale(~objSpace_philipp[\pitches])

~ctl.branchInterval = 7

~ctl.branchInterval = -7

~presets_benni.getPairs
~objSpace_benni[\synthDefs].do(_.postln)
~presets_benni[~ctl.presetName].envelope_mod = 0.3
~presets_benni[~ctl.presetName].vol = 0.03
~presets_benni[~ctl.presetName].send_1_level = 1
~ctl.instrument = [\pluck_fm_pulsar_shelvedOverdriveSoft_noFilter]

~ctl.instrument = [ \pluck_slide_fm_shelvedOverdriveSoft_lpf_moog, \pluck_fm_fm_shelvedOverdriveSoft_lpf_moog, \pluck_unisonoDetune_pulsar_shelvedOverdriveSoft_lpf_moog, \pluck_slide_pulsar_shelvedOverdriveSoft_lpf_moog,  \pluck_unisonoDetune_fm_sampleRateReduction_noFilter, \pluck_unisonoDetune_fm_shelvedOverdriveSoft_lpf_moog, \pluck_fm_pulsar_shelvedOverdriveSoft_lpf_moog ]

~presets_benni[\variedPlucks].vol
(Pbind(\server, ~targetServer,
	\instrument, \pluck_slide_fm_shelvedOverdriveSoft_lpf_moog,
	\sendGate, false,
	\group,  Pfunc {~objSpace_benni[\sourceGroup]},
	//\controlbus, Pfunc { ~objSpace_benni[\launchcontrol_xl_row_4]},
	\out, Pfunc {~objSpace_benni[\melodyBus]},
	\vol, 0.5,
	//\legato, 1,
	\dur, 1,
	// \envelope_mod, 1,
	\note, Pwhite(-12, 12),
	\finish, {|ev| ev.keysValuesDo{|k, v| [k, v].postln }}
	// \degree, -1,/
) <> ~presets_benni[\variedPlucks]).play(l, quant:0)


SynthDescLib.at(\lead_unisonoDetune_fm_noFx_noFilter);
x = Synth(\pluck_fm_fm_shelvedOverdriveSoft_lpf_moog, [\vol, 1],target: ~targetServer)

Pbind(\server, ~targetServer,
	\instrument, \default,
	\group, Pfunc {~objSpace_benni[\sourceGroup]},
	\out, Pfunc {~objSpace_benni[\melodyBus]},
	\vol, 0.5,
	\legato, 0.25, \dur, 2,
	//\sendGate, false,
	\finish, { |ev| ev.postln }
).play(l)

~objSpace_benni[\synthDefs]

~objSpace_benni.keys.do { |k|
	~ctl[k] = ~objSpace_benni[k]
}

[
	\lead_slide_basic_overdriveSoft_lpf_moog,
	\pluck_vibrato_fm_overdriveSoft_lpf_moog,
	\pluck_vibrato_fm_overdriveSoft_lpf_moog
]


\adsrType, \pluck,
\pitchOp, Pseq([\slide, \fm, \unisonoDetune], inf),
\osc, Pseq([\pulsar, \fm], inf),
\fx, \shelvedOverdriveSoft,
\filter, \lpf_moog,
\instrument, Pfunc {|ev| "%_%_%_%_%".format(ev.adsrType, ev.pitchOp, ev.osc, ev.fx, ev.filter).asSymbol },