{ ... }:
{
  programs.nixvim = {
    plugins = {
      codecompanion.enable = true;
    };
  };
}
