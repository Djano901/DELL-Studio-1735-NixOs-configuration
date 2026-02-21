{pkgs, ...}:

{
  programs.waybar = {
  	enable = true;
  	settings = {
  		mainBar = {
  			layer = "top";
  			position = "top";
  			height = 20;
  			modules-left = [ "sway/workspace" "sway/mode" ];
  			modules-center = [ "clock" ];
  			modules-right = [ "cpu" "memory" "network" "battery" "tray"];

  			"clock" = {
  				format = "{:%H:%M | %d/%m}";
  				tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
  			};
  			
  		};
  	};
  };
}
