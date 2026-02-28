{config, pkgs, lib, ...}:

let
	colors = import ./colors.nix;
in
{
  home.packages = with pkgs; [
  	waybar
  	swaybg
  ];

  programs.alacritty = {
  	enable = true;
  	settings = {
  		window.opacity = 0.9;
		font.size = 11;
		colors.primary.background = "#1d1f21";
  		};
  };

  programs.fuzzel = {
  	enable = true;
  	settings = {
  		main = {
  			font = "Lexxend:size=12";
  			terminal = "${pkgs.alacritty}/bin/alacritty";
  			prompt = ">  ";
  			layer = "overlay";
  			width = 35;
  			horizontal-pad = 25;
  			vertical-pad =15;
  			inner-pad = 10;
  			line-height = 25;
  			fields = "name,generic,comment,executable";
  			incons-enabled = "yes";
  			icon-theme = "Papirus-Dark";
  			# border-width = 2;
  			# border-radius = 8;
  		};
  		colors = {
  			# background = "1d1f21fa";
			# text = "c5c8c6ff";
			# match = "81a2beff";
			# selection = "373b41ff";
			# selection-text = "ffffffff";
			# border = "81a2beff";
  			background = "${builtins.substring 1 6 colors.palette.bg_main}ff";
  			text = "${builtins.substring 1 6 colors.palette.fg_main}ff";
  			match = "${builtins.substring 1 6 colors.palette.accent}ff";
  			selection = "${builtins.substring 1 6 colors.palette.bg_alt}ff";
  			selection-text = "${builtins.substring 1 6 colors.palette.active}ff";
  			border = "${builtins.substring 1 6 colors.palette.border_focus}ff";
  		};
  		border = {
  			width = 2;
  			radius = 8;
  		};
  	};
  };



  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
          
    config = {
      modifier = "Mod4";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      window.titlebar = false;
      window.border = 1;
      # smartBorders = "on";
      gaps = {
      	inner = 8;
      	outer = 4;
      };
	  colors = {
	  	focused = {
	  		background = colors.palette.accent;
	  		border = colors.palette.border_focus;
	  		childBorder = colors.palette.border_focus;
	  		indicator = colors.palette.active;
	  		text = colors.palette.bg_main;
	  	};
	    focusedInactive = {
	    	background = colors.palette.bg_alt;
	    	border = colors.palette.border_normal;
	    	childBorder = colors.palette.border_normal;
	    	indicator = colors.palette.bg_alt;
	    	text = colors.palette.fg_muted;
	    };
	  };
      
	  startup = [
	  	{ command = "pkill swaybg; ${pkgs.swaybg}/bin/swaybg -i /home/Jean/wallpaper/gargantua.jpg -m fill"; always = true; }
	  	# { command = "waybar"; always = true; }
	  ];

	  bars = [];
	  
	  menu = "${pkgs.fuzzel}/bin/fuzzel";
	  
#       keybindings = let
#         mod = "Mod4";
#       in pkgs.lib.mkOptionDefault {
#         # --- Worspace ---
#         "${mod}+ampersand" = "workspace number 1";
#         "${mod}+eacute" = "workspace number 2";
#         "${mod}+quotedbl" = "workspace number 3";
#         "${mod}+apostrophe" = "workspace number 4";
#         "${mod}+parenleft" = "workspace number 5";
#         "${mod}+minus" = "workspace number 6";
#         "${mod}+egrave" = "workspace number 7";
#         "${mod}+underscore" = "workspace number 8";
#         "${mod}+ccedilla" = "workspace number 9";                
#         "${mod}+agrave" = "workspace number 10";
# 
#         # --- Déplacer les fenêtres ---
#         "${mod}+Shift+ampersand" = "move container to workspace number 1";
#         "${mod}+Shift+eacute" = "move container to workspace number 2";
#         "${mod}+Shift+quotedbl" = "move container to workspace number 3";
#         "${mod}+Shift+apostrophe" = "move container to workspace number 4";
#         "${mod}+Shift+parenleft" = "move container to workspace number 5";
#         "${mod}+Shift+minus" = "move container to workspace number 6";
#         "${mod}+Shift+egrave" = "move container to workspace number 7";
#         "${mod}+Shift+underscore" = "move container to workspace number 8";
#         "${mod}+Shift+ccedilla" = "move container to workspace number 9";                
#         "${mod}+Shift+agrave" = "move container to workspace number 10";                
#       };

		keybindings = let
        	mod = "Mod4";
        in pkgs.lib.mkOptionDefault {
	        # --- Volume (Touches tactiles & Raccourcis) ---
	        "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
	        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
	        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

	        # Raccourcis de secours (Puisque + et - sont pris par les Workspaces)
	        "${mod}+Shift+Up" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
	        "${mod}+Shift+Down" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
	        "${mod}+m" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

	        # --- Workspace ---
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

	  # bars = [
	  # 	{ command = "${pkgs.waybar}/bin/waybar"; }
	  # ];
      
    };
  };
  # systemd.user.targets.sway-session.enable = true;
}
