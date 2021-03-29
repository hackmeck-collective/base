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
	saveDefs: { |self, name|
		var filePath = self.path.fullPath +/+ name ++ ".scd";
		if(File.exists(filePath).not){
			"Preset % does not exists!".format(name).warn
		}{
			File.use(filePath, "r+", { |f|
				var str = f.readAllString;
				var startIndex = str.find("FILTERS") + 7;
				var endIndex = str.find("ARGS") - 3;
				var before = str[0..startIndex];
				var after = str[endIndex..];
				var newStr = "";
				Pdef.all.keys.select {|k|
					k.asString.contains("%_filter".format(name.asString))
				}.asArray.sort.do {|n|
					newStr = newStr ++ Pdef(n).asCode ++ "\n"
				};
				newStr = newStr ++ "\n";
				f.reset;
				f.write(before ++ newStr ++ after)
			});
		}
	},
	saveOpts: { |self, name|
		var filePath = self.path.fullPath +/+ name ++ ".scd";
		if(File.exists(filePath).not){
			"Preset % does not exists!".format(name).warn
		}{
			File.use(filePath, "r+", { |f|
				var str = f.readAllString;
				var startIndex = str.find("OPTIONS") + 7;
				var endIndex = str.find("FILTERS") - 3;
				var before = str[0..startIndex];
				var after = str[endIndex..];
				var newStr = "var opts = (";
				~lsys.presets[name].asSortedArray.do {|arr|
					newStr = newStr ++ "\n\t%: %,".format(arr[0].asCompileString, arr[1].asCompileString)
				};
				newStr = newStr ++ "\n);\n\n";
				f.reset;
				f.write(before ++ newStr ++ after)
			});
		}
	},
	saveCurrent: { |self, name| self.saveDefs(name); self.saveOpts(name) },
	loadAll: { |self| self.path.files.do {|f| f.fullPath.load }	},
	defaults: {|self, name|
		"(
// OPTIONS
var opts = (noteOffset: 24);

// FILTERS

// ARGS
~newLsys.(
\tname: %,
\taxiom: \"F\",
\trules: ( $F: \"F-[F]+4F\" ),
\tgen: 2.0,
\topts: opts
)
)".format(name.asCompileString)
	}
)