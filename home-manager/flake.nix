{
  description = "Home Manager configuration of barac";

  inputs = {
    tmux-sessionx.url = "github:omerxx/tmux-sessionx";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.barac = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inputs = self.inputs; };
        modules = [ ./home.nix ];
      };
    };
}

