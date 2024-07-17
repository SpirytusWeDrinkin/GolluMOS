{ pkgs, config, username, host, ... }:

let
  inherit (import ./../hosts/${host}/options.nix) gitUsername ;
in {
  users.users = {
    "${username}" = {
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.zsh;
      ignoreShellProgramCheck = true;
      packages = with pkgs; [];
    };
  };
}


