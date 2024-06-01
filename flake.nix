{
  description = "My NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
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
            inputs.nixvim.homeManagerModules.nixvim
            ./home/home.nix 
          ];
        };
      };
    };
}
