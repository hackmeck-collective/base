~lsysPreset = (
	path: PathName(thisProcess.nowExecutingPath.dirname +/+ "LsystemPresets"),
	create: { |self, name|
		var filePath = self.path.fullPath +/+ name ++ ".scd";
		if(File.exists(filePath)){
			"Preset % already exists, use method edit".format(name).warn
		}{
			File.use(filePath, "w", { |f|
				f.write(self.defaults(name))
			});
			Document.open(filePath)
		};
	},
	edit: { |self, name|
		var filePath = self.path.fullPath +/+ name ++ ".scd";
		if(File.exists(filePath).not){
			"Preset % does not exists, use method create first".format(name).warn
		}{
			Document.open(filePath)
		}
	},
	loadAll: { |self|
		self.path.files.do {|f| f.fullPath.load }
	},
	defaults: {|self, name|
		"~newLsys.(
\tname: %,
\taxiom: \"F\",
\trules: ( $F: \"F-[F]+4F\" ),
\tgen: 2.0,
\topts: ()
)".format(name.asCompileString)
	}
)