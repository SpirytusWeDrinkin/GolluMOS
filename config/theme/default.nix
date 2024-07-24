{ host, ... }:

let inherit (import ../../hosts/${host}/options.nix) colorScheme; in
{
    imports = [
      ./stylix.nix
      ./fonts.nix
      ./colorScheme/${colorScheme}.nix
    ];
}
