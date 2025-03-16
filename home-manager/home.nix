{ pkgs, inputs, ... }:

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
	home.stateVersion = "25.05"; # Please read the comment before changing.

	# Allow unfree
	nixpkgs.config.allowUnfree = true;

	# Enable fish shell
	programs.fish = {
		interactiveShellInit = ''
			set fish_greeting
			zoxide init fish | source
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
			jdt-language-server
			stylua
			svelte-language-server
		];
	};

	programs.helix = {
		enable = true;
		extraPackages = with pkgs; [
			nixd
			taplo
			typescript-language-server
			svelte-language-server
			zls
			emmet-ls
			vscode-langservers-extracted
			superhtml
		];
	};

	# Tmux
	programs.tmux = {
      enable = true;
      shell = "${pkgs.fish}/bin/fish";
      terminal = "tmux-256color";
      historyLimit = 100000;
      prefix = "C-f";
      plugins = with pkgs; [
        tmuxPlugins.vim-tmux-navigator
        tmuxPlugins.sensible
	    inputs.tmux-sessionx.packages.x86_64-linux.default
      ];
      extraConfig = ''
        set -g @sessionx-bind "o"
        set -g @sessionx-zoxide-mode "on"
		set -g @sessionx-custom-paths '/home/barac/work,/home/barac/personal'
	  '';
	};

	# Packages
	home.packages = with pkgs; [
		obsidian
		yazi
		chromium
		tidal-hifi
		nodejs_22
		bun
		pavucontrol
		htop
		fastfetch
		git
		gh
		xfce.xfce4-screenshooter
		wl-clipboard
		zig
		gcc
		httpie
		httpie-desktop
		jq
		grim
		slurp
		discord
		nitrogen
		picom
		xclip
		mpv
		unrar
		lutris
		go
		mongosh
		gimp
		pass
		gnupg
		pinentry
		zathura
		turso-cli
		sqld
		sql-studio
		tree
		zip
		unzip
		ghostty
		zed-editor
		libreoffice
		fzf
		zoxide
		surf

		# Fonts
		noto-fonts
		source-han-sans-japanese
		source-han-serif-japanese
		nerd-fonts.iosevka
		corefonts
		vistafonts

		# Minecraft
		lunar-client

		# Anime
		ani-cli

		# Wine
		wine
		bottles
		winetricks
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
