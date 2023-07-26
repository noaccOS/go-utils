lib:
rec {
  defaultSystems = lib.platforms.linux ++ lib.platforms.darwin;
  asdfOverlay = import lib/asdfOverlay.nix lib;
  goOverlay = import lib/goOverlay.nix lib;
  simpleGoShell = { pkgs, go ? null, withLSP ? true, withReleaser ? false }:
    let
      overlay = goOverlay { inherit go; };
      finalPkgs = pkgs.extend overlay;
    in
    finalPkgs.callPackage lib/simpleGoShell.nix {
      inherit withLSP withReleaser;
      go = finalPkgs.customGo;
    };
}
