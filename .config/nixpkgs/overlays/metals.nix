self: super:
{
  metals-emacs =
    let
      baseName = "metals-emacs";
      version = "0.10.1";
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
#       outputHashMode = "recursive";
#       outputHashAlgo = "sha256";
#       outputHash     = "???";
      };
    in
      with super; stdenv.mkDerivation rec {
        name = "${baseName}-${version}";
#       meta = with stdenv.lib; {
#         homepage = https://scalameta.org/metals/;
#         description = "Scala language server with rich IDE features";
#         license = licenses.asl20;
#       };
        doCheck = true;
        buildInputs = [ jre jdk makeWrapper deps ];
        phases = [ "installPhase" ];
        installPhase = ''
        mkdir -p $out/bin
        makeWrapper ${jre}/bin/java $out/bin/${baseName} \
          --prefix PATH : ${lib.makeBinPath [ jdk ]} \
          --add-flags "-cp $CLASSPATH" \
          --add-flags "-Xss4m -Xms100m -Dmetals.client=emacs" \
          --add-flags "scala.meta.metals.Main"
        '';
      };
}
