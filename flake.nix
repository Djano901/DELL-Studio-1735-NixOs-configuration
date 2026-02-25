{
  description = "Configuration Flake";

  inputs =  {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
    	url = "github:nix-community/home-manager/release-25.11";
    	inputs.nixpkgs.follows = "nixpkgs";
    };
    arkenfox-nixos.url = "github:dwarfmaster/arkenfox-nixos";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { self, nixpkgs, home-manager, arkenfox-nixos, sops-nix,  ...}@inputs: {
    nixosConfigurations.nix-dell = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.Jean = {
	          imports = [
	          	./home.nix
	          	# ./modules/desktop/firefox.nix
	          	arkenfox-nixos.hmModules.default
	          ];
	      };
          # _module.args = { inherit arkenfox-nixos; };
        }
        inputs.sops-nix.nixosModules.sops
      ];
    };
  };
}
