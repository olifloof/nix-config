{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.overworld.programs.helix;
in {
  options.overworld.programs.helix = {
    enable = lib.mkEnableOption "Helix Editor";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      helix = {
        enable = true;
        settings = {
          theme = "catppuccin_mocha";
          editor = {
            bufferline = "multiple";
            color-modes = true;
            completion-trigger-len = 1;
            idle-timeout = 0;
            cursorline = true;
            soft-wrap.enable = true;
          };
          keys = {
            normal = {
              esc = ["collapse_selection" "keep_primary_selection"];
            };
          };
        };
        languages = {
          language = [
            {
              name = "nix";
              formatter = {
                command = "${lib.getExe pkgs.alejandra}";
              };
              config.nil.nix.flake.autoEvalInputs = true;
            }
          ];
        };
      };
    };
  };
}
