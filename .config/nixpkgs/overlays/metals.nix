# Scala language server with rich IDE features.
self: super: {
  metals = let
    baseName = "metals";
    version = "0.11.9";

    deps = with super;
      stdenv.mkDerivation {
        name = "${baseName}-deps-${version}";
        buildCommand = ''
          export COURSIER_CACHE=$(pwd)
          ${coursier}/bin/cs fetch org.scalameta:metals_2.13:${version} \
            -r sonatype:snapshots \
            -r bintray:scalameta/maven \
            -r bintray:scalacenter/releases \
            > deps
          mkdir -p $out/share/java
          cp -n $(< deps) $out/share/java/
        '';
        outputHashMode = "recursive";
        outputHashAlgo = "sha256";
        outputHash = "sha256-CJ34OZOAM0Le9U0KSe0nKINnxA3iUgqUMtS06YnjvVo=";
      };
  in with super;
  stdenv.mkDerivation rec {
    name = "${baseName}-${version}";

    doCheck = true;
    dontUnpack = true;

    buildInputs = [ jre jdk deps ];
    nativeBuildInputs = [ makeWrapper ];

    phases = [ "installPhase" ];

    installPhase = ''
      mkdir -p $out/bin

      # This variant is not targeted at any particular client, clients are
      # expected to declare their supported features in initialization options.
      makeWrapper ${jre}/bin/java $out/bin/metals \
        --prefix PATH : ${lib.makeBinPath [ jdk ]} \
        --add-flags "-XX:+UseG1GC -XX:+UseStringDeduplication -Xss4m -Xms1024m -Xmx4096m" \
        --add-flags "-cp $CLASSPATH" \
        --add-flags "scala.meta.metals.Main"

      makeWrapper ${jre}/bin/java $out/bin/metals-emacs \
        --prefix PATH : ${lib.makeBinPath [ jdk ]} \
        --add-flags "-XX:+UseG1GC -XX:+UseStringDeduplication -Xss4m -Xms1024m -Xmx4096m -Dmetals.client=emacs" \
        --add-flags "-cp $CLASSPATH" \
        --add-flags "scala.meta.metals.Main"
    '';
  };
}
