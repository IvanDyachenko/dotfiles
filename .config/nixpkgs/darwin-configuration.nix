{ config, pkgs, home-manager, ... }:

{
  imports = [ home-manager.darwinModules.home-manager ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Install the flakes edition.
  nix.package = pkgs.nixVersions.stable;

  # Enable the nix 2.0 CLI and flakes support feature-flags.
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nix.settings.trusted-users = [ "root" "@admin" "@wheel" "ivandyach" ];

  # You won't be able to install or search for an unfree package as a user,
  # unless you explicitly enable it:
  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    # fire
    # fira-code
    # fira-code-symbols
    noto-fonts
    noto-fonts-emoji
    noto-fonts-extra
    nerd-fonts.noto
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.jetbrains-mono
  ];

  nixpkgs.overlays = [ ];

  users.users.ivandyach = {
    name = "ivandyach";
    home = "/Users/ivandyach";
  };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ ];

  environment.variables.SHELL = "${pkgs.fish}/bin/fish";
  environment.variables.EDITOR = "nvim";

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.fish.enable = true;

  # By default, Home Manager uses a private pkgs instance that is configured via
  # the home-manager.users.<name>.nixpkgs options. To instead use the global pkgs
  # that is configured via the system level nixpkgs options, set:
  home-manager.useGlobalPkgs = true;

  # By default packages will be installed to $HOME/.nix-profile but they can be
  # installed to /etc/profiles by setting:
  home-manager.useUserPackages = true;

  home-manager.users.ivandyach = import ./home.nix;

  homebrew = {
    enable = true;
    taps = [ ];
    casks = [ ];
  };
}
