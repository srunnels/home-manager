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
         plugin = tmuxPlugins.tpm; 
        }
        {
         plugin = tmuxPlugins.gruvbox; 
        }
      ];
    extraConfig = ''
      set-option -g prefix C-t
      set-option -s set-clipboard on
      set -g allow-passthrough on

      # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
      run -b '~/.tmux/plugins/tpm/tpm'

    '';
  };
}
