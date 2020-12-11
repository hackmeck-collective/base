SynthDef("simple_reverb", {
    var input;
    input = In.ar(~simple_reverb, 2);
    16.do({ input = AllpassC.ar(input, 0.04, { Rand(0.001,0.04) }.dup, 3)});
    Out.ar(~effect_bus, input);
}).add;

y = Synth.new("simple_reverb",target: ~effect_group);