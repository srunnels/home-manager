{ lib, pkgs, ... }:
let
  editor = "emacs";
in {
  imports = [./zsh.nix]
  home = {
    packages = with pkgs; [
      # Editor(s)
      emacs

      # Emacs dependencies
      aspell
      aspellDicts.en
      aspellDicts.en-computers
      aspellDicts.fr

      # TODO Fonts
      # TODO Latex

      # Core
      gnumake

      # Authentication
      gnupg
      pass

      # CLI
      fd
      fzf
      file
      manpages
      ripgrep
      unzip
      zip
      tree
      sshfs
      
      # Python
      python3
      python3Packages.black

      python3Packages.pyls-black
      python3Packages.pyls.isort
      python3Packages.pyls-mypy
      python3Packages.pytest
      python3Packages.python-language-server
    ];

    programs.direnv = { enable = true; };

    programs.git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userEmail = "srunnels@gmail.com";
      userName = "Scott Runnels";
      # signging.key = TODO
      # signging.signByDefault = TODO
      # TODO - pass helper
      extraConfig = {
        merge = { ff = "only"; };
	rerere = { enabled = "true"; };
	rebase = { autoSquash = "true"; };
	github = { user = "srunnels"; };
      };

      ignores = [
        "*~"
      ];
    };
    # https://mynixos.com/home-manager/options/programs.gpg
    programs.gpg.enable = true;
    # https://mynixos.com/home-manager/options/programs.ssh
    programs.ssh = {
      enable = true;
      compression = true;
      forwardAgent = true;

      matchBlocks = {
        "Autarch" = {
	  hostname = "192.168.1.25";
	  port = 22;
	};
      };
      extraConfig = "AddKeysToAgent yes";
    };

    services.gpg-agent = {
      enable = true;
      defaultCacheTtl = 86400;
      defaultCacheTtlSsh = 86400;
      maxCacheTtl = 86400;
      maxCacheTtlSsh = 86400;
      enablesshSupport = true;
      extraConfig = allow-loopback-pinentry;
    };

    # TODO - Expand upon this.
    #home.file.".gnupg/config".source = ./files/gnupg/config;
    # Probably more accurate
    #file.".gnupg/config".source = ./files/gnupg/config;

    username = "srunnels";
    homeDirectory = "/home/srunnels";
    sessionVariables = {
      EDITOR = "${editor}";
      PATH = "$HOME/.local/bin:$PATH";
    };
    stateVersion = "26.05";
    };
}