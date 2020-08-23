self: super:
{
  Skim =
    let
      baseName = "Skim";
      version = "1.5.11";
    in
      with super; stdenv.mkDerivation rec {
        name = "${baseName}-${version}";
        meta = with stdenv.lib; {
          description = "Skim is a PDF reader and note-taker for OS X";
          homepage = https://skim-app.sourceforge.io;
          platforms = platforms.darwin;
        };
        src = fetchurl {
          name = "${baseName}-${version}.dmg";
          url = "https://sourceforge.net/projects/${baseName}-app/files/${baseName}/${baseName}-${version}/${baseName}-${version}.dmg/download";
          sha256 = "03jafimbhmpnrn52ghbg1802b2yvyq0d5l1if9bxgmaij28vfs43";
        };
        buildInputs = [ undmg unzip ];
        sourceRoot = "${baseName}.app";
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
        mkdir -p "$out/Applications/${baseName}.app"
        cp -pR * "$out/Applications/${baseName}.app"
        '';
      };
}
