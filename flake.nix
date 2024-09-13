{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  

outputs = {nixpkgs, home-manager, nixos-wsl, ... }@inputs: {
  nixosConfigurations = {
    nixos-wsl = let
      username = "obi";
      specialArgs = {inherit username;};
    in nixpkgs.lib.nixosSystem {
      inherit specialArgs;
      system = "x86_64-linux";
      modules = [
        nixos-wsl.nixosModules.default
        {
          wsl = {
            enable = true;
            defaultUser = "${username}";
          };
          nixpkgs.config.allowUnfree = true;
          nix.settings = {
            experimental-features = [ "nix-command" "flakes" ];
            extra-experimental-features = ["nix-command"];
          };
          system.stateVersion = "24.05";
          environment.systemPackages = with nixpkgs; [
            vim
            git
            curl
            wget
            fzf
          ];
        }
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = inputs // specialArgs;
          home-manager.users.${username} = ./users/${username}/home.nix;
        }
      ];
    };

    desktop = let
      username = "obi";
      specialArgs = {inherit username;};
    in nixpkgs.lib.nixosSystem {
      inherit specialArgs;
      system = "x86_64-linux";
      modules = [
        ./systems/home-desktop/configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = inputs // specialArgs;
          home-manager.users.${username} = ./users/${username}/home.nix;
          home-manager.backupFileExtension = "backup";
        }
        ./programs/gaming
      ];
    };
  };
};
}
