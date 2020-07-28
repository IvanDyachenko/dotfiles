{
  allowUnfree = true;

  programs.fish.enable = true;

  packageOverrides = pkgs: with pkgs; {

    cli = pkgs.buildEnv {
      name = "cli";
      paths = [
        fish
      ];
    };
  };

}
