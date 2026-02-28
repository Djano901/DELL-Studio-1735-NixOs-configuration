{ pkgs, ... }:

{
	fonts.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
		font-awesome
		material-icons
		iosevka	
	];

	fonts.fontconfig = {
		enable = true;
		defaultFonts = {
			monospace = [ "Iosevka Nerd Font" ];
			sansSerif = [ "Iosevka Nerd Font" ];
			# monospace = [ "JetBrainsMono Nerd Font" ];
			# sansSerif = [ "JetBrainsMono Nerd Font" ];
		};
	};
	
}
