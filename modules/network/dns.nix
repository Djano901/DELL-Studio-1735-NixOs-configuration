{ config, pkgs, ... }:

{
  # On s'assure que les outils de diagnostic sont présents sur le système
  environment.systemPackages = with pkgs; [
    dnsutils
    ldns # pour la commande 'drill'
  ];

  networking = {
    # 1. On définit les DNS NordVPN au niveau global (Source: NordVPN Official)
    nameservers = [ 
      "103.86.96.100" 
      "103.86.99.100" 
    ];

    # 2. On empêche NetworkManager d'écraser la config avec les DNS de ta Box
    networkmanager.dns = "systemd-resolved";
    
    # 3. Optionnel : Si tu veux un "Kill Switch" DNS total au niveau DHCP
    dhcpcd.extraConfig = "nohook resolv.conf";
  };

  # 4. Configuration de systemd-resolved (le gestionnaire intelligent)
  services.resolved = {
    enable = true;
    # DNS-over-TLS : NordVPN ne le supporte pas nativement sur ces IPs, 
    # donc on le laisse en "opportuniste" ou désactivé pour éviter les blocages.
    # dnsoverhttps = "false";
    dnssec = "allow-downgrade";
    
    # Évite de retomber sur les DNS de Google si NordVPN est injoignable
    fallbackDns = [ "9.9.9.9" ]; 
    
    extraConfig = ''
      DNSOverHTTPS=no
      DNSStubListener=yes
      ReadEtcHosts=yes
    '';
  };

  # 5. Intégration Arkenfox via Home-Manager
  # On force Firefox à respecter le DNS système au lieu de son propre DoH
  # home-manager.users.${yourUsername} = {
  #   programs.firefox = {
  #     profiles.${yourProfileName} = {
  #       settings = {
  #         "network.trr.mode" = 5; # 5 = Désactivé (utilise le DNS système)
  #         "network.dns.disableIPv6" = true; # Souvent recommandé avec VPN pour éviter les fuites
  #       };
  #     };
  #   };
  # };
}
