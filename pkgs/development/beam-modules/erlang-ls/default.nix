{ fetchFromGitHub, fetchHex, stdenv, rebar3WithPlugins, erlang, writeScript
, coreutils, git, common-updater-scripts, nix, lib }:
let
  version = "0.14.0";
  owner = "erlang-ls";
  repo = "erlang_ls";
  deps = import ./rebar.nix {
    inherit fetchHex fetchFromGitHub;
    inherit (builtins) fetchGit;
  };
in stdenv.mkDerivation {
  inherit version;
  name = "erlang-ls";
  buildInputs = [ (rebar3WithPlugins { }) erlang ];
  src = fetchFromGitHub {
    inherit owner repo;
    sha256 = "070581avzlywv6qfjp5bjjm4jz7fsjmywvhbwrlf3g6b5jx20vdd";
    rev = version;
  };
  buildPhase = ''
    mkdir _checkouts
    ${toString (lib.mapAttrsToList (k: v: ''
      cp -R ${v} _checkouts/${k}
    '') deps)}
    make
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp _build/default/bin/erlang_ls $out/bin/
    cp _build/dap/bin/els_dap $out/bin/
  '';
  passthru.updateScript = writeScript "update.sh" ''
    #!${stdenv.shell}
    set -ox errexit
    PATH=${
      lib.makeBinPath [
        common-updater-scripts
        coreutils
        git
        nix
        (rebar3WithPlugins { })
      ]
    }
    latest=$(list-git-tags https://github.com/${owner}/${repo}.git  | sort -V | tail -1)
    if [ "$latest" != "${version}" ]; then
      nixpkgs="$(git rev-parse --show-toplevel)"
      nix_path="$nixpkgs/pkgs/development/beam-modules/erlang-ls"
      update-source-version beamPackages.erlang-ls "$latest" --version-key=version --print-changes --file="$nix_path/default.nix"
      tmpdir=$(mktemp -d)
      cp -R $(nix-build $nixpkgs --no-out-link -A beamPackages.erlang-ls.src)/* "$tmpdir"
      (cd "$tmpdir" && rebar3 nix -o "$nix_path/rebar.nix")
    else
      echo "erlang-ls is already up-to-date"
    fi
  '';
}
