"initializing groups".postln;

~makeGroups = {
	~source_group = Group.new;
	~effect_group = Group.after(~source_group);
	~bus_group = Group.after(~effect_group);
	~master_group = Group.tail;
};
ServerTree.removeAll;
ServerTree.add({ ~makeGroups.value }).run(\all);