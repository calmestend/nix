{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
		];

	# Bootloader.
	boot.loader.grub.enable = true;
	boot.loader.grub.device = "/dev/nvme0n1";
	boot.loader.grub.useOSProber = true;

	networking.hostName = "nixos"; # Define your hostname.
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Enable networking
	networking.networkmanager.enable = true;

	environment.sessionVariables = {
		EDITOR = "nvim";
		STARSHIP_CONFIG = "/home/barac/.config/starship/starship.toml";
		LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
	};

	# Enable opengl
	hardware.graphics.enable = true;
	hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
	hardware.nvidia.open = false;
	services.xserver.videoDrivers = ["nvidia"];

	# Enable x11
	services.xserver.enable = true;

	# Enable sound with pipewire.
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

	# Steam
	programs.steam.enable = true;

	# Enable nix-ld
	programs.nix-ld.enable = true;
	programs.nix-ld.libraries = with pkgs; [
		zlib 
		libgcc  
		stdenv.cc.cc
		gcc
		glibc
	];

	# Experimental Features
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# Set your time zone.
	time.timeZone = "America/Mexico_City";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

	# Enable Sway 
	programs.sway.enable = true;

	# Enable lydm
	services.displayManager.ly.enable = true;

	# Fixing share screen
	xdg.portal = {
		enable = true;
		config = {common = {default = "wlr";};};
		wlr.enable = true;
		wlr.settings.screencast = {
			output_name = "DP-1";
			chooser_type = "simple";
			chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
		};
	};

	# Enable i3
	services.xserver = {
		desktopManager = {
			xterm.enable = false;
		};

		windowManager.i3 = {
			enable = true;
			extraPackages = with pkgs; [
				dmenu 
				i3status 
				i3lock 
				i3blocks 
			];
		};
	};

	# Enable shell
	programs.fish.enable = true;

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.barac = {
		isNormalUser = true;
		description = "Barac Fabregat";
		extraGroups = [ "networkmanager" "wheel" "audio" ];
		shell = pkgs.fish;
		packages = with pkgs; [];
	};

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		home-manager
		vim
	];

	networking.firewall.enable = true;
	networking.firewall.allowedTCPPorts = [ 80 443 5000 ];

	system.stateVersion = "24.11"; # Did you read the comment?
}
