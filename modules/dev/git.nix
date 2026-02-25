{ ... }: {
	programs.git = {
		enable = true;
		userName = "Djano901";
		userEmail = "Djano email";

		extraConfig = {
			init.defaultBranch = "main";
			pull.rebase = true;
			push.autoSetupRemote = true;
		};

		# ignores = [
		# 	"result"
		# 	"*.swp"
		# 	".direnv/"
		# ];
	};
}
