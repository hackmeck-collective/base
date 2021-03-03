"make_lsys.scd".loadRelative;
"pdefCreator.scd".loadRelative;
/*~newLsys = { |axiom, rules, gen, useLastPitch = false|
	var lsys = RedLSystem(axiom, rules), lsysPattern;
	gen.do { lsys.next };
	{
		if(useLastPitch ?? false){
			lsysPattern = ~makeStream.(lsys, startingPitch: ~lsys.saveLastPitch);
		}{
			lsysPattern = ~makeStream.(lsys);
		}
	}.bench;
	~lsys.saveLastPitch = lsysPattern.lastPitch;
	~lsys.newPattern = lsysPattern;
	~lsys.list.add(lsysPattern);
	~lsys.argsList.add((axiom: axiom, rules: rules, gen: gen, useLastPitch: useLastPitch));
	case
	{~lsys.integration == \replace}{
		Pbindef(\opts,\part, Pseq([~lsys.list.last], inf));
	}
	{~lsys.integration == \add}{
		Pbindef(\opts,\part, Pseq(~lsys.list, inf));
	};
};*/
~newLsys = { |name, axiom, rules, gen, useLastPitch = false|
	var lsys = RedLSystem(axiom, rules), lsysPattern;
	gen.do { lsys.next };
	{
		if(useLastPitch ?? false){
			lsysPattern = ~makeStream.(lsys, startingPitch: ~lsys.saveLastPitch);
		}{
			lsysPattern = ~makeStream.(lsys);
		}
	}.bench;
	~lsys.saveLastPitch = lsysPattern.lastPitch;
	~lsys.newPattern = lsysPattern;
	~lsys.list.add(lsysPattern);
	~lsys.argsList.add((name: name, axiom: axiom, rules: rules, gen: gen, useLastPitch: useLastPitch));
	~makePdef.(name, lsysPattern)
};