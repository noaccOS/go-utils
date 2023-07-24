lib:
{ go ? null }:
final: prev:
let
  goPackage = import ./goPackage.nix;

  customGo = goPackage { pkgs = prev; version = go; };
  goVer = lib.strings.replaceStrings ["."] [""] (lib.versions.majorMinor customGo.version);
  buildGoCustomModule = prev."buildGo${goVer}Module".override { go = customGo; };
in
{
  inherit customGo buildGoCustomModule;
  gopls = prev.gopls.override { buildGoModule = buildGoCustomModule; };
}
