{pkgs, ...}:

let
	colors = import ./colors.nix;
in
{
  programs.waybar = {
  	enable = true;
  	systemd.enable = true;
  	settings = {
  		mainBar = {
  			layer = "top";
  			position = "top";
  			height = 20;
  			modules-left = [ "sway/workspaces" "sway/mode" ];
  			modules-center = [ "clock" ];
  			modules-right = [ "cpu" "memory" "network#vpn" "battery" "pulseaudio" "tray"];

			"cpu" = {
			    format = "󰍛 {usage}%";
			};
			
			"memory" = {
			    format = "󰾆 {percentage}%";
			};
			
			"battery" = {
			    states = {
			        warning = 30;
			        critical = 15;
			    };
			    format = "{icon} {capacity}%";
			    format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
			};

			"sway/workspaces" = {
				format = "{name}";
				all-outputs = true;
				focused-only = false;
				disable-scroll = true;
			};

			"clock" = {
			    format = "{:%e %b  %H:%M}";
			    tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
			};

  			"network#vpn" = {
  				interface = "wgnord";
  				format = "󰒄 {ifname}";
  				format-disconnect = "󰒅 OFF";
  				tooltip-format = "VPN: {ifname} | {ipaddr}";
  			};	

  			"pulseaudio" = {
  			    format = "{icon} {volume}%";
  			    format-muted = "󰝟 Muted";
  			    format-icons = {
  			        default = ["󰕿" "󰖀" "󰕾"];
  			    };
  			    on-click = "pavucontrol"; # Ouvre le mixeur au clic
  			};
  		};
  	};
  	style = ''
  	    *{
  	     border: none;
  	     border-radius: 0;
  	     font-family: "Symbols Nerd Font Mono", "JetBrainsMono Nerd Font", "JetBrainsMonoNF", monospace;
  	     font-size: 13px;
  	    }

		window#waybar {
			background-color: ${colors.palette.bg_main};
			border-bottom: 2px solid ${colors.palette.border_normal};
			color: ${colors.palette.fg_main};
			transition: none;
		}
  	    
	    #workspaces #battery, #network, #cpu, #memory, #tray, #network-vpn, #pulseaudio {
			padding: 0 15px;
			margin: 4px 4px;
			border-radius: 15px;
			color : ${colors.palette.fg_main};
			background-color: ${colors.palette.bg_alt};
		}

		#clock {
			color: ${colors.palette.accent};
			background-color: ${colors.palette.bg_main};
		}

		#workspaces button {
			margin: 4px 2px;
			border-radius: 10px;
			background: transparent;
			border: none;
			box-shadow: none;
			text-shadow: none;
			color: ${colors.palette.fg_main};
		}

		#workspaces button.focused {
			color: ${colors.palette.accent};
			background-color: ${colors.palette.bg_alt};
			border-bottom: 1px solid ${colors.palette.accent};
		}

		#network-vpn {
			font-family: "Symbols Nerd Font Mono", "JetBrainsMono Nerd Font";
		}

		#network-vpn.disconnected {
			color: #bf616a;
			font-weight: bold;
		}
  	'';
  };
}
