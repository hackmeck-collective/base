//Macht Listen mit Events, die RootNote und Listen haben.
//MultiLevelIdentityDictionary macht hier den Unterschied

(
"resources.scd".loadRelative;
~calcAll = { |dissDegree, numNotes, maxUpper|
	var inputs = merge(
		~dissDegreeConstraints[dissDegree],
		(numNotes: numNotes, maxUpperNoteWhenBaseIs0: maxUpper)
	);
	var outputs;
	if(dissDegree <= 9){outputs = ~getListComprehension.valueWithEnvir(inputs).all};
	if(dissDegree == 10) { //A ohne Tritonus V Unbestimmbar
		var events;
		if (numNotes == 3) { events = [( 'rootNote': 0, 'list': [ 0, 4, 8 ] ), ( 'rootNote': 10, 'list': [ 0, 5, 10 ] ) ] };
		if (numNotes == 4) { events = [ ( 'rootNote': 0, 'list': [ 0, 4, 8, 12 ] ), ( 'rootNote': 3, 'list': [ 0, 5, 10, 15 ] ) ] };
		if (numNotes == 5) { events = [ ( 'rootNote': 0, 'list': [ 0, 4, 8, 12, 16 ] ), ( 'rootNote': 8, 'list': [ 0, 5, 10, 15, 20 ] ) ] };
		outputs = events;
	};
	if(dissDegree == 11) { // B mit Tritonus VI Unbestimmbar Tritonus übergeordnet
		var timesThree = Array.series((maxUpper / 3).trunc.asInteger + 1, 0, 3);
		var arrayOfLists = timesThree.powerset.select({
			arg item;
			item.size == numNotes && ((item.mod(12).asSet.size >= 3) && item.includes(0))
		});
		var arrayOfEventsWithLists = [];
		arrayOfLists.do({ arg item;
			arrayOfEventsWithLists = arrayOfEventsWithLists.add((list: item, rootNote: 0))
		});
		outputs = arrayOfEventsWithLists;
	};
	outputs
};

~dissDegreesAll = (0..11);
~numNotesAll = [3, 4, 5]; //Chordsize
~maxUpper = 36; // Ambitus, 36 dauert ca. 3 Min
// beachten: da alle ergebnisse nochmal mit den offsets (1..11) vervielfacht werden
// ist der tatsaechliche wert fuer maxUpper 11 hoeher
)

// calculate all dissDegrees for all different number of notes
(
{
	var result = MultiLevelIdentityDictionary.new;
	"calculate all list comprehesions".postln;
	~numNotesAll.do { |nn|
		("\tnumNotes " ++ nn).postln;
		~dissDegreesAll.do { |deg|
			var newCalc = ~calcAll.(
				dissDegree: deg,
				numNotes: nn,
				maxUpper: ~maxUpper
			);
			result.put(\numNotes, nn, \dissDegrees, deg, newCalc);
			("\t\tdissDegree: " ++ deg ++ " size " ++ newCalc.size ++ " ...").postln;
		}
	};
	~res = result;
}.bench
)

// inspection
~res[\numNotes, 3, \dissDegrees, 11]; //rootNote doesn’t work here

// copy and offset rootnote and list for every note
(
{
	var offset = (1..11);
	var result = ();
	offset.do { |i|
		("copy with offset ..." ++ i).postln;
		result[i] = ~res.deepCopy;
		result[i].treeDo({}, {|lf eventArr|
			var eventArrOffset = eventArr.collect {|ev|
				(rootNote: ev.rootNote !? {(ev.rootNote + i) % 12}, list: ev.list + i)
			};
			result[i].putAtPath(lf, eventArrOffset)
		})
	};
	~rootOffsets = result;
}.bench
)

//inspection: ~rootOffsets[rootNote][\key, value, \key, value]
~rootOffsets[1][\numNotes, 4, \dissDegrees, 3];

// make kdtrees for all numNotes and all rootNote and all dissDegree
//Die Idee ist jetzt die Rootnote in die Adresse mit hineinzubringen. Aus den Listen mit den Events werden Objekte (mit Namen kdtree). Der Vorteil ist, dass man schnell darin suchen kann.
(
{
	var kdTrees = MultiLevelIdentityDictionary.new;

	"fill lists with values from ~res and ~rootOffsets ...".postln;
	([~res] ++ ~rootOffsets).do { |res|
		res.treeDo({}, {|lf eventArr|
			eventArr.do {|ev|
				var addr = [\numNotes, lf[1], \rootNote, ev.rootNote ? \noRootNote, \dissDegrees, lf[3]]; //weil nil als key in nem Dictionary nicht geht
				kdTrees.at(*addr) ?? {
					kdTrees.putAtPath(addr, List.new);
				};
				kdTrees.at(*addr).add(ev.list);
			}
		});
	};

	"create kdtrees from lists, remove duplicates ...".postln;
	kdTrees.treeDo({}, {|lf list|
		var removeDuplicates = list.as(Set).as(List);
		kdTrees.putAtPath(lf, KDTree.new(removeDuplicates))
	});
	~trees = kdTrees;
}.bench
)

// save file
(se
{
	var path = PathName(thisProcess.nowExecutingPath).pathOnly +/+ "hindemithTrees.archiv";
	("saving to " ++ path ++ " ...").postln;
	~trees.writeBinaryArchive(path);
}.bench
)
// Laut ZArchive: The binary archives written by Object.writeBinaryArchive will break if the instance variables change in any of the classes you have archived.
//Jetzt kann in Main_patch.scd geguckt werden.
