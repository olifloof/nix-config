{pkgs, ...}: {
  imports = [./hardware.nix];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.example = {
    isNormalUser = true;
    extraGroups = ["wheel"];
  };
  # Programs
  programs.firefox.enable = true;
  programs.git.enable = true;

  system.stateVersion = "22.05";
}
