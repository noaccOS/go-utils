lib:
{ src }:
final: prev:
let
  goOverlay = import ./goOverlay.nix lib;
  asdfVersion = asdfPackages: program: lib.strings.removePrefix "${program} " (lib.lists.findFirst (lib.strings.hasPrefix "${program} ") null asdfPackages);

  contents = builtins.readFile (src + "/.tool-versions");
  packages = lib.strings.splitString "\n" contents;
  goVersion = asdfVersion packages "golang";
in
goOverlay { go = goVersion; } final prev
