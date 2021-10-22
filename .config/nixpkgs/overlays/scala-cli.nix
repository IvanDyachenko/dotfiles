self: super:
{
  scala-cli =
    let
      baseName = "scala-cli";
      version  = "0.0.7";
    in
      with super; stdenv.mkDerivation rec {
        name = baseName;
        src  = builtins.fetchurl {
          url    = "https://github.com/Virtuslab/scala-cli/releases/download/v${version}/${baseName}-x86_64-apple-darwin.gz";
          sha256 = "0v6vlmw1zrzvbpa59y4cfv74mx56lyx109vk9cb942pyiv0ia6gf";
        };

        nativeBuildInputs = [ zlib stdenv.cc.cc ];

        phases = [ "unpackPhase" "installPhase"  ];

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
