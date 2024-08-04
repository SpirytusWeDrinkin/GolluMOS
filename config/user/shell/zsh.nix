{ pkgs, ... }:

{
  imports = [
    ./starship.nix
  ];

  programs.zsh = {
    enable = true;
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "c3d4e576c9c86eac62884bd47c01f6faed043fc5";
          sha256 = "1m8yawj7skbjw0c5ym59r1y88klhjl6abvbwzy6b1xyx3vfb7qh7";
        };
      }      
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "e0165eaa730dd0fa321a6a6de74f092fe87630b0";
          hash = "sha256-4rW2N+ankAH4sA6Sa5mr9IKsdAg7WTgrmyqJ2V1vygQ=";
        };
      }
    ];
    shellAliases = {
      v = "nvim";
      ls = "lsd";
      c = "clear";
      hrc = "nvim ~/.dotfiles/flake.nix";
      config = "nvim ~/.dotfiles/configuration.nix";
      rebuild = "sudo nixos-rebuild switch --flake ~/.dotfiles/#system";
      home = "home-manager switch --flake ~/.dotfiles/#user";
      shell = "nix-shell --run \"zsh\"";
      ":wq" = "exit";
    };
    initExtra = ''
      ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    '';
  };
}
