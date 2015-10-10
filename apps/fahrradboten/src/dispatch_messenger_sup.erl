-module(dispatch_messenger_sup).

-behaviour(supervisor).

%% API
-export([start_link/0, start_worker/1]).

%% Supervisor callbacks
-export([init/1]).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

start_worker(Messenger) ->
    supervisor:start_child(?MODULE, [Messenger]).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

init([]) ->
    Node = {dispatch_messenger,
            {dispatch_messenger, start, []},
            permanent,
            5000,
            worker,
            dynamic},

    {ok, {{simple_one_for_one, 10, 1}, [Node]}}.

%%====================================================================
%% Internal functions
%%====================================================================

