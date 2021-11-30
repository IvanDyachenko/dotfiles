# Scala CLI is an experimental tool to run/compile/test Scala that aims at being a better scala command.
self: super: {
  scala-cli = let
    baseName = "scala-cli";
    version = "0.0.8";
  in with super;
  stdenv.mkDerivation rec {
    name = baseName;
    src = builtins.fetchurl {
      url =
        "https://github.com/Virtuslab/scala-cli/releases/download/v${version}/${baseName}-x86_64-apple-darwin.gz";
      sha256 = "14bf1zwvfq86vh00qlf8jf4sb82p9jakrmwqhnv9p0x13lq56xm5";
    };

    nativeBuildInputs = [ zlib stdenv.cc.cc ];

    phases = [ "unpackPhase" "installPhase" ];

    unpackPhase = ''
      cat $src | gzip -d > scala-cli
    '';

    installPhase = ''
      mkdir -p $out/bin

      chmod 755 scala-cli
      cp scala-cli $out/bin/
    '';
  };
}
