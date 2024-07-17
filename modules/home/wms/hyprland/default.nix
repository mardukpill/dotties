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
  inherit (lib) mkIf mkEnableOption;
  inherit (lib.${namespace}) enabled;
  inherit (inputs) hyprland;
  cfg = config.${namespace}.wms.hyprland;
  grimblast = inputs.hyprland-contrib.packages.${pkgs.hostPlatform.system}.grimblast;

in
{
  options.${namespace}.wms.hyprland = {
    enable = mkEnableOption "hyprland.";
  };

  imports = lib.snowfall.fs.get-non-default-nix-files ./.;

  config = mkIf cfg.enable {
    dotties.apps.rofi = enabled;
    dotties.utility.mako = enabled;
    dotties.utility.waybar = enabled;
    dotties.services.swww = {
      enable = true;
      wallpaperPath = "/media/shared/pictures/wallpapers/bay.JPG";
    };

    home = {
      packages = with pkgs; [
        wl-mirror
        wl-clipboard
        wlr-randr

        hyprpicker

        grimblast
        # hyprzoom

        swappy
        gtk-engine-murrine # TODO: move to dedicated file
        # gnomes-themes-extra
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
        GRIMBLAST_EDITOR = "swappy --file";
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      systemd = {
        variables = [ "--all" ];
        enableXdgAutostart = true;
      };

      xwayland.enable = true;

      package = hyprland.packages.${system}.hyprland;

      plugins = [ ]; # TODO
    };
  };
}
