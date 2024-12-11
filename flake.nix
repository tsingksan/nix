{
  description = "NixOS systems and tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      mkSystem = import ./configuration.nix {
        inherit nixpkgs inputs;
      };

      darwinConfig =
        if builtins.currentSystem == "aarch64-darwin" then {
          darwin = mkSystem {
            system = "aarch64-darwin";
            darwin = true;
          };
        } else null;
    in
    {
      nixosConfigurations.vm = mkSystem {
        system = "aarch64-linux";

      };

      nixosConfigurations.wsl = mkSystem {
        system = "x86_64-darwin";
        wsl = true;
      };

      darwinConfigurations.darwin = darwinConfig;
    };
}

