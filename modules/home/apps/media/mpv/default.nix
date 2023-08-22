{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.creeper.home.media.mpv;
in {
  options.creeper.home.media.mpv = {
    enable = mkEnableOption "mpv";
  };
  config = mkIf cfg.enable {
    programs.mpv = {
      enable = true;
      scripts = [
        pkgs.mpvScripts.uosc
        pkgs.mpvScripts.mpris
      ];
    };
  };
}
