(
var dependenciesAll = {
	~pitchesRootDissonance = OSCObjectSpace(~addrBook, oscPath: '/pitches').acceptEvents_(true);
};
var dependenciesBenniVincent = {
	~osc_data_params = OSCObjectSpace(~addrBook, oscPath: '/params').acceptEvents_(true);
	~instrumentPresetsDictionary = OSCObjectSpace(~addrBook, oscPath: '/instrumentPresets').acceptEvents_(true);
	~drumPresetsDictionary = OSCObjectSpace(~addrBook, oscPath: '/drumPresets').acceptEvents_(true);
	~routing = OSCObjectSpace(~addrBook, oscPath: '/routing').acceptEvents_(true);
	~lsys = OSCObjectSpace(~addrBook, oscPath: '/lsys').acceptEvents_(true);
	//~lsys = OSCObjectSpace(~addrBook, oscPath: '/lsys').acceptEvents_(true);
	~cueData = OSCDataSpace(~addrBook, '/cueData');
	~cueData[\fillLength] = 1;

	"make SynthDescRelay".postln;
	~synthDescRel = SynthDescRelay(~addrBook);
};
var userDict = (
	\Admin: { dependenciesAll.value; dependenciesBenniVincent.value; },
	\vincent: { dependenciesAll.value; dependenciesBenniVincent.value; },
	\philipp: { dependenciesAll.value; }
);

if(~addrBook.isNil){
	~addrBook = AddrBook.new;
	~addrBook.addMe;
	~hail = Hail.new(~addrBook);
	"initialize OSC Object Spaces".postln;
	if(~localSetup){
		dependenciesAll.value; dependenciesBenniVincent.value;
	}{
		userDict[~addrBook.me.name].value;
	};
	"initialize adressbook, user %".format(~addrBook.me.name).postln;
	"addressbook loaded";
}{
	"addressbook exists. not initializing variables again".warn;
};
)



