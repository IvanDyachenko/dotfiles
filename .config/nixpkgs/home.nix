{ config, pkgs, lib, ... }:

{
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  # home.username = "ivandyachenko";
  # home.homeDirectory = "/Users/ivandyachenko";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # A simple, fast and user-friendly alternative to 'find'.
    fd

    # jq is a lightweight and flexible command-line JSON processor.
    jq

    # A computer program that retrieves content from web servers.
    wget

    # Command-line tool for interacting with gRPC servers.
    grpcurl

    # List contents of directories in a tree-like format.
    tree

    # One CLI to format the code tree.
    treefmt

    # A formatter for Nix code.
    nixfmt

    # Load and unload environment variables depending on the current directory.
    direnv

    # Universal typing tutor.
    # gtypist

    # Docker.
    # docker
    # docker-compose
    # docker-credential-helpers

    # A bazel BUILD file formatter and editor.
    # bazel_5
    # buildifier

    # Pure Scala Artifact Fetching.
    coursier

    # Scala language server with rich IDE features.
    metals

    # Scala CLI is an experimental tool to run/compile/test Scala that aims at being a better scala command.
    scala-cli

    # Python
    python3

    # Generic command line non-JVM Apache Kafka producer and consumer.
    # kcat

    # Redis
    # redis
  ];

  programs.gpg = { enable = true; };

  programs.git = {
    enable = true;

    userName = "Ivan Dyachenko";
    userEmail = "inbox@ivandyachenko.ru";

    signing.key = "136CB6BB34E44255";
    signing.signByDefault = true;

    extraConfig = {
      credential.helper = if pkgs.stdenvNoCC.isDarwin then
        "osxkeychain"
      else
        "cache --timeout=1000000000";
      core = {
        editor = "nano";
        ignorecase = false;
      };
      fetch = { prune = true; };
    };

    aliases = {
      lograph = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
    };
    ignores = [ ".DS_Store" ];
  };

  programs.emacs = {
    enable = false;
    package = pkgs.emacs-unstable;
  };

  programs.neovim = {
    enable = true;
    # package = pkgs.neovim-nightly;
  };
}
