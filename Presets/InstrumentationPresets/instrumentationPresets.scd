~instrumentationPresetDictionary = Dictionary.new;

~instrumentationPresetDictionary.add(\farbklaenge -> {
	~instrumentationPreset = [\sd1, \sd2, \sd3];
	"farbklänge".postln;
});

~instrumentationPresetDictionary.add(\einschwingKlaenge -> {
	~instrumentationPreset = [\simplePluckReverse, \tonalSwoosh];
	"einschwingKlaenge".postln;
});

~instrumentationPresetDictionary.add(\ausschwingKlaenge -> {
	~instrumentationPreset = [\simplePluck, \noisyPluck];
	"auschschwingKlaenge".postln;
});

~instrumentationPresetDictionary.add(\einUndAusschwingKlaenge -> {
	~instrumentationPreset = [\simplePluckReverse, \tonalSwoosh, \simplePluck, \noisyPluck];
	"ein- und ausschwingKlaenge".postln;
});

~instrumentationPreset.postln