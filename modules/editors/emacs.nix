{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Emacs dependencies
    aspell
    aspellDicts.en
    aspellDicts.en-computers

    binutils
    pinentry-emacs
  ];
  programs.doom-emacs = {
    enable = true;
    #doomDir = "/home/srunnels/repos/dotfiles/doom";
  };
  # programs.emacs = {
  #   enable = true;
  #   extraPackages = epkgs: [
  #     epkgs.nix-mode
  #     epkgs.magit
  #   ];
  # };
  
  # home.file = {
  #   ".config/emacs".source = pkgs.fetchFromGitHub {
  #     owner = "doomemacs";
  #     repo = "core";
  #     tag = "v2.2.1";
  #     sha256 = "sha256-T4ycvZiNjHSWVKvQPdgDvKt/eQpjXKR9gjJ5pJD6GVM=";
  #   };
    
  #   doom = {
  #     enable = true;
  #     executable = false;
  #     recursive = true;
  #     source = dotfiles/doom;
  #     target = "/home/srunnels/.config/doom";
  #   };
  # };

  # home.activation.doom = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #   if [ -x "/home/srunnels/.config/emacs/bin/doom" ]; then
  #         /home/srunnels/.config/emacs/bin/doom sync
  #   fi
  # '';
  
}
