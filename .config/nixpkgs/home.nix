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
  home.stateVersion = "21.05";

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  # home.username = "ivandyachenko";
  # home.homeDirectory = "/Users/ivandyachenko";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    direnv # Load and unload environment variables depending on the current directory.
    nixfmt # A formatter for Nix code.
    treefmt # One CLI to format the code tree.
    metals # Scala language server with rich IDE features.
    scala-cli # Scala CLI is an experimental tool to run/compile/test Scala that aims at being a better scala command.
    plantuml # PlantUML is an open-source tool allowing users to create diagrams from a plain text language.
    plantuml-server # PlantUML Server.
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacsGcc;
  };
}
