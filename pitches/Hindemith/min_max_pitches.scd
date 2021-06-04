~inputArr = [0, 5, 13];

~expandNotes = {|notes, lowNote, highNote|
	var addOctaves = (0, 12 .. 96) +.t notes + lowNote;
	addOctaves.flat.reject(_ > highNote).sort
};
