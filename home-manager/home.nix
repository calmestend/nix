{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "barac";
  home.homeDirectory = "/home/barac";

  home.stateVersion = "25.05"; 

	# Allow unfree
	nixpkgs.config.allowUnfree = true;

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
			tinymist
			gopls
			nixd
			omnisharp-roslyn
		];
	};

	# Tmux
	programs.tmux = {
      enable = true;
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "tmux-256color";
      historyLimit = 100000;
      prefix = "C-f";
      plugins = with pkgs; [
        tmuxPlugins.vim-tmux-navigator
        tmuxPlugins.sensible
				tmuxPlugins.tmux-sessionx
      ];
      extraConfig = ''
        set -g @sessionx-bind "o"
        set -g @sessionx-zoxide-mode "on"
				set -g @sessionx-custom-paths '/home/barac/work,/home/barac/personal'
	  '';
	};

	services.mako.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
		zig
		lazygit
    chromium
		firefox
    discord
		tidal-hifi
		pass
		httpie-desktop
		postman
		jq
		ripgrep	
		typst
		katana

    alacritty
		kitty
		ghostty

    github-cli
    yazi

		zathura
		lunar-client

		nerd-fonts.iosevka
		wine
		wineWayland
		winetricks
		lutris

		fastfetch
		nodejs
		ffmpeg
		wf-recorder
		nikto
		qbittorrent
		r2modman
		spotify
		unrar
		htop
		zip
		unzip

		awscli2
		sqlcmd
		sql-studio

		mssql_jdbc
		unixODBC
	
		mono
		emacs
		mesa
		libGL
		vulkan-loader
		dotnet-sdk
		dotnet-runtime
		omnisharp-roslyn
		obs-studio
		fd
		vscode
		bun
  ];

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

  home.sessionVariables = {
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
