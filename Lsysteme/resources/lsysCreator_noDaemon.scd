"make_lsys.scd".loadRelative;
~newLsys = { |axiom, rules, gen, useLastV = false|
	var lsys = RedLSystem(axiom, rules), lsysPattern;
	gen.do { lsys.next };
	{
		if(useLastV ?? false){
			lsysPattern = ~makeStream.(lsys, lastV: ~saveLastV);
		}{
			lsysPattern = ~makeStream.(lsys);
		}
	}.bench;
	~saveLastV = lsysPattern.lastVoice;
	~lsys.newPattern = lsysPattern;
	~lsys.list.add(lsysPattern);
	~lsys.argsList.add((axiom: axiom, rules: rules, gen: gen, useLastV: useLastV));
	case
	{~newLsysMode == \replace}{
		Pbindef(\opts,\part, Pseq([~lsys.list.last], inf));
	}
	{~newLsysMode == \add}{
		Pbindef(\opts,\part, Pseq(~lsys.list, inf));
	};
};