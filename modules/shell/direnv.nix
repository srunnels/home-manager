{ config, lib, pkgs, ... }:

{
  # https://mynixos.com/home-manager/options/programs.direnv
  # https://nixos.asia/en/hm-tutorial
  programs.direnv = {
    enable = true;
    enableZshIntegration = true; 
  };
  
}
