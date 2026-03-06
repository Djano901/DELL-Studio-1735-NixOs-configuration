{ config, pkgs, ... }:

{
	sops = {
		defaultSopsFile = ../../secrets.yaml;

		defaultSopsFormat = "yaml";

		age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
		
		secrets.nordvpn_token = {
			owner = "root";
		};
	};


	environment.systemPackages = with pkgs; [
		wgnord
		wireguard-tools
		jq
		curl
	];

	systemd.services.wgnord-login = {
		description = "Authentification automatique à NordVPN via wgnord";
		after = [ "network.target" "sops-nix.service" ];
		wantedBy = [ "multi-user.target" ];

		serviceConfig = {
			Type = "oneshot";
			RemainAfterExit = true;
			StateDirectory = "wgnord";
		};

		script = ''
			if [ ! -f /var/lib/wgnord/credentials.json ]; then
			  echo "{}" > /var/lib/wgnord/credentials.json
			  chmod 600 /var/lib/wgnord/credentials.json
			fi
		
			TOKEN=$(cat ${config.sops.secrets.nordvpn_token.path})
			${pkgs.wgnord}/bin/wgnord login "$TOKEN"
			${pkgs.wgnord}/bin/wgnord connect
		'';
	};

	systemd.tmpfiles.rules = [
		"d /etc/wireguard 0700 root root -"
	];

	networking.firewall.allowedUDPPorts = [ 51820 ];
}
