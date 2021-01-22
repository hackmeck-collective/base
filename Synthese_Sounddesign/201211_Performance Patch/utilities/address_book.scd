(~addrBook ?? ~addrBook = AddrBook.new;
~addrBook.addMe(\Benni);
~hail = Hail.new(~addrBook);
~osc_data_params = OSCDataSpace(~addrBook, '/params');

"addressbook loaded";
)

/*~addrBook.peers*/

/*~osc_data_params[\sourceGroup] = ~source_group.nodeID
~osc_data_params[\sourceGroup2]*/