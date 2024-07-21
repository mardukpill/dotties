{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";

    };

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # snowfall
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprland-contrib.url = "github:hyprwm/contrib";

    # spicetify
    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hardware.url = "github:nixos/nixos-hardware";
    razer-laptop-control.url = "github:Razer-Linux/razer-laptop-control-no-dkms";

    nixvim.url = "github:nix-community/nixvim";
    swww.url = "github:LGFae/swww";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs =
    inputs:
    let
      inherit (inputs) snowfall-lib;
      lib = snowfall-lib.mkLib {
        inherit inputs;
        src = ./.;

        snowfall = {
          namespace = "dotties";
          meta = {
            # for use with Frost
            name = "dotties";
            title = "dotties";
          };
        };
      };
    in
    lib.mkFlake {
      channels-config = {
        allowUnfree = true;
      };
      homes.modules = with inputs; [
        nixvim.homeManagerModules.nixvim
        spicetify-nix.homeManagerModules.default
        nix-colors.homeManagerModules.default
        anyrun.homeManagerModules.default
      ];

      systems.modules.nixos = with inputs; [ home-manager.nixosModules.home-manager ];

      systems.hosts.blade.modules = with inputs; [
        hardware.nixosModules.common-cpu-intel
        hardware.nixosModules.common-pc-laptop
        hardware.nixosModules.common-pc-laptop-ssd

        razer-laptop-control.nixosModules.default

        nix-index-database.nixosModules.nix-index
      ];

      deploy = lib.mkDeploy { inherit (inputs) self; };
      outputs-builder = channels: { formatter = channels.nixpkgs.nixfmt-rfc-style; };
    };
}
