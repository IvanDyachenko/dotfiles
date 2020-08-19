self: super:
{
  direnv = super.direnv.overrideAttrs (_: {
    name = "direnv-2.21.3";
    version = "2.21.3";
    src = self.fetchFromGitHub {
      owner = "direnv";
      repo = "direnv";
      rev = "v2.21.3";
      sha256 = "1adi6ld9g4zgz0f6q0kkzrywclqrmikyp7yh22zm9lfdvd5hs8wp";
    };
  });
}
