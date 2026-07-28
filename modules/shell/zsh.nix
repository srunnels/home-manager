{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = "${config.xdg.configHome}/zsh";
    autosuggestion.enable = true;
    enableCompletion = true;
    shellAliases = {
      ll = "ls -lha";
      ls = "ls --color=auto";
      unlock_personal = "gpg-connect-agent 'scd checkpin '$YUBIKEY_PERSONAL_CARD'' /bye";
        # sl = "exa";
        # ls = "exa";
        # l = "exa -l";
        # la = "exa -la";
        # ip = "ip --color=auto";
    };

    # initExtra = ''
    #   bindkey '^ ' autosuggest-accept
    #   AGKOZAK_CMD_EXEC_TIME=5
    #   AGKOZAK_COLORS_CMD_EXEC_TIME='yellow'
    #   AGKOZAK_COLORS_PROMPT_CHAR='magenta'
    #   AGKOZAK_CUSTOM_SYMBOLS=( '⇣⇡' '⇣' '⇡' '+' 'x' '!' '>' '?' )
    #   AGKOZAK_MULTILINE=0
    #   AGKOZAK_PROMPT_CHAR=( ❯ ❯ ❮ )
    #   eval $(thefuck --alias)
    #   autopair-init
    #                           '';

    plugins = with pkgs; [
      # {
      #   name = "agkozak-zsh-prompt";
      #   src = fetchFromGitHub {
      #     owner = "agkozak";
      #     repo = "agkozak-zsh-prompt";
      #     rev = "v3.7.0";
      #     sha256 = "1iz4l8777i52gfynzpf6yybrmics8g4i3f1xs3rqsr40bb89igrs";
      #   };
      #   file = "agkozak-zsh-prompt.plugin.zsh";
      # }
      # {
      #   name = "formarks";
      #   src = fetchFromGitHub {
      #     owner = "wfxr";
      #     repo = "formarks";
      #     rev = "8abce138218a8e6acd3c8ad2dd52550198625944";
      #     sha256 = "1wr4ypv2b6a2w9qsia29mb36xf98zjzhp3bq4ix6r3cmra3xij90";
      #   };
      #   file = "formarks.plugin.zsh";
      # }
      {
        name = "zsh-syntax-highlighting";
        src = fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.6.0";
          sha256 = "0zmq66dzasmr5pwribyh4kbkk23jxbpdw4rjxx0i7dx8jjp2lzl4";
        };
        file = "zsh-syntax-highlighting.zsh";
      }
      # {
      #   name = "zsh-abbrev-alias";
      #   src = fetchFromGitHub {
      #     owner = "momo-lab";
      #     repo = "zsh-abbrev-alias";
      #     rev = "637f0b2dda6d392bf710190ee472a48a20766c07";
      #     sha256 = "16saanmwpp634yc8jfdxig0ivm1gvcgpif937gbdxf0csc6vh47k";
      #   };
      #   file = "abbrev-alias.plugin.zsh";
      # }
      {
        name = "zsh-autopair";
        src = fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "34a8bca0c18fcf3ab1561caef9790abffc1d3d49";
          sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
        };
        file = "autopair.zsh";
      }
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

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
  
  # Scripts
  # home.file.".config/zsh/scripts".source = ./files/scripts;
  # home.file.".config/zsh/scripts".recursive = true;
}
