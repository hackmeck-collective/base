(
"resources.scd".loadRelative;
~calcAll = { |dissDegree, numNotes, maxUpper|
	var inputs = merge(
		~dissDegreeConstraints[dissDegree],
		(numNotes: numNotes, maxUpperNoteWhenBaseIs0: maxUpper)
	);
	~getListComprehension.valueWithEnvir(inputs).all
};

~dissDegreesAll = (0..9);
~numNotesAll = [3, 4, 5];
~maxUpper = 36; // 36 dauert schon ein weilchen
)



// calculate all dissDegrees for all different number of notes
(
{
	var calcDegrees = ~dissDegreesAll;
	var calcNumNotes = ~numNotesAll;
	var result = MultiLevelIdentityDictionary.new;
	"calculate all list comprehesions".postln;
	calcNumNotes.do { |nn|
		("\tnumNotes " ++ nn).postln;
		calcDegrees.do { |deg|
			var newCalc = ~calcAll.(
				dissDegree: deg,
				numNotes: nn,
				maxUpper: ~maxUpper
			);
			result.put(\numNotes, nn, \dissDegrees, deg, newCalc);
			("\t\tdissDegree: " ++ deg ++ " size " ++ newCalc.size).postln;
		}
	};
	~res = result;
}.bench
)

// inspection
~res[\numNotes, 3, \dissDegrees, 1]

// copy and offset rootnote and list for every note
(
{
	var offset = (1..11);
	var result = ();
	offset.do { |i|
		("copy with offset " ++ i).postln;
		result[i] = ~res.deepCopy;
		result[i].treeDo({}, {|lf eventArr|
			var eventArrOffset = eventArr.collect {|ev|
				(rootNote: ev.rootNote !? {(ev.rootNote + i) % 12}, list: ev.list + i)
			};
			result[i].putAtPath(lf, eventArrOffset)
			/*			var eventArrOffset = eventArr.collect {|ev|
			ev !? {(rootNote: (ev.rootNote + i) % 12, list: ev.list + i)}
			};
			var removeNil = eventArrOffset.reject(_.isNil);
			if(removeNil.notEmpty){
			result[i].putAtPath(lf, removeNil)
			}*/
		})
	};
	~rootOffsets = result;
}.bench
)

// make kdtrees for all numNotes and all rootNote and all dissDegree
(
{
	var numNotes = ~numNotesAll;
	var rootNotes = (0..11);
	var dissDegrees = ~dissDegreesAll;
	var kdTrees = MultiLevelIdentityDictionary.new;
	"create empty lists for kdtrees".postln;
	numNotes.do {|nn|
		rootNotes.do {|rn|
			dissDegrees.do {|deg|
				kdTrees.put(\numNotes, nn, \rootNote, rn, \dissDegrees, deg, List.new); // KDTree.new([0 ! nn])
			}
		}
	};
	"fill lists with values from ~res".postln;
	~res.treeDo({}, {|lf eventArr|
		// lf.postcs;
		eventArr.do {|ev|
			ev !? {
				kdTrees.at(\numNotes, lf[1], \rootNote, ev.rootNote, \dissDegrees, lf[3]).add(ev.list);
			}
		}
	});

	"fill lists with values from ~rootOffsets".postln;
	~rootOffsets.do { |res|
		res.treeDo({}, {|lf eventArr|
			eventArr.do {|ev|
				ev !? {
					kdTrees.at(\numNotes, lf[1], \rootNote, ev.rootNote, \dissDegrees, lf[3]).add(ev.list);
				}
			}
		});
	};

	"create kdtrees from lists, remove duplicates".postln;
	kdTrees.treeDo({}, {|lf list|
		if(list.notEmpty){
			var removeDuplicates = list.as(Set).as(List);
			kdTrees.putAtPath(lf, KDTree.new(removeDuplicates))
		}
	});
	~trees = kdTrees;
}.bench
)

// save file
(
{
	var path = PathName(thisProcess.nowExecutingPath).pathOnly +/+ "hindemithTrees.archiv";
	// var archive = ZArchive.write(path);
	("saving to " ++ path).postln;
	~trees.writeBinaryArchive(path);
	// archive.writeItem(~trees);
	// archive.writeClose;
}.bench
)
// Laut ZArchive: The binary archives written by Object.writeBinaryArchive will break if the instance variables change in any of the classes you have archived.