%%%-------------------------------------------------------------------
%% @doc cachen public API
%% @end
%%%-------------------------------------------------------------------

-module(cachen_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
        {'_', [
            {"/favicon.ico", cowboy_static, {priv_file, cachen, "favicon.ico"}},
            {'_', cachen, []}
        ]}
    ]),
    {ok, _} = cowboy:start_clear(http, [{port, 8080}], #{
        env => #{dispatch => Dispatch}
    }),
    cachen_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
