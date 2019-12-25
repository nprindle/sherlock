{ nixpkgs   ? import ./nixpkgs.nix
, enableTor ? true
}:

let
  pkgs = import nixpkgs {
    overlays = [ (import ./overlay.nix) ];
  };
in {
  sherlock = pkgs.callPackage (import ./sherlock.nix) { inherit enableTor; };
}
