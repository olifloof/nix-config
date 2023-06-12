{
  lib,
  config,
  ...
}: let
  cfg = config.overworld.programs.helix;
in {
  options.overworld.programs.helix = {
    enable = lib.mkEnableOption "Helix Editor";
  };

  config =
    lib.mkIf cfg.enable {
    };
}
