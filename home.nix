{ pkgs, ... }:

{
  imports = [
  	./modules/desktop/sway.nix
  	./modules/desktop/waybar.nix
  	./modules/desktop/firefox.nix
  ];


  home.username = "Jean";
  home.homeDirectory = "/home/Jean";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    htop
    neofetch
    micro
  ];

  home.sessionVariables = {
    EDITOR = "micro";
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Jean";
    userEmail = "dot.com";
  };


}
