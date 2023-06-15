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

  config = lib.mkIf cfg.enable {
    programs.helix = {
      enable = true;
      settings = {
        theme = "catppuccin_mocha";
        editor = {
          bufferline = "multiple";
          color-modes = true;
          cursorline = true;
          soft-wrap.enable = true;
        };
        keys.normal = {
          esc = ["collapse_selection" "keep_primary_selection"];
        };
      };
    };
  };
}
