//Dies ist eine Verbesserung von Akkordbestimmung_Hindemith.scd aus 2019Q2


~hindemith = {
	arg chord; //Der Akkord mit tiefstem Ton zuerst

	var root; //Der Grundton
	var listOfIntervalsInChord; //Die aus dem Akkord gebildeten Intervalle der Töne untereinander.
	var degreeOfDissonance;
	var intervalsInChord; //hier stehen als verschachtelte Liste die Intervalle des Akkordes (angefangen von unten)
	// intervalsInChord //alternativ: ein Dictionary dessen Schlüssel die Akkordtöne sind. Die Werte sind eine Liste mit den Intervallen zu allen Akkordtönen (inklusive des Ausgangstons).

	//für Funktionen:
	var consistsTritone;
	var consistsSecondORSeventh;
	var consistsMinorSecondORMajorSeventh;
	var consistsOnlyMinorSecondNotMajorSeventh; //Brauch man das?!
	var consistsOnlyMinorSeventhNotMajorSecond;
	var consistsMajorSecondANDMinorSeventh;
	var consistsMajorSecondORMinorSeventh;
	var consistsMoreThanOneTritone;
	var bassToneAndRootAreTheSame;
	var chordIsTranspositionOf;
	var stripOffOctavations;

	"Grundtonbestimmung Hindemith.scd".loadRelative;
	chord.sort;
	# root, listOfIntervalsInChord = ~grundton_hindemith.value(chord);
	consistsTritone = {
		arg listOfIntervals;
		if(listOfIntervals.includes(6), {true}, {false})
	};

	consistsSecondORSeventh = {
		arg listOfIntervals;
		if(
			listOfIntervals.includes(1) ||
			listOfIntervals.includes(2) ||
			listOfIntervals.includes(10) ||
			listOfIntervals.includes(11),
			{true},
			{false}
		)
	};

	consistsMinorSecondORMajorSeventh = {
		arg listOfIntervals;
		if(
			listOfIntervals.includes(1) || listOfIntervals.includes(11), {true}, {false}
		)
	};

	consistsOnlyMinorSecondNotMajorSeventh = { //Braucht man das?
		arg listOfIntervals;
		if(
			listOfIntervals.includes(1) &&
			listOfIntervals.includes(11).not, //enthält NICHT gr. Septime
			{true},
			{false}
		)
	};
	consistsOnlyMinorSeventhNotMajorSecond = {
		arg listOfIntervals;
		if(
			(listOfIntervals.includes(10) &&
			listOfIntervals.includes(2).not), //enthält NICHT gr. Sekunde
			{true},
			{false}
		)
	};
	consistsMajorSecondORMinorSeventh = {
		arg listOfIntervals;
		if(
			listOfIntervals.includes(2) || listOfIntervals.includes(10), {true}, {false}
		)
	};
	consistsMajorSecondANDMinorSeventh = {
		arg listOfIntervals;
		if(
			listOfIntervals.includes(2) && listOfIntervals.includes(10), {true}, {false}
		)
	};

	consistsMoreThanOneTritone = {
		arg listOfIntervals;
		var counter = 0;
		listOfIntervals.do({
			arg interval;
			if((interval == 6),{counter = counter + 1});
		});
		if(counter > 1, {true}, {false})
	};

	bassToneAndRootAreTheSame = {
		arg chord, root;
		if(chord.sort.at(0) == root,
			{true},
			{false}
		)
	};

	chordIsTranspositionOf = {
		arg chord1, chord2;
		var transposition = false;
		var ende = 108; //midi 108 ist c4
		chord1.sort;
		chord2.sort;
		chord1 = chord1 - chord1.at(0); //Transponiert so, dass der Basston 0 ist.
		while ( {transposition.not && (chord1.last != ende) }, {
			if((chord1 == chord2), {transposition=true});
			chord1 = chord1 + 1;
		});
		transposition
	};

	stripOffOctavations = {
		arg chord;
		var chordInOneOctave = chord.mod(12);
		chordInOneOctave.asSet.asArray.sort;
	};


	if( //SOUNDS WITH TRITONE
		consistsTritone.value(listOfIntervalsInChord),
		{
			var testChordForVI = stripOffOctavations.value(chord);

			if( //vermindert ( VI )
				(
					chordIsTranspositionOf.value(testChordForVI, [0,3,6]) ||
					chordIsTranspositionOf.value(testChordForVI, [0,3,9]) ||
					chordIsTranspositionOf.value(testChordForVI, [0,6,9]) ||
					chordIsTranspositionOf.value(testChordForVI, [0,3,6,9])
				),
				{
					degreeOfDissonance = 11 //"AbteilungVI"
				}, {
					if( // ( IV )
						consistsMinorSecondORMajorSeventh.value(listOfIntervalsInChord),
						{
							if(
								bassToneAndRootAreTheSame.value(chord, root),
								{  degreeOfDissonance = 8}, //"AbteilungIV.1"
								{  degreeOfDissonance = 9 } //"AbteilungIV.2"
							)
						},
						{ //without minor second and major seventh ( II )
							if(
								consistsMajorSecondORMinorSeventh.value(listOfIntervalsInChord),
								{
									if(
										bassToneAndRootAreTheSame.value(chord, root),
										{ degreeOfDissonance = 3}, //"AbteilungIIb.1"
										{ degreeOfDissonance = 4} //"AbteilungIIb.2"
									);
									if(
										consistsMoreThanOneTritone.value(listOfIntervalsInChord),
										{ degreeOfDissonance = 5}, //"AbteilungIIb.3"
										{}
									);
								},
								{}
							);

							if(
								consistsOnlyMinorSeventhNotMajorSecond.value(listOfIntervalsInChord),
								{
									if(
										bassToneAndRootAreTheSame.value(chord, root),
										{ degreeOfDissonance = 2}, //"AbteilungIIa"
										{}
									)
								},
								{

								}
							);


						}
					)
				}
			)
		},
		{// SOUNDS WITHOUT TRITONE
			var testChordForV = stripOffOctavations.value(chord);
			if( // ( V )
				(
					chordIsTranspositionOf.value(testChordForV, [0,4,8]) ||
					chordIsTranspositionOf.value(testChordForV, [0,5,10]) ||
					chordIsTranspositionOf.value(chord, [0,5,10,15]) ||
					chordIsTranspositionOf.value(chord, [0,5,10,15,20]) ||
					chordIsTranspositionOf.value(chord, [0,5,10,15,20,25])
				),
				{ degreeOfDissonance = 10}, //"AbteilungV"
				{
					if(
						consistsSecondORSeventh.value(listOfIntervalsInChord), // ( III )
						{
							if(
								bassToneAndRootAreTheSame.value(chord, root),
								{ degreeOfDissonance = 6}, //"AbteilungIII.1"
								{ degreeOfDissonance = 7} //"AbteilungIII.2"
							)
						},
						{ //without Second and Seventh ( I )
							if(
								bassToneAndRootAreTheSame.value(chord, root),
								{ degreeOfDissonance = 0}, //"AbteilungI.1"
								{ degreeOfDissonance = 1} //"AbteilungI.2"
							)
						}
					)
				}
			)
		}
	);

	[root, degreeOfDissonance]
}





















