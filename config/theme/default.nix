{ ... }:

 let inherit (import ../../options.nix) colorScheme; in
{
    imports = [
        ./fonts.nix
        ./stylix.nix
        ./colorSchemes/${colorScheme}
    ];
}
