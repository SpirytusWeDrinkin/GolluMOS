{ pkgs, username, ... }:

let
  inherit (import ../options.nix) gitUsername ;
in {
  users.users = {
    "${username}" = {
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      shell = pkgs.zsh;
      ignoreShellProgramCheck = true;
    };
  };
}
