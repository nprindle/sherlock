{ nixpkgs   ? <nixpkgs>
, enableTor ? true
}:

(import nix/default.nix { inherit nixpkgs enableTor; }).sherlock
