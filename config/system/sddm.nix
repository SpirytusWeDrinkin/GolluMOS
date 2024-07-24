{ pkgs, config, host, ... }:

let inherit (import ../../hosts/${host}/options.nix) XkbVariant XkbLayout ;
in
{
  services.xserver = {
    enable = true;
    xkb = {
      variant = "${XkbVariant}";
      layout = "${XkbLayout}";
    };
  };

  services.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
    wayland.enable = true;
    theme = "${import ../packages/sddm-theme.nix { inherit pkgs; }}";
  };

  services.libinput.enable = true;

   environment.systemPackages =
let
    # sddm-theme = pkgs.callPackage ../packages/sddm-theme.nix {};

in [ 
    pkgs.libsForQt5.qt5.qtgraphicaleffects
    pkgs.libsForQt5.qt5.qtquickcontrols
    pkgs.qt6ct
    # sddm-theme
  ]; 
}
