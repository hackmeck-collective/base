(~addrBook ?? ~addrBook = AddrBook.new;
~addrBook.addMe(\Benni);
~registrant = Registrant.new(~addrBook);
~osc_data_params = OSCDataSpace(~addrBook, '/params');

"addressbook loaded";
)