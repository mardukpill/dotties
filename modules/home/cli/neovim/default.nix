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
}: let
	inherit (lib) mkIf mkEnableOption;
  inherit (lib.${namespace}) enabled;
	cfg = config.${namespace}.cli.neovim;

in {
	options.${namespace}.cli.neovim = {
		enable = mkEnableOption "neovim."; 
	};

	imports = [
		./keymaps.nix
	] ++ lib.snowfall.fs.get-non-default-nix-files ./plugins;

	config = mkIf cfg.enable {
		home.packages = with pkgs; [
			ripgrep
		];

		programs.nixvim = {
			enable = true;
			defaultEditor = true;

			viAlias = true;
			vimAlias = true;

			# rice rice rice
			colorschemes.rose-pine.enable = true;
			plugins.transparent.enable = true;

			opts = {
				number = true;
				relativenumber = true;

				shiftwidth = 2;
				tabstop = 2;
			};

			plugins = {
				oil = {
					enable = true;
				};

				fidget = {
					enable = true;
				};

				nvim-colorizer = {
					enable = true;
				};

				nvim-tree = {
					enable = true;
				};

				otter = { # TODO
					enable = true;
				};
			};

			extraConfigLuaPost = ''
				require("otter").activate({ "python", "bash", "fish" }, true, true, nil)
				'';
		};
	};
}
