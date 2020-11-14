~sendToProcessing = NetAddr("localhost", 12000);
~sizeOfBoard = 640;

// Eine einzelne Linie
// p1_x, p1_y, p2_x, p2_y
(
~oscMsg = Array.fill(4, {arg i; ~sizeOfBoard.rand});
~sendToProcessing.sendMsg('/test', *~oscMsg.postln); //Mir dem Sternchen löst man den Array auf.
)



// mehrere Linien
(
~oscMsg = [
	[10, 20, 300, 90],
	[20, 40, 300, 90]
];
~sendToProcessing.sendMsg('/test', *~oscMsg.flat.postln); // osc msg darf kein array im array haben, daher .flat
)

//mehrere Linien randomisiert
(
~oscMsg = [
	Array.fill(4, {arg i; ~sizeOfBoard.rand}),
	Array.fill(4, {arg i; ~sizeOfBoard.rand}),
	Array.fill(4, {arg i; ~sizeOfBoard.rand})
];
~sendToProcessing.sendMsg('/test', *~oscMsg.flat.postln); // osc msg darf kein array im array haben, daher .flat
)

