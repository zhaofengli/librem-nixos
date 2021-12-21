{
  description = "Librem 5 NixOS Overlay";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }: let
    supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
  in utils.lib.eachSystem supportedSystems (system: let
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        self.overlay
      ];
    };
  in {
    legacyPackages = pkgs;
  }) // {
    overlay = import ./default.nix;
  };
}
