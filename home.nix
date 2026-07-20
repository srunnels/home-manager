{ lib, pkgs, ... }:
let
  editor = "emacs";
in {
  imports = [ ./zsh.nix ];
  home = {
    packages = with pkgs; [
      # Editor(s)
      emacs

      # Emacs dependencies
      aspell
      aspellDicts.en
      aspellDicts.en-computers

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
      man-pages
      man-pages-posix
      ripgrep
      unzip
      zip
      tree
      sshfs
      
      # Python
      python3

      # Python Utils
      black
      isort
      mypy

      # Language Servers
      pyright
      nixd
      # TODO complete language servers
      # yaml-language-server
      # bash-language-server
      # dockerfile-language-server
    ];


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
  programs.direnv = { enable = true; };

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    # signging.key = TODO
    # signging.signByDefault = TODO
    # TODO - pass helper
    settings = {
      user.email = "srunnels@gmail.com";
      user.name = "Scott Runnels";
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
    enableDefaultConfig = false;

    # *.forwardAgent = true;
    # TODO Not sure what to do with AddKeysToAgent
    # extraConfig = ''
    # AddKeysToAgent yes
    # '';
    
    settings = {
      "*" = {
	      compression = true;
	    };
      "Autarch" = {
	      hostname = "192.168.1.25";
	      port = 22;
	      # identifyFile = "~/.ssh/id" # TODO
	    };
    };
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 86400;
    defaultCacheTtlSsh = 86400;
    maxCacheTtl = 86400;
    maxCacheTtlSsh = 86400;
    enableSshSupport = true;
    enableScDaemon = true;
    extraConfig = "allow-loopback-pinentry";
  };
}
