{ pkgs, ... }:

{
  imports = [
  	./modules/desktop/sway.nix
  	./modules/desktop/waybar.nix
  	./modules/desktop/firefox.nix
  	./modules/dev/ssh.nix
  	./modules/dev/git.nix
  	./modules/dev/tools.nix
  ];


  home.username = "Jean";
  home.homeDirectory = "/home/Jean";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    htop
    neofetch
    micro
    pavucontrol
  ];

  programs.yazi = {
      enable = true;
      enableBashIntegration = true; # Permet de changer de répertoire dans le shell en quittant yazi
      settings = {
        manager = {
          show_hidden = true;
          sort_by = "alphabetical";
        };
      };
    };

  # home.sessionVariables = {
  #   EDITOR = "micro";
  # };

  programs.home-manager.enable = true;

  # programs.git = {
  #   enable = true;
  #   userName = "Jean";
  #   userEmail = "dot.com";
  # };


}
