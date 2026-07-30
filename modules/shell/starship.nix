{ config, lib, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    # Merged starship configs from dotfiles
    # https://rycee.gitlab.io/home-manager/options.xhtml#opt-programs.starship.settings
    # https://github.com/search?p=1&q=language%3Anix+programs.starship.settings&type=Code
    settings = {
      add_newline = false;
      aws.disabled = true;
      package.disabled = true;
      gcloud.disabled = true;
      azure.disabled = true;
      nodejs.disabled = true;
      character.success_symbol = "[➜](bold green)";
      character.error_symbol = "[❯](bold red)";
      
      cmd_duration = {
        min_time = 500;
	      format = "underwent [$duration](bold yellow)";
      };
      
      directory = {
        truncation_length = 255;
	      truncate_to_repo = false;
	      use_logical_path = false;
      };
      
      nix_shell = {
        format = "via [$symbol$state]($style) ";
        symbol = "❄️";
        impure_msg = "";
        pure_msg = "pure";
      };
      status.disabled = false;
    };
  };
}
