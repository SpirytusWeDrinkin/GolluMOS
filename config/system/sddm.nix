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
    theme = "tokyo-night-sddm";
  };
  services.libinput.enable = true;

  environment.systemPackages =
let
    sugar = pkgs.callPackage ../packages/sddm-sugar-dark.nix {};
    tokyo-night = pkgs.libsForQt5.callPackage ../packages/sddm-tokyo-night.nix {};
    rose-pine = pkgs.callPackage ../packages/sddm-rose-pine.nix {};

in [ 
    sugar.sddm-sugar-dark # Name: sugar-dark
    tokyo-night # Name: tokyo-night-sddm
    rose-pine # Name: rose-pine-sddm
    pkgs.libsForQt5.qt5.qtgraphicaleffects
  ];
}
