(
var ip = if(~addrBook.at(\Philipp).notNil){
	~addrBook.at(\Philipp).addr.ip
}{
	"127.0.0.1"
};
~gui = ();
~gui.points = List.new;
~gui.scale = 10;
("processing IP = " ++ ip).warn;
~gui.toProcessing = NetAddr(ip, 12000);
)