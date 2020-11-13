~sendToProcessing = NetAddr("localhost", 12000);

// Eine einzelne Linie
// p1_x, p1_y, p2_x, p2_y
(
~oscMsg = Array.fill(4, {arg i; 640.rand});
~sendToProcessing.sendMsg('/test', *~oscMsg); //Mir dem Sternchen löst man den Array auf.
)



// mehrere Linien
(
~oscMsg = [
	[10, 20, 80, 90],
	[10, 20, 500, 100],
	[10, 20, 600, 400]
];
~sendToProcessing.sendMsg('/test', *~oscMsg.flat); // osc msg darf kein array im array haben, daher .flat
)

//mehrere Linien randomisiert
(
~oscMsg = [
	Array.fill(4, {arg i; 640.rand}).postln,
	Array.fill(4, {arg i; 640.rand}).postln,
	Array.fill(4, {arg i; 640.rand}).postln
];
~sendToProcessing.sendMsg('/test', *~oscMsg.flat); // osc msg darf kein array im array haben, daher .flat
)