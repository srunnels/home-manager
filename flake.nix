{
  description = "Home Manager configuration of srunnels";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      # inputs = {
      #     nixpkgs.follows = "";
      # }
    };
  };

  outputs = inputs @ { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
      {
        homeConfigurations."srunnels" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [
            inputs.nix-doom-emacs-unstraightened.homeModule
            ./home.nix
          ];
          extraSpecialArgs = { inherit inputs; };

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        };
      };
}
