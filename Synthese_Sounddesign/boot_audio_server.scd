Server.scsynth;
s = Server.default;
s.options.sampleRate = 48000;
s.options.bindAddress = "0.0.0.0";
s.options.maxLogins = 4;
s.options.device = "ASIO : ASIO Fireface USB";
