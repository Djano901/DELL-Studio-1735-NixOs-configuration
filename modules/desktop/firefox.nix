{ pkgs, ...}:

let
	lock-true = { Value = true; Status = "locked"; };
	lock-false = { Value = false; Status = "locked"; };
in


{
	# imports = [
	# 	arkenfox-nixos.hmModules.default
	# ];

	programs.firefox = {
		enable = true;
		# arkenfox = {
		# 	enable = true;
		# 	version = "master";
		# };

		policies = {
			ExtensionSettings = {
				"*" = {
					installation_mode = "blocked";
				};
				"uBlock0@raymondhill.net" = {
					install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
					installation_mode = "force_installed";
				};
			};			
		};
		
		profiles.Hardened = {
			id = 0;
			name = "Hardened";
			isDefault = true;

			search = {
				force = true;
				default = "ddg";
				order = [ "ddg" ];
			};

			arkenfox = {
				enable = true;
				version = "master";
				"0000".enable = true; # [TOP LEVEL]
				"0100".enable = true; # Startup settings
				"0200".enable = true; # Geolocation
				"0300".enable = true; # [QUIETER FOX] : Désactive les recommandations de télémétrie
				"1200".enable = true; # [HTTPS_ONLY] : Force la connexion sécurisée.
				"1600".enable = true; # [REFERERS] : Limite les informations envoyés aux sites
				"1700".enable = true; # [CONTAINERS] : Active les supports de conteneurs.
				"0400".enable = true; # Safe Browsing
				"0800".enable = true; # Search Bar
				"1000".enable = true; # Disk avoidance ( attention, réduit le cache)
				"2600".enable = true; # Netttoyage du shutdown
				"2700".enable = true; # Protection contre le pistage
				"2800".enable = true; # [SANITIZZING]
			};
			
			settings = {
				# "browser.startup.homepage" = "https://nixos.org";
				"browser.search.region" = "FR";
				"browser.search.isUS" = false;
				"distribution.searchplugins.defaultLocale" = "fr_FR";
				"general.useragent.locale" = "fr_FR";

				# "dom.security.https_only_mode" = true;

				"places.history.enabled" = false;
				"privacy.globalprivacycontrol.enabled" = true;
				"privacy.donottrackheader.enabled" = true;
				"privacy.trackingprotection.enabled" = true;
				"privacy.fingerprintingProtection" = true;
				"privacy.sanitize.sanitizeOnShutDown" = true;
				"privacy.sanitize.timeSpan" = 0;
				"privacy.clearOnShutdown.history" = true;
				"privacy.clearOnShutdown.downloads" = true;
				"privacy.clearOnShutdown.sessions" = true;
				"privacy.clearOnShutdown.formdata" = true;
				"privacy.clearOnShutdown.cookies" = true;
				"privacy.clearOnShutdown.cache" = true;
				"dom.battery.enabled" = "false";
				"browser.newtabpage.enabled" = false;
				"browser.download.useDownloadDir" = false;

				"privacy.cpd.history" = true;
				"privacy.cpd.sessions" = true;
				"privacy.cpd.downloads" = true;
				"privacy.cpd.formdata" = true;
				"privacy.cpd.cache" = true;
				"privacy.cpd.cookies" = true;

				"signon.rememberSignons" = false;
				"signon.autofillForms" = false;
				"browser.formfill.enable" = false;
				"extensions.formautofill.addresses.enabled" = false;
				"extensions.formautofill.creditCards.enabled" = false;
				"datareporting.policy.dataSubmissionEnabled" = false;

				"browser.uidensity" = 1; # Mode compact
				"ui.systemUsesDarkTheme" = 1;
				"layout.css.prefers-color-scheme.content-override" = 0;
				"browser.theme.contenttheme" = 0;

				# Optimisation pour GPU ancien :
				"gfx.webrender.all" = true;
				"layers.acceleration.force-enabled" = true;
				# "privacy.resistFingerprinting" = false; # Concomme trop de CPU

				# Sécurité des extensions :
				"extensions.autoDisableScopes" = 0;
				"extensions.enabledScope" = 15;
				
			};
		};
	};
}
