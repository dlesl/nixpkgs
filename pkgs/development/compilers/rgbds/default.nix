{stdenv, fetchFromGitHub, bison, flex, pkg-config, libpng}:

# TODO: byacc is the recommended parser generator but due to https://github.com/rednex/rgbds/issues/333
# it does not work for the moment. We should switch back to byacc as soon as the fix is integrated
# in a published version.

stdenv.mkDerivation rec {
  pname = "rgbds";
  version = "0.4.0";
  src = fetchFromGitHub {
    owner = "rednex";
    repo = "rgbds";
    rev = "v${version}";
    sha256 = "15680964nlsa83nqgxk7knxajn98lddz2hg6jnn8ffmnms5wdam7";
  };
  nativeBuildInputs = [ bison flex pkg-config libpng ];
  installFlags = [ "PREFIX=\${out}" ];

  meta = with stdenv.lib; {
    homepage = "https://rednex.github.io/rgbds/";
    description = "A free assembler/linker package for the Game Boy and Game Boy Color";
    license = licenses.mit;
    longDescription =
      ''RGBDS (Rednex Game Boy Development System) is a free assembler/linker package for the Game Boy and Game Boy Color. It consists of:

          - rgbasm (assembler)
          - rgblink (linker)
          - rgbfix (checksum/header fixer)
          - rgbgfx (PNG‐to‐Game Boy graphics converter)

        This is a fork of the original RGBDS which aims to make the programs more like other UNIX tools.
      '';
    maintainers = with maintainers; [ matthewbauer ];
    platforms = platforms.all;
  };
}
