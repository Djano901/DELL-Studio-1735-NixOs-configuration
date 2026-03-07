{ config, pkgs, ... }:

let

	wgnordTemplate = pkgs.writeText "template.conf" ''
		[Interface]
		PrivateKey = PRIVKEY
		Address = 10.5.0.2/32
		MTU = 1350
		DNS = 103.86.96.100 103.86.99.100

		[Peer]
		PublicKey = SERVER_PUBKEY
		AllowedIPs = 0.0.0.0/0, ::/0
		Endpoint = SERVER_IP:51820
		PersistentKeepalive = 25
	'';
in
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
		openresolv
	];

	networking.networkmanager.unmanaged = [ "wgnord" ];
	networking.firewall.checkReversePath = false;
	networking.firewall.allowedUDPPorts = [ 51820 ];

	systemd.services.wgnord-login = {
		description = "Authentification automatique à NordVPN via wgnord";
		wants = [ "network-online.target" ];
		after = [ "network-online.target" "sops-nix.service" ];
		wantedBy = [ "multi-user.target" ];
		
		# path = with pkgs; [
		# 	wgnord
		# 	wireguard-tools
		# 	iproute2
		# 	iptables
		# 	openresolv
		# 	bash
		# 	coreutils
		# 	jq
		# ];	
		#
		serviceConfig = {
			Type = "oneshot";
			RemainAfterExit = true;
			StateDirectory = "wgnord";
			StateDirectoryMode = "0700";
			# CapabilityBoundingSet = "CAP_NET_ADMIN CAP_SYS_MODULE";
		};

		script = ''
			ln -fs ${wgnordTemplate} /var/lib/wgnord/template.conf

			
			mkdir -p /var/lib/wgnord

			if [ ! -f /var/lib/wgnord/credentials.json ]; then
			  echo "{}" > /var/lib/wgnord/credentials.json
			  chmod 600 /var/lib/wgnord/credentials.json
			fi
			
			# export WG_QUICK_USERSPACE_IMPLEMENTATION=wireguard-go

			TOKEN=$(cat ${config.sops.secrets.nordvpn_token.path})
			${pkgs.wgnord}/bin/wgnord login "$TOKEN"
			sleep 2
			${pkgs.wgnord}/bin/wgnord connect france
		'';

		preStop = ''
			${pkgs.wgnord}/bin/wgnord disconnect
		'';
	};

	systemd.tmpfiles.rules = [
		"d /etc/wireguard 0700 root root -"
	];

	# networking.firewall.allowedUDPPorts = [ 51820 ];
}
