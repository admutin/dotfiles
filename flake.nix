{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-wayland  = { 
      url = "github:nix-community/nixpkgs-wayland";
     };

    mach-nix =  {
      url = "github:DavHau/mach-nix?ref=3.5.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

    in {
      nixosConfigurations."NiX1-Carbon" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./gnome.nix
          {
            services.gnome.enable = true;
            services.gnome.theme = "Adwaita";
          }
          ./fonts.nix
           ./fish.nix
           { shells.fish.enable = true; }
           ./splash.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.tobi = import ./home.nix;
          }
        ];
      };
    };
}
