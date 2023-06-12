{ config, pkgs, inputs, system, ... }:
{
  home.username = "pinkcreeper100";
  home.homeDirectory = "/home/pinkcreeper100";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
  home.pointerCursor = {
    package = pkgs.gnome.adwaita-icon-theme;
    name = "Adwaita";
    gtk.enable = true;
    x11.enable = true;
  };
}