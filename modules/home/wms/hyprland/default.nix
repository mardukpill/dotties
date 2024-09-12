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
    theme = mkOpt (types.enum [ "rose-pine" ]) "rose-pine" "The theme to use with Hyprland."; # TODO: currently doesn't effect theming
    idleDelay =
      mkOpt types.ints.unsigned 300
        "The delay blanking before the screen turns off due to idling. Setting to 0 will disable screen idle blanking.";
    lockDelay =
      mkOpt types.ints.unsigned 240
        "The delay before the screen locks due to idling. Setting to 0 will disable idle locking.";
  };

  imports = lib.snowfall.fs.get-non-default-nix-files-recursive ./.;

  config = mkIf cfg.enable {
    dotties.utility.mako = enabled;
    dotties.utility.waybar = enabled;
    dotties.utility.wlogout = enabled;
    dotties.services.swww = {
      enable = true;
      wallpaperPath = "/media/shared/pictures/wallpapers/bay.JPG";
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

        swappy
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
        GRIMBLAST_EDITOR = "swappy --file";
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      systemd = {
        variables = [ "--all" ];
        enableXdgAutostart = true;
        extraCommands = [
          "systemctl --user stop hyprland-session.target"
          "systemctl --user reset-failed"
          "systemctl --user start hyprland-session.target"
        ];
      };

      xwayland.enable = true;

      package = hyprland.packages.${system}.hyprland;

      plugins = with hyprland-plugins; [
        hyprexpo
      ];
    };
  };
}
