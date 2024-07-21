{ pkgs, ... }:

{
    imports = [
      ./alacritty.nix
      # ./communication
      ./editor
      ./hyprland.nix
      ./menu
      ./nvim.nix
      ./shell
    ];
}
