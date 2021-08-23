self: super:
{
  metals =
    let
      baseName = "metals";
      version  = "0.10.5";

      deps = with super; stdenv.mkDerivation {
        name = "${baseName}-deps-${version}";
        buildCommand = ''
          export COURSIER_CACHE=$(pwd)
          ${coursier}/bin/coursier fetch org.scalameta:metals_2.12:${version} \
            -r sonatype:snapshots \
            -r "bintray:scalacenter/releases" \
            > deps
          mkdir -p $out/share/java
          cp -n $(< deps) $out/share/java/
        '';
       outputHashMode = "recursive";
       outputHashAlgo = "sha256";
       outputHash     = "0n0y522izqlyls3sn2x6mdjy0pmhrl1kr7z5fqac6wrpgcsczf01";
      };
    in
      with super; stdenv.mkDerivation rec {
        name = "${baseName}-${version}";

        doCheck    = true;
        dontUnpack = true;

        buildInputs       = [ jre jdk deps ];
        nativeBuildInputs = [ makeWrapper ];

        phases = [ "installPhase" ];

        installPhase = ''
          mkdir -p $out/bin

          # This variant is not targeted at any particular client, clients are
          # expected to declare their supported features in initialization options.
          makeWrapper ${jre}/bin/java $out/bin/metals \
            --prefix PATH : ${lib.makeBinPath [ jdk ]} \
            --add-flags "-XX:+UseG1GC -XX:+UseStringDeduplication -Xss4m -Xms100m" \
            --add-flags "-cp $CLASSPATH" \
            --add-flags "scala.meta.metals.Main"

          makeWrapper ${jre}/bin/java $out/bin/metals-emacs \
            --prefix PATH : ${lib.makeBinPath [ jdk ]} \
            --add-flags "-XX:+UseG1GC -XX:+UseStringDeduplication -Xss4m -Xms100m -Dmetals.client=emacs" \
            --add-flags "-cp $CLASSPATH" \
            --add-flags "scala.meta.metals.Main"
        '';
      };
}
