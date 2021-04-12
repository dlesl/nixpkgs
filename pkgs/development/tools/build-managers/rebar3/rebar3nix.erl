-module(rebar3nix).

-export([init/1, do/1, format_error/1]).

-define(PROVIDER, nix).
-define(DEPS, [lock]).

-spec init(rebar_state:t()) -> {ok, rebar_state:t()}.
init(State) ->
  Provider = providers:create([
                               {name, ?PROVIDER},
                               {module, ?MODULE},
                               {bare, true},
                               {deps, ?DEPS},
                               {example, "rebar3 nix -o rebar.nix"},
                               {opts, [{out, $o, "out", {string, "rebar.nix"}, "Output file."}]},
                               {short_desc, "Export rebar3 dependencies for nix"},
                               {desc, "Export rebar3 dependencies for nix"}
                              ]),
  {ok, rebar_state:add_provider(State, Provider)}.


-spec do(rebar_state:t()) -> {ok, rebar_state:t()} | {error, string()}.
do(State) ->
  Lock = rebar_state:lock(State),
  Deps = [to_nix(rebar_app_info:name(AppInfo), rebar_app_info:source(AppInfo))
          || AppInfo <- Lock],
  Drv = ["{ fetchHex, fetchGit, fetchFromGitHub }:\n{\n", Deps, "}\n"],
  ok = file:write_file(out_path(State), Drv),
  {ok, State}.

out_path(State) ->
  {Args, _} = rebar_state:command_parsed_args(State),
  proplists:get_value(out, Args).

-spec format_error(any()) ->  iolist().
format_error(Reason) ->
  io_lib:format("~p", [Reason]).

to_nix(Name, {pkg, PkgName, Vsn, _OldHash, Hash, _Repo}) ->
  io_lib:format("  ~s = fetchHex {
    pkg = \"~s\";
    version = \"~s\";
    sha256 = \"~s\";
  };~n", [Name, PkgName, Vsn, Hash]);
to_nix(Name, {git, Url, {ref, Ref}}) ->
  case string:prefix(string:lowercase(Url), "https://github.com/") of
    nomatch ->
      io_lib:format("  ~s = fetchGit {
    url = \"~s\";
    rev = \"~s\";
  };~n", [Name, Url, Ref]);
        Path ->
      [Owner, Repo0] = string:split(Path, "/", trailing),
      Repo = re:replace(Repo0, "\\.git$", "", [{return, list}]),
      Prefetch = ["nix-prefetch-url --unpack https://github.com/",
                  Owner, "/", Repo, "/tarball/", Ref, " 2>/dev/null"],
      Hash = case string:trim(os:cmd(Prefetch)) of
               [] ->
                 rebar_api:abort(
                   "prefetch failed, make sure nix-prefetch-url is on your PATH",
                   []);
               Hash0 ->
                 Hash0
             end,
      io_lib:format("  ~s = fetchFromGitHub {
    owner = \"~s\";
    repo = \"~s\";
    rev = \"~s\";
    sha256 = \"~s\";
  };~n", [Name, Owner, Repo, Ref, Hash])
    end;
to_nix(Name, Other) ->
  rebar_api:warn("unsupported dependency type ~p for ~s~n", [Other, Name]),
  undefined.
