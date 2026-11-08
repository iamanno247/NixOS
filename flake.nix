{
  inputs = {
    ryoku = {
      url = "github:ryoku-dev/Ryoku-on-NixOS/unstable-dev";
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Add voxtype here
    voxtype = {
      url = "github:peteonrails/voxtype";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    sls-steam = {
      url = "github:AceSLS/SLSsteam";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:4evy/nixcord/3cc16a5520810b84b3ebb21416402d3a0620ad34";
    };
  };

  # Include voxtype in your outputs arguments
  outputs = { ryoku, zen-browser, sls-steam, nixpkgs, home-manager, voxtype, nixcord, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inherit inputs;
      };

      modules = [
        ./ryoku.nix
        ryoku.nixosModules.default
        ./modules/ryoku.nix
        ./configuration.nix

        home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.backupFileExtension = "backup";

          home-manager.extraSpecialArgs = {
            inherit inputs;
          };

          home-manager.users.anno = import ./home.nix;
        }
      ];
    };
  };
}
