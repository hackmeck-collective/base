(
var res = ~searchTreeNearestOld.(
	// numNotes:  ~listAndParameters.list.size,
	chord: ~listAndParameters.list,
	rootNote: 0,
	dissDegree: 7
);
if(res.notNil){
	~listAndParameters.list = res;
	~pitchesRootDissonance[\pitches] = res.postln;
	~pitchesRootDissonance[\root] = 0;
}
)