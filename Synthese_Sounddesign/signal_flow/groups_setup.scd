"initializing groups".postln;

~makeGroups = {
	~pointer_group = Group.new;
	~bufferRec_group  = Group.after(~pointer_group);
	~source_group = Group.after(~bufferRec_group);
	//~source_group_fills = Group.head;
//	~source_group = ParGroup.new;
	~effect_group = Group.after(~source_group);
	~bus_group = Group.after(~source_group);
	~summing_group = Group.after(~effect_group);
	~master_group = Group.tail;
	~routing[\sourceGroup] = ~source_group.nodeID;
	//~routing[\sourceGroupFills] = ~source_group_fills.nodeID;
};

ServerTree.add({ ~makeGroups.value });