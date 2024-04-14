{
  description = "https://cri.epita.fr/users/gollum/";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";

  };

  outputs = inputs@{ home-manager, nixpkgs, impermanence, ... }: 
  let
    
    #host = "nosound";
    system = "x86_64-linux";
    inherit (import ./hosts/${host}/options.nix) username hostname;
    #username = "abelc";
    #hostname = "Camion-pizza-DGSE";

    pkgs = import nixpkgs {
      inherit system;
      config = {
	    allowUnfree = true;
      };
    };
  in 
  {
    nixosConfigurations = {
      "${hostname}" = nixpkgs.lib.nixosSystem {
	    specialArgs = { 
          inherit system; inherit inputs; 
          inherit username; inherit hostname;
          inherit host;
        };
	    modules = [ 
	      ./system.nix
        ];
      };
    };
  };
}
