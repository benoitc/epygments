
-module(epygments_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    Args = [{name, {local, hpool}}, {worker_module, epygments_worker}],
    PoolSpec = {hpool,
        {poolboy, start_link, [Args]},
        permanent, 5000, worker, [poolboy]},

    {ok, { {one_for_one, 10, 10}, [PoolSpec]} }.

