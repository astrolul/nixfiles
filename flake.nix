{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nvf.url = "github:notashelf/nvf";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";  # Pin to stable branch for compatibility
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dwm-src = {
      url = "path:/home/astrolul/dotfiles/suckless/suckless/dwm-6.6";
      flake = false;
    };

    # New GitHub flake inputs for suckless tools
    st-src.url = "github:astrolul/st";  # Adjust to your repo name/ref (e.g., /v0.9.3)
    slstatus-src.url = "github:astrolul/slstatus";
    dmenu-src.url = "github:astrolul/dmenu";

    rofi-merah-custom = {
      url = "path:/home/astrolul/dotfiles/rofi/.config/rofi/themes/merah.rasi";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nvf, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit  inputs; };  # Pass all inputs (including srcs) to system modules like configuration.nix
      modules = [
        ./configuration.nix
        home-manager.nixosModules.default
        nvf.nixosModules.default
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {  # Pass individual srcs for suckless.nix
              inherit (inputs) st-src dmenu-src slstatus-src rofi-merah-custom;
            };
            users.astrolul.imports = [ ./home.nix ];
          };
        }
      ];
    };
  };
}
