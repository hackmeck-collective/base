"make_lsys.scd".loadRelative;
"pdefCreator.scd".loadRelative;

~newLsys = { |name, axiom, rules, gen, usePreset, useLastPitch = false|
	var lsys = RedLSystem(axiom, rules), lsysPattern;
	gen.do { lsys.next };
	{lsysPattern = ~makeStream.(lsys)}.bench;
	~lsys.saveLastPitch = lsysPattern.lastPitch;
	~lsys.newPattern = lsysPattern;
	~lsys.list.add(lsysPattern);
	~lsys.argsList.add((name: name, axiom: axiom, rules: rules, gen: gen, useLastPitch: useLastPitch));
	~ctlPresets[name] = ~ctlPresets[name] ?? { ~ctl.copy }; //usePreset ?? { () };
	~makePdef.(name, lsysPattern);
};