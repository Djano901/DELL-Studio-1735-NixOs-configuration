{ pkgs, ... }:

{
	fonts.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
		font-awesome
		material-icons	
	];

	fonts.fontconfig = {
		enable = true;
		defaultFonts = {
			monospace = [ "JetBrainsMono Nerd Font" ];
			sansSerif = [ "JetBrainsMono Nerd Font" ];
		};
	};
	
}
