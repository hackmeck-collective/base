(
"initialize adressbook".postln;
~addrBook ?? ~addrBook = AddrBook.new;
~addrBook.addMe(\Benni);
~hail = Hail.new(~addrBook);

"initialize OSC Object Spaces".postln;
~osc_data_params = OSCObjectSpace(~addrBook, oscPath: '/params').acceptEvents_(true);

~instrumentPresetsDictionary = OSCObjectSpace(~addrBook, oscPath: '/instrumentPresets').acceptEvents_(true);
~drumPresetsDictionary = OSCObjectSpace(~addrBook, oscPath: '/drumPresets').acceptEvents_(true);
~pitchesRootDissonance = OSCObjectSpace(~addrBook, oscPath: '/pitches').acceptEvents_(true);
~routing = OSCObjectSpace(~addrBook, oscPath: '/routing').acceptEvents_(true);

"make SynthDescRelay".postln;
~synthDescRel = SynthDescRelay(~addrBook);

"addressbook loaded";
);

