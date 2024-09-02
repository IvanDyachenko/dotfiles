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
  home.stateVersion = "24.05";

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

    # Google's data interchange format.
    protobuf

    # Docker is a utility to pack, ship and run any application as a lightweight container.
    docker

    # Programs to keep Docker login credentials safe by storing in platform keystores.
    docker-credential-helpers

    # Container runtimes on macOS with minimal setup.
    colima

    # Bazel is a build system for software development that attempts to create a hermetic build by bootstrapping the toolchain from known sources and binaries.
    # bazel

    # A user-friendly launcher for Bazel.
    bazelisk

    # Buildifier is a tool for formatting bazel BUILD and .bzl files with a standard convention.
    buildifier

    # Buildozer is a command line tool to rewrite multiple Bazel BUILD files using standard commands.
    buildozer

    # Pure Scala Artifact Fetching.
    coursier

    # Scala language server with rich IDE features.
    metals

    # Scala CLI is an experimental tool to run/compile/test Scala that aims at being a better scala command.
    scala-cli

    # Python
    python3

    # Event-driven I/O framework for the V8 JavaScript engine.
    # nodejs_18

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

    signing.key = "5EECD1816D082829";
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
    package = pkgs.neovim-nightly;
  };
}
