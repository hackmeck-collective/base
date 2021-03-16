Server.scsynth;
//Server.supernova;
s = Server.default;
s.options.sampleRate = 48000;
s.options.bindAddress = "0.0.0.0";
s.options.maxLogins = 2;
s.latency = 0.2;
s.options.device = "ASIO : ASIO Fireface USB";
