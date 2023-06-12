# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./home.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Use the latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Kernel modules
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];

  # Define your hostname.
  networking.hostName = "pc100";

  # srb2 firewall rule
  networking.firewall.allowedUDPPorts = [5029];

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    layout = "gb";
    xkbVariant = "";
  };
  services.flatpak.enable = true;
  console.useXkbConfig = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  programs.sway.enable = true;
  programs.steam.enable = true;
  programs.nix-ld.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Podman
  virtualisation.podman.enable = true;

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.xone.enable = false;
  hardware.ckb-next.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."pinkcreeper100" = {
    isNormalUser = true;
    description = "pinkcreeper100";
    extraGroups = ["wheel" "networkmanager" "dialout"];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
  environment.localBinInPath = true;
  environment.variables = {
    MOZ_ENABLE_WAYLAND = "1";
    EDITOR = "hx";
  };

  # Fonts
  fonts.fonts = [
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk
    pkgs.noto-fonts-emoji
    pkgs.noto-fonts-cjk-sans
    pkgs.fira-code
    pkgs.fira-code-symbols
    pkgs.corefonts
  ];

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    firefox
    prismlauncher
    neofetch
    patchelf
    amberol
    zsh-powerlevel10k
    yt-dlp
    ffmpeg
    scdl
    gh
    stow
    git
    gnumake
    which
    coreutils
    findutils
    ncurses
    curl
    wget
    gawk
    fuse
    asciinema
    gzdoom
    mpv
    zathura
    helix
    texlab
    ltex-ls
    furnace
    obs-studio
    wezterm
    nil
    superTux
    lazygit
    marksman
    armcord
    p7zip
    zsh
    celluloid
    alejandra
    kooha
    xonotic-glx
    qpwgraph
  ];

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
  virtualisation.docker.enable = true;
  programs.gamemode.enable = true;
}
