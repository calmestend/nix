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
networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

	# Enable steam
	programs.steam.enable = true;

	# Flatpak
	services.flatpak.enable = true;

	# Enable razer drivers
	hardware.openrazer.enable = true;
	services.udev.packages = [ pkgs.openrazer-daemon ];

	environment.sessionVariables = {
		EDITOR = "nvim";
		STARSHIP_CONFIG = "/home/barac/.config/starship/starship.toml";
		LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
	};

  # Set your time zone.
  time.timeZone = "America/Mexico_City";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable opengl
  hardware.graphics.enable = true;
	hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
	hardware.nvidia.open = true;
	services.xserver.videoDrivers = ["nvidia"];
	hardware.opengl.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


	programs.nix-ld.enable = true;
	programs.nix-ld.libraries = with pkgs; [
		zlib 
		libgcc  
		stdenv.cc.cc
		gcc
		glibc
		openssl
	];

  # Experimental Features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable lydm
  services.displayManager.ly.enable = true;

	# Sway
	programs.sway.enable = true;
	programs.sway.extraOptions = [ "--unsupported-gpu" ];

	xdg.portal = {
		enable = true;
		wlr.enable = true;
		extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
	};

	# Enable shell
	programs.zsh.enable = true;

	# Enable docker
	virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.barac = {
    isNormalUser = true;
    description = "Barac Fabregat";
		extraGroups = [ "networkmanager" "wheel" "audio" "docker" "plugdev" "openrazer"];
		shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    wget
    gcc
    llvm
    clang-tools
    go
		rustup
		cargo
		starship
		wl-clipboard
		sxiv
		bc
		typst
		manga-tui
		mangal
		ani-cli
		
		libreoffice
		python312
		podman
		tree

		pinentry
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

	# services.mysql.enable = true;
	# services.mysql.package = pkgs.mariadb;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8080 8081 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.05"; 
}
