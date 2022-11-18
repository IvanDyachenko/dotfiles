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
  home.stateVersion = "22.05";

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  # home.username = "ivandyachenko";
  # home.homeDirectory = "/Users/ivandyachenko";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    fd # A simple, fast and user-friendly alternative to 'find'.
    jq # jq is a lightweight and flexible command-line JSON processor.
    tree # List contents of directories in a tree-like format.
    gtypist # Universal typing tutor.
    direnv # Load and unload environment variables depending on the current directory.
    nixfmt # A formatter for Nix code.
    treefmt # One CLI to format the code tree.
    metals # Scala language server with rich IDE features.
    scala-cli # Scala CLI is an experimental tool to run/compile/test Scala that aims at being a better scala command.
    plantuml # PlantUML is an open-source tool allowing users to create diagrams from a plain text language.
    plantuml-server # PlantUML Server.
    docker
    docker-compose
    docker-credential-helpers
    python3
  ];

  programs.gpg = {
    enable = true;
  };

  programs.git = {
    enable = true;

    userName = "Ivan Dyachenko";
    userEmail = "ivandyach@yandex-team.ru";

    signing.key = "4A71BB5FD8EB3EAB";
    signing.signByDefault = true;

    extraConfig = {
      credential.helper =
        if pkgs.stdenvNoCC.isDarwin then
          "osxkeychain"
        else
          "cache --timeout=1000000000";
      core = {
        editor = "nano";
        ignorecase = false;
      };
      fetch = {
        prune = true;
      };
    };

    aliases = {
      lograph = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
    };
    ignores = [ ".DS_Store" ];
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacsGcc;
  };
}
