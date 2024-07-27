# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		];

# Bootloader.
	boot.loader.grub.enable = true;
	boot.loader.grub.device = "/dev/sda";
	boot.loader.grub.useOSProber = true;

	environment.pathsToLink = [ "/libexec" ];

	networking.hostName = "nixos"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
	networking.networkmanager.enable = true;

# Set your time zone.
	time.timeZone = "America/Mexico_City";

# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

# Set fonts
	fonts.packages = with pkgs; [
		(nerdfonts.override { fonts = [ "Mononoki" ]; })
	];

# Android Setup
	programs.adb.enable = true;
	services.udev.packages = [
		pkgs.android-udev-rules
	];

# Select zsh as default
	users.defaultUserShell = pkgs.zsh;

# Enable zsh and oh-my-zsh

	programs = {
		zsh = {
			enable = true;
			autosuggestions.enable = true;
			zsh-autoenv.enable = true;
			syntaxHighlighting.enable = true;

			shellAliases = {
				vim = "nvim";
			};

			ohMyZsh = {
				enable = true;
				theme = "robbyrussell";
				plugins = [
					"git"
					"npm"
				];
			};

		};
	};

# Enable the X11 windowing system.

# Enable the i3 Window Manager
	services.displayManager.defaultSession = "none+i3";
	services.xserver = {
		enable = true;

		desktopManager = {
			xterm.enable = false;
		};


		windowManager.i3 = {
			enable = true;
			extraPackages = with pkgs; [
				dmenu #application launcher most people use
					i3status # gives you the default i3 status bar
					i3lock #default i3 screen locker
					i3blocks #if you are planning on using i3blocks over i3status
			];
		};
	};



# Configure keymap in X11
	services.xserver = {
		xkb.layout = "us";
		xkb.variant = "";
	};

# Enable CUPS to print documents.
	services.printing.enable = false;

# Enable sound with pipewire.
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
# If you want to use JACK applications, uncomment this
#jack.enable = true;

# use the example session manager (no others are packaged yet so this is enabled by default,
# no need to redefine it in your config for now)
#media-session.enable = true;
	};

# Enable touchpad support (enabled default in most desktopManager).
# services.xserver.libinput.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.barac = {
		isNormalUser = true;
		description = "Barac Fabregat";
		extraGroups = [ "networkmanager" "wheel" "adbusers" ];
	};

# Install firefox.
	programs.firefox.enable = true;

# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

# Enable VMware
virtualisation.virtualbox.host.enable = true;
virtualisation.virtualbox.host.enableExtensionPack = true;
users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

# List packages installed in system profile. To search, run:
# $ nix search wget
	environment.systemPackages = with pkgs; [
		neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
			wget
			mpv
			yazi
			git
			github-cli
			nodejs
			kitty
			alacritty
			htop
			neofetch
			pavucontrol
			zip
			unzip
			zig
			libgcc
			rustc
			gnumake
			vscode
			insomnia
			spectacle
			krita
			floorp
			spotify
	];

	networking.firewall.enable = true;
	networking.firewall.allowedTCPPorts = [ 80 443 57621 ];
	networking.firewall.allowedUDPPorts = [ 5353 ];

	services.httpd.enable = true;
	services.httpd.package = pkgs.apacheHttpd;

	services.httpd.enablePHP = true; # oof... not a great idea in my opinion
	services.httpd.phpPackage = pkgs.php;
	
	services.mysql.enable = true;
	services.mysql.package = pkgs.mariadb;

	services.httpd.virtualHosts."duliarodse.com" = {
		documentRoot = "/var/www/duliarodse.com";
	};


	systemd.tmpfiles.rules = [
		"d /var/www/duliarodse.com"
		"f /var/www/duliarodse.com/index.php - - - - <?php phpinfo();"
	];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "24.05"; # Did you read the comment?

}
