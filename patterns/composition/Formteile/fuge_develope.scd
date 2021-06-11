Pdef(\fuge_develope,
	Pspawner({ |sp|
		var times = [5, 1, 3, 2, 2, 3, 1, 5];
		var bdPlayer = sp.par( Pbind( \octave, 4) <> Pdef(\bdBuzz).collect {|ev| ~scM8.play; ev} <> Pbindef(\root) <> Pbindef(\pulse_4) );
		// bdPlayer.play;
		~lsys[\presets].fuge_2_b_gen2.baseTempo = 1/3;
		~lsys[\presets].fuge_2_b_gen1.baseTempo = 1/3;

		sp.seq(
			Pbind(\glide, Pstep([0.3, 2, 0.3, 2, 0.3, 2, 0.3, 2, 2], times, 1))
			<> ~fugeInstrState_1.(Pn(Pdef(\fuge_2_b_gen2), 5))
			<> Pbind(
				\legato, Pstep([0.25, 1, 0.25, 1, 0.25, 1, 0.25, 1, 1], times, 1),
				\stretch, Pstep([0.25, 1, 0.25, 1, 0.25, 1, 0.25, 1, 1], times, 1)
			)
		);
		sp.seq(
			Pbind(\glide, Pstep([2, 0.3], [2,100], inf))
			<> ~fugeInstrState_1.(Pn(Pdef(\fuge_2_b_gen1)))
			<> Pbind(
				\legato, Pstep([1, 0.25], [2,16], inf),
				\stretch, Pstep([1, 3/4, 2/3, 1/2, 3/8, 1/3, 0.25, 1/3, 3/8, 1/2, 2/3, 3/4, 1], 2!6 ++ (1!6), 1)
			)
		);
		bdPlayer.stop;
		~lsys[\presets].fuge_2_b_gen1.baseTempo = 1/6;
		sp.seq(
			Pbind(\glide, 0)
			<> ~fugeInstrState_1.(Pdef(\fuge_2_b_gen1))
		);
		~lsys[\presets].fuge_2_b_gen2.baseTempo = 1/30;
		sp.seq(
			Pbind(\glide, 0)
			<> ~fugeInstrState_1.(Pdef(\fuge_2_b_gen2))
		);
		~lsys[\presets].fuge_2_b_gen3.baseTempo = 1/90;
		sp.seq(
			Pbind(\glide, 0)
			<> ~fugeInstrState_1.(Pdef(\fuge_2_b_gen3))
		);
	})
)