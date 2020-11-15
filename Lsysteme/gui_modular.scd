(
g = ();
g[\makeLsys] = {
	g.lsys = RedLSystem(g.ax.value, g.ru.value);
	g.num.value.do { g.lsys.next };
	g.lt = RedLTurtle.new(g.lsys, 40, g.theta.value, scale: g.sc.value);
	g.tmpW !? { g.tmpW.close };
	g.tmpW = g.lt.makeWindow(bounds: Rect(1000,0,2000,2000), initTranslate: Point(g.init1.value, g.init2.value));
};
g[\printCode] = {
	var convertRules = ();
	var file = File.open(PathName(Document.current.path).pathOnly ++ "lsys_dict_modular.scd", "a");
	var newString;
	g.ru.value.keysValuesDo { |k v| convertRules[k] = v.reduce(_++_)};
	newString = "~lsys = RedLSystem(%, %);\n %.do { ~lsys.next };".format(g.ax.value.reduce(_++_).asCompileString, convertRules.asCompileString, g.num.value).postln;
	file.write("\n" ++ newString);
	file.close;
};
g.win = Window.new(bounds: Rect(0,0,1000,1000)).front;
g.win.view.decorator = FlowLayout(g.win.view.bounds, gap: 20@20);
g.ax = EZText(g.win, 980@50,"axiom", textWidth: 900,layout:\horz, initVal: "F");
g.ru = EZText(g.win,980@50,"rules", textWidth: 900,layout:\horz, initVal: ($F: "F+F[-F]F"));
g.num = EZNumber(g.win, Rect(0,0,150,60),label: "gens", controlSpec: [0,100], initVal: 0);
g.init1 = EZNumber(g.win, Rect(0,0,150,60),label: "init 1", controlSpec: [-2,2], initVal: 0.5);
g.init2 = EZNumber(g.win, Rect(0,0,150,60),label: "init 2", controlSpec: [-2,2], initVal: 0.5);
g.guiScale = EZNumber(g.win, Rect(0,0,150,60),label: "guiScale", controlSpec: [2, 40, 'lin', 1], initVal: 10);
g.theta = EZNumber(
	g.win, Rect(0,0,150,60),label: "theta", controlSpec: [1,360,\lin,0.01], initVal: 51.43 // 360 / 7
).action_(g[\makeLsys]);
g.win.view.decorator.nextLine;
g.sc = EZSlider(g.win, Rect(0,0,500, 60), "scale", [0.1,3], action: g[\makeLsys],initVal:1);
g.win.view.decorator.nextLine;
Button(g.win, Rect(width:200, height: 50))
.string_("make window")
.action_(g[\makeLsys]);
Button(g.win, Rect(width:200, height: 50))
.string_("print code")
.action_(g[\printCode]);
Button(g.win, Rect(width:200, height: 50))
.string_("use for sound")
.action_({
	//g.lsys !? {
	//g.newStream = ~makeStream.(g.lsys, g.theta.value);
	// ~makePdef.(1, g.newStream, guiScale: g.guiScale.value);
	// u.clearDrawing;
	// }
});
g.win.view.decorator.nextLine;
g.presetMenu = EZPopUpMenu.new(g.win,Rect(0,0,200,60),"load Preset");
PathName("/home/vincent/SC/pieces/uns_trio/presets/").files.collect{|f|
	var key = f.fileNameWithoutExtension,
	pr =  Object.readArchive(f.absolutePath);
	g.presetMenu.addItem(key, {
		g.ax.value = pr[\axiom];
		g.ru.value = pr[\rules];
		g.num.value = pr[\gen];
	})
};
)