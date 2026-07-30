{ config, pkgs, ... }:
let
  editor = "emacs";
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "srunnels";
  home.homeDirectory = "/home/srunnels";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    btop
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pass
    pass-git-helper
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/srunnels/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "${editor}";
    PATH = "$HOME/.local/bin:$PATH";
    YUBIKEY_PERSONAL_CARD = "D2760001240100000006332790270000";
    GPG_ENCRYPT_PERSONAL = "0xA2A8C9FF810DF9DC";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # GnuPG
  # https://mynixos.com/home-manager/options/programs.gpg
  programs.gpg = {
    enable = true;
  };

  # The gpg agent
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 60; #86400;
    defaultCacheTtlSsh = 60; #86400;
    maxCacheTtl = 120; #86400;
    maxCacheTtlSsh = 120; #86400;
    enableSshSupport = true;
    enableScDaemon = true;
    pinentry.package = pkgs.pinentry-gnome3;
    extraConfig = ''
      allow-loopback-pinentry
      ttyname $GPG_TTY
    '';
  };
  
  # SSH
  # https://mynixos.com/home-manager/options/programs.ssh
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "*" = {
        compression = true;
      };
      Autarch = {
        hostname = "192.168.1.25";
        port = 22;
        identityFile = "~/.ssh/id_rsa_yubikey_personal.pub";
      };
    };
    
  };
  
  # Git
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    signing.key = "0x69DD8D95BD8837D7";
    signing.signByDefault = true;
    # TODO - pass helper
    settings = {
      user.email = "srunnels@gmail.com";
      user.name = "Scott Runnels";
      merge = { ff = "only"; };
	    rerere = { enabled = "true"; };
	    rebase = { autoSquash = "true"; };
	    github = { user = "srunnels"; };
      credential.helper = "${pkgs.pass-git-helper}/bin/pass-git-helper";
    };

    ignores = [
      "*~"
    ];
    # userName = "Scott Runnels";
    # userEmail = "srunnels@gmail.com";
  };
  
  imports = [ modules/fonts/fonts.nix
              modules/shell/zsh.nix
              modules/shell/fzf.nix
              #modules/shell/eza.nix
              modules/editors/emacs.nix
              modules/shell/tmux.nix
              modules/shell/direnv.nix
            ];
}
