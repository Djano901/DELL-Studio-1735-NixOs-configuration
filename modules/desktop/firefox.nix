{pkgs, ...}:

{
	programs.firefox = {
		enable = true;
		profiles.Hard = {
			isDefault = true;
			settings = {
				"browser.startup.homepage" = "https://nixos.org";
				"browser.search.region" = "FR";
				"browser.search.isUS" = false;
				"distribution.searchplugins.defaultLocale" = "fr_FR";
				"general.useragent.locale" = "fr_FR";

				"privacy.donottrackheader.enabled" = true;
				"privacy.trackingprotection.enabled" = true;
				"privacy.fingerprintingProtection" = true;
				"dom.battery.enabled" = "false";
				"browser.newtabpage.enabled" = false;
			};
		};
	};
}
