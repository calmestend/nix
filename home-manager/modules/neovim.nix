{ config, pkgs, ... }:
{
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		plugins = with pkgs.vimPlugins; [
			blink-cmp
			kulala-nvim
		];
		extraPackages = with pkgs; [
			luajitPackages.lua-lsp
				lua-language-server
				typescript-language-server
				emmet-ls
				vscode-langservers-extracted
				pyright
				zls
				stylua
				svelte-language-server
				tinymist
				gopls
				nil
				kdePackages.qtdeclarative
				kulala-fmt
		];
	};
}
