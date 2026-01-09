{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Define your hostname.
  networking.hostName = "tomoko"; 

  services.cloudflare-warp.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable syncthing
  services.syncthing = {
    enable = true;
    openDefaultPorts = true; 
  };


  # Set your time zone.
  time.timeZone = "America/Mexico_City";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:swapescape";
  };

  # Experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 

  # Graphics
  services.xserver.videoDrivers = ["nvidia"];
  hardware.graphics.enable = true;

  hardware.nvidia = {
	  modesetting.enable = true;
	  nvidiaSettings = true;
	  open = false;
  };

  # Steam
  programs.steam.enable = true;

  # Enable audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true; 
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Fish
  programs.fish.enable = true;

  # Flatpak
  services.flatpak.enable = true;

  # Hyprland
  programs.hyprland.enable = true;
  
  # Define a user account. 
  users.users.calmestend = {
    isNormalUser = true;
    description = "calmestend";
    extraGroups = [ "networkmanager" "wheel" "audio"];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall
  networking.firewall.allowedTCPPorts = [ 8080 8081 3000 22000 22067 ];

  system.stateVersion = "25.11"; 
}
