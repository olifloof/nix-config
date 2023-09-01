{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.creeper.home.apps.helix;
in {
  options.creeper.home.apps.helix = {
    enable = mkEnableOption "Helix Editor";
  };
  config = mkIf cfg.enable {
    programs = {
      helix = {
        enable = true;
        defaultEditor = true;
        settings = {
          theme = "catppuccin_mocha";
          editor = {
            auto-format = true;
            auto-save = true;
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
          language-server.nil = {
            command = "${pkgs.nil}/bin/nil";
          };
          language = [
            {
              name = "nix";
              formatter = {
                command = "${pkgs.alejandra}/bin/alejandra";
              };
              config.nil.nix.flake.autoEvalInputs = true;
            }
          ];
        };
      };
    };
  };
}
