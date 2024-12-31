{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
	ghostty = {
		url = "github:ghostty-org/ghostty";
	};
  };

  outputs = { self, nixpkgs, ghostty, ... }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

    config = {
	  allowUnfree = true;
    };
  };

  in
  {
    
  nixosConfigurations = {

     nixos = nixpkgs.lib.nixosSystem {
       specialArgs = { inherit system; };

       modules = [
	     ./nixos/configuration.nix
		 { 
		   environment.systemPackages = [ ghostty.packages.x86_64-linux.default ];
		 }
       ];
     };
  };

  };
}
