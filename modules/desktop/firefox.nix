{ pkgs, ...}:

{
	# imports = [
	# 	arkenfox-nixos.hmModules.default
	# ];

	programs.firefox = {
		enable = true;

		arkenfox = {
			enable = true;
			version = "master";
		};
		
		profiles.Hard = {
			id = 0;
			name = "Hard";
			isDefault = true;

			arkenfox = {
				enable = true;
				"0100".enable = true; # Startup settings
				"0200".enable = true; # Geolocation
				"0400".enable = true; # Safe Browsing
				"0800".enable = true; # Search Bar
				"1000".enable = true; # Disk avoidance ( attention, réduit le cache)
				"2600".enable = true; # Netttoyage du shutdown
				"2700".enable = true; # Protection contre le pistage
			};
			
			settings = {
				# "browser.startup.homepage" = "https://nixos.org";
				"browser.search.region" = "FR";
				"browser.search.isUS" = false;
				"distribution.searchplugins.defaultLocale" = "fr_FR";
				"general.useragent.locale" = "fr_FR";

				"privacy.donottrackheader.enabled" = true;
				"privacy.trackingprotection.enabled" = true;
				"privacy.fingerprintingProtection" = true;
				"dom.battery.enabled" = "false";
				"browser.newtabpage.enabled" = false;

				"browser.uidensity" = 1; # Mode compact

				# Optimisation pour GPU ancien :
				"gfx.webrender.all" = true;
				"layers.acceleration.force-enabled" = true;
				# "privacy.resistFingerprinting" = false; # Concomme trop de CPU
			};
		};
	};
}
