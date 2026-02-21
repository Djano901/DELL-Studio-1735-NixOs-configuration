{config, pkgs, lib, ...}:

{
  home.packages = with pkgs; [
  	swaybg
  	waybar
  ];

  programs.alacritty = {
  	enable = true;
  	settings = {
  		window.opacity = 0.9;
		font.size = 11;
		colors.primary.background = "#1d1f21";
  		};
  };


  
  wayland.windowManager.sway = {
    enable = true;
    
    config = {
      modifier = "Mod4";
      terminal = "${pkgs.alacritty}/bin/alacritty";
	  startup = [
	  	{
	  		command = "pkill swaybg; ${pkgs.swaybg}/bin/swaybg -i /home/Jean/wallpaper/gargantua.jpg -m fill";
	  		always = true;
	  	}
	  ];
      keybindings = let
        mod = "Mod4";
      in pkgs.lib.mkOptionDefault {
        # --- Worspace ---
        "${mod}+ampersand" = "workspace number 1";
        "${mod}+eacute" = "workspace number 2";
        "${mod}+quotedbl" = "workspace number 3";
        "${mod}+apostrophe" = "workspace number 4";
        "${mod}+parenleft" = "workspace number 5";
        "${mod}+minus" = "workspace number 6";
        "${mod}+egrave" = "workspace number 7";
        "${mod}+underscore" = "workspace number 8";
        "${mod}+ccedilla" = "workspace number 9";                
        "${mod}+agrave" = "workspace number 10";

        # --- Déplacer les fenêtres ---
        "${mod}+Shift+ampersand" = "move container to workspace number 1";
        "${mod}+Shift+eacute" = "move container to workspace number 2";
        "${mod}+Shift+quotedbl" = "move container to workspace number 3";
        "${mod}+Shift+apostrophe" = "move container to workspace number 4";
        "${mod}+Shift+parenleft" = "move container to workspace number 5";
        "${mod}+Shift+minus" = "move container to workspace number 6";
        "${mod}+Shift+egrave" = "move container to workspace number 7";
        "${mod}+Shift+underscore" = "move container to workspace number 8";
        "${mod}+Shift+ccedilla" = "move container to workspace number 9";                
        "${mod}+Shift+agrave" = "move container to workspace number 10";                
      };

      input = {
        "type:keyboard" = {
          xkb_layout = "fr";
        };
      };

	  bars = [
	  	{ command = "${pkgs.waybar}/bin/waybar"; }
	  ];
      
    };
  };
}
