{
  allowUnfree = true;

  environment = pkgs: with pkgs; {
    systemPackages = [
      # Augments existing shells with a new feature that can load and unload
      # environment variables depending on the current directory.
      direnv

      # Emacs that is built from the latest tag.
      # https://github.com/nix-community/emacs-overlay
      emacsUnstable
    ];
  };
}
