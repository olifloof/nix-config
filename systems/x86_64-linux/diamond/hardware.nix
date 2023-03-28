{
  config,
  lib,
  pkgs,
  modulesPath,
  inputs,
  ...
}: let
  inherit (inputs) nixos-hardware;
in {
  imports = with nixos-hardware.nixosModules; [
    (modulesPath + "/installer/scan/not-detected.nix")
    common-cpu-amd
    common-gpu-amd
    common-pc
    common-pc-ssd
  ];

  boot = {
    initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod"];
    initrd.kernelModules = [];
    kernelModules = ["kvm-amd"];
    kernelPackages=pkgs.linuxPackages_latest;
    extraModulePackages = [];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  swapDevices = [
    {device = "/dev/disk/by-label/swap";}
  ];

  networking.useDHCP = true;
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
