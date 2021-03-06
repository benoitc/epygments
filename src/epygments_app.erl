%%% -*- erlang -*-
%%%
%%* This file is part of epygments available under the public domain or
%%% MIT license. See the NOTICE for more information.

-module(epygments_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    epygments_sup:start_link().

stop(_State) ->
    ok.
