(
~cueWindow ?? {~cueWindow =  Window.new("cues", Rect(100,350,1400,500)).front};
~cueWindowText = StaticText(~cueWindow, Rect(10,10,1390,490));
~cueWindowText.background=Color.white;
~cueWindowText.align = \center;
~cueWindowText.font = Font("Monaco", 48);
~cueWindowText.string = "cues";
);
