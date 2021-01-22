(
~sendToProcessing = NetAddr("localhost", 12000);
~sizeOfBoard = 1000;
~oscPath = "/lines";

)



// Eine einzelne Linie
// p1_x, p1_y, p2_x, p2_y
(
~oscMsg = Array.fill(4, {arg i; ~sizeOfBoard.rand});
~oscMsg = ~oscMsg.add(1.0.rand); //add Line Level
~sendToProcessing.sendMsg(~oscPath, *~oscMsg.postln); //Mir dem Sternchen löst man den Array auf.
)


// mehrere Linien
(
~oscMsg = [
	[10, 20, 300, 90, 0.5],
	[20, 40, 300, 90, 0.1]
];
~sendToProcessing.sendMsg(~oscPath, *~oscMsg.flat.postln); // osc msg darf kein array im array haben, daher .flat
)

//mehrere Linien randomisiert
(
~oscMsg = [
	Array.fill(4, {arg i; ~sizeOfBoard.rand}) ++ 1.0.rand,
	Array.fill(4, {arg i; ~sizeOfBoard.rand}) ++ 1.0.rand,
	Array.fill(4, {arg i; ~sizeOfBoard.rand})  ++ 1.0.rand
];
~sendToProcessing.sendMsg(~oscPath, *~oscMsg.flat.postln); // osc msg darf kein array im array haben, daher .flat

)

//~sendToProcessing.sendMsg("/offsetXY", (500 - ~oscMsg2centroid.value(~oscMsg)).postln);





