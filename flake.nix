{
  description = "My NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      # --- SPECIAL ARGS ---
      username = "ben";
      fullName = "Ben";
    in {
      nixosConfigurations = {
        vm = lib.nixosSystem {
          inherit system;
          specialArgs = {
            hostname = "vm";
            inherit username;
            inherit fullName;
          };
          modules = [
            ./system/configuration.nix 
          ];
        };
      };

      homeConfigurations = {
        ben = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit username;
          };
          modules = [
            ./home/home.nix 
          ];
        };
      };
    };
}
