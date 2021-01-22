OSCdef(\oct, { |msg|
	var index =	msg[1].asString.last.digit - 1,
	lo =  24 + (msg[2] * 12),
	hi =  36 + (msg[3] * 12);
	Pbindef(\ctl).source.at(\wrapLo).source.put(index, lo);
	Pbindef(\ctl).source.at(\wrapHi).source.put(index, hi);
}, "/oct").permanent_(true);

OSCdef(\leg, { |msg|
	var index =	msg[1].asString.last.digit - 1;
	Pbindef(\ctl).source.at(\legato).source.put(index, msg[2]);
}, "/leg").permanent_(true);
