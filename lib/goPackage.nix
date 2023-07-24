{ pkgs, version }:
let
  allMinors = builtins.fromJSON (builtins.readFile ../go-lock.json);
  minorAttrs = allMinors.${version};
  url = "https://github.com/golang/go.git";

  # 1.19 -> 1_19
  defaultMinorVersion = builtins.replaceStrings [ "." ] [ "_" ] version;
  defaultMinor = pkgs."go_${defaultMinorVersion}";

  goVer = if minorAttrs.minor == "" then "go_${minorAttrs.major}" else "go_${minorAttrs.major}_${minorAttrs.minor}";
  versionedPackage = pkgs.buildPackages.${goVer}.overrideAttrs (final: prev: {
    version = minorAttrs.version;
    src = builtins.fetchGit {
      inherit url;
      inherit (minorAttrs) ref rev;
    };
  });

  customDerivation = version;
  versioned = if builtins.hasAttr version allMinors then versionedPackage else defaultMinor;

  oldPackage = pkgs.customGo or pkgs.go;
in
{
  set = customDerivation;
  string = versioned;
  null = oldPackage;
}.${builtins.typeOf version}
