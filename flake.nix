{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nvf.url = "github:notashelf/nvf";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nvf, home-manager, ... }@inputs: {
    nixosConfigurations = {

      # New entry for another machine (e.g., "laptop")
      surface = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/surface/configuration.nix  # Point to the new machine's config
          home-manager.nixosModules.default
          nvf.nixosModules.default
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.astrolul.imports = [ ./home-manager/home.nix ];  # Reuse shared Home Manager, or customize if needed
            };
          }
        ];
      };

      # New entry for another machine (e.g., "laptop")
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/desktop/configuration.nix  # Point to the new machine's config
          home-manager.nixosModules.default
          nvf.nixosModules.default
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.astrolul.imports = [ ./home-manager/home.nix ];  # Reuse shared Home Manager, or customize if needed
            };
          }
        ];
      };
    };

      # Add as many as needed, e.g.:
      # server = nixpkgs.lib.nixosSystem { ... };  # Similar structure
      # Add this new section for devShells
      devShells = nixpkgs.lib.genAttrs [ "x86_64-linux" ] (system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        default = (import ./shell.nix { inherit pkgs; });
      });
   };
}
