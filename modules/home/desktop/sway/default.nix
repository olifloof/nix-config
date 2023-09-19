{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.creeper.home.desktop.sway;
in {
  options.creeper.home.desktop.sway = {
    enable = mkEnableOption "Sway";
  };
  wayland.windowManager.sway = mkIf cfg.enable {
    enable = true;
  };
}
