{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.creeper.home.apps.wezterm;
in {
  options.creeper.home.apps.wezterm = {enable = mkEnableOption "WezTerm";};
  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      enableBashIntegration = true;
      extraConfig = ''

        local wezterm = require 'wezterm'
        local config = {}
        config.font = wezterm.font 'Fira Code'

        config.window_padding = {
          left = 0,
          right = 0,
          top = 0,
          bottom = 0,
        }

        config.use_fancy_tab_bar = false
        config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
        config.hide_mouse_cursor_when_typing = false
        config.color_scheme = "Catppuccin Mocha"
        return config
      '';
    };
  };
}
