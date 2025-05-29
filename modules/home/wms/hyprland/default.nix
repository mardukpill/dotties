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
  inherit (inputs) hyprland;

  hyprland-plugins = inputs.hyprland-plugins.packages.${pkgs.system};
  cfg = config.${namespace}.wms.hyprland;
in
{
  options.${namespace}.wms.hyprland = {
    enable = mkEnableOption "hyprland.";
    theme = mkOpt (types.enum [
      "rose-pine"
      "acrylic"
    ]) "rose-pine" "The theme to use with Hyprland.";
  };

  imports = lib.snowfall.fs.get-non-default-nix-files-recursive ./.;

  config = mkIf cfg.enable {
    dotties.utility.mako = enabled;
    dotties.utility.waybar = enabled;
    dotties.utility.wlogout = enabled;
    dotties.utility.swappy = enabled;

    dotties.services.xwayland-satellite = enabled;
    dotties.services.hypridle = {
      enable = true;
    };

    dotties.services.swww = {
      enable = true;
      wallpaperPath =
        {
          "rose-pine" = "/media/shared/pictures/wallpapers/bay.JPG";
          "acrylic" = "/media/shared/pictures/wallpapers/mountains.jpg";
          # "/media/shared/pictures/wallpapers/vim.png";
        }
        ."${cfg.theme}";
    };

    services.playerctld.enable = true;

    home = {
      packages = with pkgs; [
        wl-mirror
        wl-clipboard
        wlr-randr

        hyprpicker

        grimblast
        dotties.hyprzoom

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
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;

      package = hyprland.packages.${system}.hyprland;

      plugins = with hyprland-plugins; [
      ];
    };
  };
}
