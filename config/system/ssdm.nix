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
    libinput.enable = true;
  };
  services.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
    wayland.enable = true;
    theme = "tokyo-night-sddm";
  };

  environment.systemPackages =
let
    sugar = pkgs.callPackage ../packages/ssdm-sugar-dark.nix {};
    tokyo-night = pkgs.libsForQt5.callPackage ../packages/ssdm-tokyo-night.nix {};
    rose-pine = pkgs.callPackages ../packages/ssdm-rose-pine.nix {};

in [ 
    sugar.sddm-sugar-dark # Name: sugar-dark
    tokyo-night # Name: tokyo-night-sddm
    pkgs.libsForQt5.qt5.qtgraphicaleffects
  ];
}
