{ config, lib, pkgs, ... }:

{
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    shellAliases = {
      la = "eza -lah --icons --git";
      tree = "eza --tree --git";
    };
  };
}
