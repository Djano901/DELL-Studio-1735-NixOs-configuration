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
  			modules-right = [ "cpu" "memory" "network" "battery" "tray"];

			"sway/workspaces" = {
				format = "{name}";
				all-outputs = true;
				focused-only = false;
				disable-scroll = true;
			};

  			"clock" = {
  				format = "{:%H:%M | %d/%m}";
  				tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
  			};	
  		};
  	};
  	style = ''
  	    *{
  	     border: none;
  	     border-radius: 0;
  	    }

		window#waybar {
			background-color: ${colors.palette.bg_main};
			border-bottom: 2px solid ${colors.palette.border_normal};
			color: ${colors.palette.fg_main};
			transition: none;
		}
  	    
	    #workspaces #battery, #network, #cpu, #memory, #tray {
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
			border-bottom: 2px solid ${colors.palette.accent};
		}
  	'';
  };
}
