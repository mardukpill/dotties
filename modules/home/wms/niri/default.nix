{
  # Snowfall Lib provides a customized `lib` instance with access to your flake's library
  # as well as the libraries available from your flake's inputs.
  lib,
  # An instance of `pkgs` with your overlays and packages applied is also available.
  pkgs,
  # You also have access to your flake's inputs.
  inputs,

  # Additional metadata is provided by Snowfall Lib.
  namespace, # The namespace used for your flake, defaulting to "internal" if not set.
  system, # The system architecture for this host (eg. `x86_64-linux`).
  target, # The Snowfall Lib target for this system (eg. `x86_64-iso`).
  format, # A normalized name for the system target (eg. `iso`).
  virtual, # A boolean to determine whether this system is a virtual target using nixos-generators.
  systems, # An attribute map of your defined hosts.

  # All other arguments come from the module system.
  config,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption types;
  inherit (lib.${namespace}) mkOpt enabled;
  inherit (inputs) niri;

  theme = import ./theme.nix { inherit config lib; };

  cfg = config.${namespace}.wms.niri;
in
{

  imports = [
    ./binds/main.nix
  ];

  options.${namespace}.wms.niri = {
    enable = mkEnableOption "niri.";
  };

  config = mkIf cfg.enable {

    programs.niri = {
      settings = {
        window-rules = theme.window-rules;
        layout = theme.layout;
        environment = {
          "DISPLAY" = "0";
        };
      };
    };

    dotties.utility.mako = enabled;
    dotties.utility.waybar = enabled;
    dotties.utility.wlogout = enabled;
    dotties.utility.swappy = enabled;
    dotties.utility.anyrun = enabled;

    dotties.services.xwayland-satellite = enabled;

    dotties.services.swww = {
      enable = true;
      wallpaperPath = "/media/shared/pictures/wallpapers/rose_pine_noiseline.png";
    };

    services.playerctld.enable = true;

    home = {
      packages = with pkgs; [
        wl-mirror
        wl-clipboard

        gtk-engine-murrine # TODO: move to dedicated file

        playerctl
      ];

      pointerCursor = {
        name = "phinger-cursors-dark";
        package = pkgs.phinger-cursors;
        gtk.enable = true;
        size = 32;
      };

      sessionVariables = {
        MOZ_ENABLE_WAYLAND = 1;
        QT_QPA_PLATFORM = "wayland";
        NIXOS_OZONE_WL = 1;
        DISPLAY = 0;
      };
    };
  };
}
