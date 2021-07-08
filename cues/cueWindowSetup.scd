(
~cueWindow ?? {~cueWindow =  Window.new("cues", Rect(100,450,1400,400)).front};
~cueWindowText = StaticText(~cueWindow, Rect(10,10,1390,350));
~cueWindowText.background=Color.white;
~cueWindowText.align = \center;
~cueWindowText.font = Font("Monaco", 48);
~cueWindowText.string = "cues";
~meterWindow ?? {~meterWindow =  Window.new("meter", Rect(100,50,1400,250)).front};
~cueWindowMeter = ServerMeterView.new(s,~meterWindow, 0@0, 0, 10)

);
/*(
~cueWindow = nil;
~meterWindow  = nil;
)*/