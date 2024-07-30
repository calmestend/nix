{ config, pkgs, ...}:

{
imports =
	[ # Include the results of the hardware scan.
	./hardware-configuration.nix
	];
# Bootloader.
boot.loader.grub.enable = true;
boot.loader.grub.device = "/dev/sda";
boot.loader.grub.useOSProber = true;

networking.hostName = "nixos"; # Define your hostname.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
	networking.networkmanager.enable = true;

# Enable experimental features
programs.nix-ld.enable = true;
nix.settings.experimental-features = [ "nix-command" "flakes"];

# Set fonts
fonts.packages = with pkgs; [
	(nerdfonts.override { fonts = [ "Mononoki" ]; })
];


# Set your time zone.
time.timeZone = "America/Mexico_City";

# Select internationalisation properties.
i18n.defaultLocale = "en_US.UTF-8";

# Enable the X11 windowing system.
services.xserver.enable = true;

# Enable SDDM Display Manager
services.displayManager.sddm.enable = true;

# I Use Sway btw
programs.sway.enable = true;
# Configure keymap in X11
services.xserver.xkb = {
	layout = "us";
	variant = "";
};

# Enable sound with pipewire.
hardware.pulseaudio.enable = false;
security.rtkit.enable = true;
services.pipewire = {
	enable = true;
	alsa.enable = true;
	alsa.support32Bit = true;
	pulse.enable = true;
};

# Set zsh as default
users.defaultUserShell = pkgs.zsh;

# Configure zsh
programs = {
	zsh = {
		enable = true;
		autosuggestions.enable = true;
		zsh-autoenv.enable = true;
		syntaxHighlighting.enable = true;
		ohMyZsh = {
			enable = true;
			theme = "robbyrussell";
			customPkgs = [
				pkgs.nix-zsh-completions
			];
			plugins = [
				"git"
				"npm"
			];
		};
	};
};


# Set neovim as default editor
programs.neovim = {
	enable = true;
	defaultEditor = true;
	vimAlias = true;
};

# Define a user account. Don't forget to set a password with ‘passwd’.
users.users.barac = {
	isNormalUser = true;
	description = "Barac Fabregat";
	extraGroups = [ "networkmanager" "wheel" ];
	packages = with pkgs; [
#  thunderbird
	];
};

# Install firefox.
programs.firefox.enable = true;

# Allow unfree packages
nixpkgs.config.allowUnfree = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
environment.systemPackages = with pkgs; [
	wget
	yazi
	foot
	github-cli
	git
	fuzzel
	htop
	tidal-hifi
	neofetch
	nodejs
	gcc
	unzip
	zip
	zig
	slurp
	grim
	wl-clipboard
	ani-cli
	mpv
	tofi
	cargo
	rustc
	pavucontrol
	nb
	w3m
	lua-language-server
	marksman
];

# Lamp Stack
networking.firewall.enable = true;
networking.firewall.allowedTCPPorts = [ 80 443 5721 ];
networking.firewall.allowedUDPPorts = [ 5353 ];

services.httpd.enable = true;
services.httpd.package = pkgs.apacheHttpd;

services.httpd.enablePHP = true;
services.httpd.phpPackage = pkgs.php;

services.mysql = {
  enable = true;
  package = pkgs.mariadb;
};

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
# networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
system.stateVersion = "24.05"; # Did you read the comment?

}
