{ config, pkgs, ... }:

{
  imports = [
    ./grub.nix
    ./pkgslist.nix
    ./steam.nix
    ./sddm.nix
  ];
}
