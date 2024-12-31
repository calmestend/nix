{ config, pkgs, ... }:

{
	# Home Manager needs a bit of information about you and the paths it should
	# manage.
	home.username = "barac";
	home.homeDirectory = "/home/barac";

	# This value determines the Home Manager release that your configuration is
	# compatible with. This helps avoid breakage when a new Home Manager release
	# introduces backwards incompatible changes.
	#
	# You should not change this value, even if you update Home Manager. If you do
	# want to update the value, then make sure to first check the Home Manager
	# release notes.
	home.stateVersion = "24.11"; # Please read the comment before changing.

	# Allow unfree
	nixpkgs.config.allowUnfree = true;

	# Enable fish shell
	programs.fish = {
		interactiveShellInit = ''
			set fish_greeting
		'';

		shellAliases = {
			"vim" = "nvim";
		};
	};

	# Enable starship
	programs.starship = {
		enable = true;
		enableFishIntegration = true;
	};

	# Fonts
	fonts.fontconfig.enable = true;

	# Neovim
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		viAlias = true;
		vimAlias = true;
		vimdiffAlias = true;
		# LSP
		extraPackages = with pkgs; [
			luajitPackages.lua-lsp
			lua-language-server
			typescript-language-server
			emmet-ls
			vscode-langservers-extracted
			pyright
			zls
		];
	};

	# Tmux
	programs.tmux = {
		enable = true;
		shell = "${pkgs.fish}/bin/fish";
		terminal = "tmux-256color";
		historyLimit = 100000;
		prefix = "C-f";
		plugins  = with pkgs; [
			tmuxPlugins.vim-tmux-navigator
			tmuxPlugins.sensible
		];
	};

	# Packages
	home.packages = with pkgs; [
		obsidian
		yazi
		chromium
		thunderbird
		tidal-hifi
		nodejs_22
		pavucontrol
		htop
		fastfetch
		git
		gh
		xfce.xfce4-screenshooter
		wl-clipboard
		krita
		zig
		gcc
		httpie
		jq
		grim
		slurp
		discord
		zathura
		pcmanfm
		nitrogen
		picom
		xclip
		mpv
		unrar

		# Fonts
		noto-fonts
		source-han-sans-japanese
		source-han-serif-japanese
		nerd-fonts.iosevka

		# Minecraft 	
		badlion-client
	];

	# Home Manager is pretty good at managing dotfiles. The primary way to manage
	# plain files is through 'home.file'.
	home.file = {
		# # Building this configuration will create a copy of 'dotfiles/screenrc' in
		# # the Nix store. Activating the configuration will then make '~/.screenrc' a
		# # symlink to the Nix store copy.
		# ".screenrc".source = dotfiles/screenrc;

		# # You can also set the file content immediately.
		# ".gradle/gradle.properties".text = ''
		#   org.gradle.console=verbose
		#   org.gradle.daemon.idletimeout=3600000
		# '';
	};

	# Home Manager can also manage your environment variables through
	# 'home.sessionVariables'. These will be explicitly sourced when using a
	# shell provided by Home Manager. If you don't want to manage your shell
	# through Home Manager then you have to manually source 'hm-session-vars.sh'
	# located at either
	#
	#  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
	#
	# or
	#
	#  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
	#
	# or
	#
	#  /etc/profiles/per-user/barac/etc/profile.d/hm-session-vars.sh
	#
	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
