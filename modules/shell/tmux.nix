{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    prefix = "t";
    plugins = with pkgs;
      [
        {
         plugin = tmuxPlugins.cpu; 
        }
        {
         plugin = tmuxPlugins.sensible; 
        }
        {
         plugin = tmuxPlugins.pass; 
        }
        {
         plugin = tmuxPlugins.gruvbox; 
        }
      ];
    extraConfig = ''
      set-option -g prefix C-t
      set-option -s set-clipboard on
      set -g allow-passthrough on
    '';
  };
}
