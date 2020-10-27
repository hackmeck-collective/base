o = Server.default.options;
o.device = "ASIO : ASIO Fireface USB";
Server.default.reboot;

s.boot

(SynthDef.new(\puls2,
	{
		arg bpm=50, baserate=0.56543, scale=10, modsinerange=25, number=5;

		var bpmfreq, modnumber, modsine, puls, pulssound, filter;

		bpmfreq=bpm/120;

		modnumber=(1..10);

		modsine=SinOsc.ar(baserate*((modnumber*scale)+1),0,modsinerange,modsinerange);

		puls=LFPulse.ar(bpmfreq*modsine,0,0.01,0.2);

		pulssound=BPF.ar(PinkNoise.ar,SinOsc.ar(0.3,0,puls*modsine)*2000,0.01);

		filter=Clip.ar(HPF.ar(pulssound,1,0.0000000000000000000001),-0.9,0.9);

		Out.ar([0,1],filter);

}).add)

MIDIIn.connectAll;
MIDIClient.init;

z=Synth(\puls2)

( //Midi Belegung P01 [bpm / scale / modsinerange / baserate]
(MIDIdef.cc(\bpm,{
	arg val, nr, src;

	[val,nr,src].postln;
	z.set(\bpm,val.linexp(1,127,0.1,5000));

},74))

(MIDIdef.cc(\scale,{
	arg val, nr, src;

	[val,nr,src].postln;
	z.set(\scale,val.linexp(1,127,0.5,5000));

},71))

(MIDIdef.cc(\modsinerange,{
	arg val, nr, src;

	[val,nr,src].postln;
	z.set(\modsinerange,val.linexp(1,127,0.5,5000));

},91))

(MIDIdef.cc(\baserate,{
	arg val, nr, src;

	[val,nr,src].postln;
	z.set(\baserate,val.linexp(1,127,0.01,5000));

},93))
)