{ stdenv, rebar3, git, cacert }:

{ name, version, sha256, src
, meta ? {}
}:

with stdenv.lib;

stdenv.mkDerivation ({
  name = "rebar-deps-${name}-${version}";

  nativeBuildInputs = [ git ];

  GIT_SSL_CAINFO = "${cacert}/etc/ssl/certs/ca-bundle.crt";

  phases = [ "downloadPhase" "installPhase" ];

  downloadPhase = ''
    cp ${src} .
    HOME='.' DEBUG=1 ${rebar3}/bin/rebar3 get-deps
  '';

  installPhase = ''
    mkdir -p "$out/_checkouts"
    for i in ./_build/default/lib/* ; do
       echo "$i"
       rm -rf "$i/.git"
       cp -R "$i" "$out/_checkouts"
    done
  '';

  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
  outputHash = sha256;

  impureEnvVars = stdenv.lib.fetchers.proxyImpureEnvVars ++ [ "ssh_auth_sock" ];
  inherit meta;
})
