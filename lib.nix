lib:
{
  defaultSystems = lib.platforms.linux ++ lib.platforms.darwin;
  asdfOverlay = import lib/asdfOverlay.nix lib;
  goOverlay = import lib/goOverlay.nix lib;
}
