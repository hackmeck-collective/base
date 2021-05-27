Pdef(\philly).play
~lsysPreset.edit(\philly)

(
~evs = List.new;
~counter = Pseries().asStream;
Pdef(\philly).collect{|ev| ~counter.next.postln; thisThread.beats.postln;~evs.add(ev);ev}.play
)

// numBranches ist eigentlich num branchLevels
// auf einem Level koennen mehrere neue gleichzeitig entstehen ..

~lsys.newPattern.max
.select{|str| str.myKey == 2}.collect(_.parentId)

~lsys.presets.philly.keys.printAll

~lsys.newPattern.stream.select{|str| str.parentId == 0}.collect(_.myId)
~lsys.newPattern.stream.do{|str| [str.parentId, str.myId, str.firstTime].postln}

~lsys.newPattern.stream.select{|str| str.myKey == 0}.collect(_.myId)

~lsys.newPattern.stream.select{|str| str.myKey == 1}.collect(_.myId)
(
~kick = (0: [], 1: [2, 8, 32, 65]);
~lsys.newPattern.maxKey.do {|k|
	~kick[k + 2] = ~lsys.newPattern.stream
	.select{|str| str.myKey == (k + 2)}
	.select{|str| ~kick[k + 1].includes(str.parentId)}
	.collect(_.myId);
}
)
Pdef(\philly_filter, Pbind(\kick, Pfunc{|ev|
	if(~kick[ev.branchLevel].includes(ev.myId)){("kick " ++ ev.myId).postln;Rest()}{0}
}))
Pn(Pdef(\philly)).play

~lsys.newPattern.stream.select{|str| str.myKey == 1}.collect(_.myId)
[ 1, 2, 4, 8, 16, 32, 64, 128, 129, 131, 135, 143, 159 ]
(
~solo = (0: [0], 1: [4, 32, 128,159]);
~lsys.newPattern.maxKey.do {|k|
	~solo[k + 2] = ~lsys.newPattern.stream
	.select{|str| str.myKey == (k + 2)}
	.select{|str| ~solo[k + 1].includes(str.parentId)}
	.collect(_.myId);
}
)
Pdef(\philly_filter, Pbind(\solo, Pfunc{|ev|
	if(~solo[ev.branchLevel].includes(ev.myId)){("solo " ++ ev.myId).postln;0}{Rest()}
}))
//manuell

~kick[2] = ~lsys.newPattern.stream
.select{|str| str.myKey == 2}
.select{|str| ~kick[1].includes(str.parentId)}
.collect(_.myId);

~kick[3] = ~lsys.newPattern.stream
.select{|str| str.myKey == 3}
.select{|str| ~kick[2].includes(str.parentId)}
.collect(_.myId);

~kick[4] = ~lsys.newPattern.stream
.select{|str| str.myKey == 4}
.select{|str| ~kick[3].includes(str.parentId)}
.collect(_.myId);

~kick[5] = ~lsys.newPattern.stream
.select{|str| str.myKey == 5}
.select{|str| ~kick[4].includes(str.parentId)}
.collect(_.myId);

~kick[6] = ~lsys.newPattern.stream
.select{|str| str.myKey == 6}
.select{|str| ~kick[5].includes(str.parentId)}
.collect(_.myId);

