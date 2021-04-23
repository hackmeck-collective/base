(
var dependenciesAll = {
	~pitchesRootDissonance = OSCObjectSpace(~addrBook, oscPath: '/pitches').acceptEvents_(true);
};
var dependenciesBenniVincent = {
	~osc_data_params = OSCObjectSpace(~addrBook, oscPath: '/params').acceptEvents_(true);
	~instrumentPresetsDictionary = OSCObjectSpace(~addrBook, oscPath: '/instrumentPresets').acceptEvents_(true);
	~drumPresetsDictionary = OSCObjectSpace(~addrBook, oscPath: '/drumPresets').acceptEvents_(true);
	~routing = OSCObjectSpace(~addrBook, oscPath: '/routing').acceptEvents_(true);
	~cueData = OSCDataSpace(~addrBook, '/cueData');
	~cueData[\fillLength] = 1;

	"make SynthDescRelay".postln;
	~synthDescRel = SynthDescRelay(~addrBook);
};
var userDict = (
	\benni: { dependenciesAll.value; dependenciesBenniVincent.value; },
	\vincent: { dependenciesAll.value; dependenciesBenniVincent.value; },
	\philipp: { dependenciesAll.value; }
);

if(~addrBook.isNil){
	"initialize adressbook, user %".format(~addrBookUserName).postln;
	~addrBook = AddrBook.new;
	~addrBook.addMe;
	~hail = Hail.new(~addrBook);
	"initialize OSC Object Spaces".postln;
	userDict[~addrBookUserName].value;
	"addressbook loaded";
}{
	"addressbook exists. not initializing variables again".warn;
};
)

