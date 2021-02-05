~pr = (
	replaceTxt: { |self txt selSize|
		var boiler = 4; // "~pr." sind 4 zeichen
		selSize = selSize + boiler;
		// var selSize = txt.size.postln + boiler;
		Document.current.selectionStart;
		Document.current.string_(
			txt,
			Document.current.selectionStart - selSize,
			selSize
		)
	},
	addEntry: { |self sym txt|
		self[sym] = { |self|
			self.replaceTxt(txt, sym.asString.size);
		}
	}
);

~pr.addEntry(\busch, "~objSpace[\\lsys] = (
	axiom: \"F\",
	rules: ( $F: \"FF+[+F-F-F]-[-F+F+F[F--FFFFF]]\" ),
	gen: 2.0,
	useLastV: false
)");

~pr.addEntry(\busch2, "~objSpace[\\lsys] = (
	axiom: \"F\",
	rules: ( $F: \"FF+[+F-F-F]-[-F+F+F]\" ),
	gen: 2.0,
	useLastV: false
)");

~pr.addEntry(\chaos,"
{
	[\"F\", \"---F\", \"----F\", \"--F\"].do { |ax indx|
		~objSpace[\\lsys] = (
			axiom: ax,
			rules: ( $F: \"F+++F[-FGG++FF[-F]]----FG+FF\", $G: \"GG\" ),
			gen: 2.0,
			useLastV: (indx > 0)
		);
		~newObjUnhang.wait;
	};
}.fork;
");

~pr.addEntry(\pausen,"
{
	~pausen = List.new;
	[\"F-G\",\"++F-G\",\"4-F-G\"].do { |ax indx|
		~objSpace[\\lsys] = (
			axiom: ax,
			rules: ( $F: \"FG[2F-3G2F4+F]F5|\", $G: \"GGF\" ),
			gen: 3.0,
			useLastV: (indx > 0)
		);
		~newObjUnhang.wait;
		~pausen.add(~lsys.newPattern);
	};
}.fork;
Pbindef(\\opts, \\part, Pseq(~pausen, inf));
Pbindef(\\opts, \\baseTempo, 3/17); // dann hat man direkt eine gute quantisierung
");


~pr.addEntry(\pentagon,"
~objSpace[\\lsys] = (
	axiom: \"F-F-F-F-F\",
	rules: ( $F: \"F[F]-F+F[--F]+F-F\" ),
	gen: 2.0,
	useLastV: false
)

{
	~pentagon = List.new;
	[\"F\",\"-F\",\"-F\",\"-F\",\"-F\"].do { |ax indx|
		~objSpace[\\lsys] = (
			axiom: ax,
			rules: ( $F: \"F[F]-F+F[--F]+F-F\" ),
			gen: 2.0,
			useLastV: (indx > 0)
		);
		~newObjUnhang.wait;
		~pentagon.add(~lsys.newPattern);
	};
}.fork;
~lsys.newPattern
Pbindef(\\opts, \\part, Pseq(~pentagon, inf));
Pbindef(\\opts, \\baseTempo, 1/5); // dann hat man direkt eine gute quantisierung
");

~pr.addEntry(\seqPausen,"
~objSpace[\\lsys] = (
	axiom: \"F-F-F-F\",
	rules: ( $F: \"FG[-F--F-F]F\", $G: \"GGGFG\" ),
	gen: 4.0,
	useLastV: false
)
~seqPausen.clear
{
	~seqPausen = List.new;
	[\"F\",\"-F\",\"-F\",\"-F\"].do { |ax indx|
		~objSpace[\\lsys] = (
			axiom: ax,
			rules: ( $F: \"FG[-F--F-F]F++|||||\", $G: \"GGFG\" ),
			gen: 3.0,
			useLastV: (indx > 0)
		);
		~newObjUnhang.wait;
		~seqPausen.add(~lsys.newPattern);
	};
}.fork;
Pbindef(\\opts, \\part, Pseq(~seqPausen, inf));
// ~seqPausen[0].stream[0].lastTime / aussuchen
// ~seqPausen[0].stream.last.lastTime / aussuchen
Pbindef(\\opts, \\durCalc, \waitAll); //
Pbindef(\\opts, \\baseTempo, 1 / 8); // dann hat man direkt eine gute quantisierung
");

~pr.addEntry(\poly,"
{
	~polyDing = List.new;
	[\"F\",\"-F\",\"-F\",\"-F\"].do { |ax indx|
		~objSpace[\\lsys] = (
			axiom: ax,
			rules: ( $F: \"F-F+2F[--F-2F]5F\" ),
			gen: 3.0,
			useLastV: (indx > 0)
		);
		~newObjUnhang.wait;
		~polyDing.add(~lsys.newPattern);
	};
}.fork;
~polyDing[0].stream[0].lastTime / 13

Pbindef(\\opts, \\part, Pseq(~polyDing, inf));
Pbindef(\\opts, \\durCalc, \\noWait); //
Pbindef(\\opts, \\baseTempo, 1 / 13); // dann hat man direkt eine gute quantisierung
");