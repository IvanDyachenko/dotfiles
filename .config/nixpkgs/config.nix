{
  allowUnfree = true;

  environment = pkgs: with pkgs; {
    systemPackages = [
      direnv # augments existing shells with a new feature that can load and unload environment variables depending on the current directory.
      emacs
    ];
  };
}
