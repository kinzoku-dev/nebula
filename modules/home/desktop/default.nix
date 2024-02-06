{
  config,
  options,
  lib,
  ...
}:
with lib;
with lib.nebula; {
  options.home.desktop = with types; {
    colorscheme = mkOpt str "catppuccin-mocha" "Theme to use for desktop";
  };

  config = {
  };
}
