{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nvf.url = "github:notashelf/nvf";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dwm-src = { url = "github:astrolul/dwm"; flake = false; };
    dwm-secondary-src = { url = "github:astrolul/dwm/secondary"; flake = false; };
    st-src = { url = "github:astrolul/st"; };
    slstatus-src = { url = "github:astrolul/slstatus"; };
    dmenu-src = { url = "github:astrolul/dmenu"; };
    dmenu-secondary-src = { url = "github:astrolul/dmenu/secondary"; };
    rofi-merah-custom = { url = "path:./merah.rasi"; flake = false; };
  };

  outputs = { self, nixpkgs, nvf, home-manager, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/nixos/configuration.nix
          home-manager.nixosModules.default
          nvf.nixosModules.default
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit (inputs) rofi-merah-custom; };
              users.astrolul.imports = [ ./home-manager/home.nix ];
            };
          }
        ];
      };

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
              extraSpecialArgs = { inherit (inputs) rofi-merah-custom; };
              users.astrolul.imports = [ ./home-manager/home.nix ];  # Reuse shared Home Manager, or customize if needed
            };
          }
        ];
      };

      # Add as many as needed, e.g.:
      # server = nixpkgs.lib.nixosSystem { ... };  # Similar structure
    };
  };
}
