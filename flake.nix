{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    # Home manager
    home-manager= {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {

    # TODO Find way to reuse more of code below between 
    # laptop and desktop
    nixosConfigurations.nixos-desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
      	./hardware_configuration/desktop.nix
        ./configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.andrew = import ./home.nix;
        }
      ];
    };
    nixosConfigurations.nixos-laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
      	./hardware_configuration/laptop.nix
        ./configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.andrew = import ./home.nix;
        }
      ];
    };
  };
}
