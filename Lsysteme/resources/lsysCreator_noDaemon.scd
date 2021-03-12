"make_lsys.scd".loadRelative;
"pdefCreator.scd".loadRelative;

~newLsys = { |name, axiom, rules, gen|
	var lsys = RedLSystem(axiom, rules), lsysPattern;
	gen.do { lsys.next };
	{lsysPattern = ~makeStream.(lsys)}.bench;
	~lsys.newPattern = lsysPattern;
	~lsys.presets[name] = ~lsys.presets[name] ?? {
		~lsys.defaultPreset.copy.put(\maxPatDur, lsysPattern.lastTimes.maxItem)
	};
	~makePdef.(name, lsysPattern);
};