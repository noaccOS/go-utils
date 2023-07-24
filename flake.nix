{
  description = "Utilities to setup go version with nix";
  inputs.nixpkgs.url = "nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      pkgsx86_66-linux = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      lib = import ./lib.nix nixpkgs.lib;
      formatter.x86_64-linux = pkgsx86_66-linux.nixpkgs-fmt;
      packages.x86_64-linux.updateRefs = pkgsx86_66-linux.callPackage ./util/update_sha/default.nix { };
    };
}
