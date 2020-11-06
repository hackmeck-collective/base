~sendToProcessing = NetAddr("localhost", 12000);

// Eine einzelne Linie
// p1_x, p1_y, p2_x, p2_y
(
~oscMsg = [200, 200, 400, 400];
~sendToProcessing.sendMsg('/test', *~oscMsg); //Mir dem Sternchen löst man den Array auf.
)

// mehrere Linien
(
~oscMsg = [
	[10, 20, 30, 40],
	[200, 100, 500, 100],
	[600, 200, 600, 400]
];
~sendToProcessing.sendMsg('/test', *~oscMsg.flat); // osc msg darf kein array im array haben, daher .flat
)