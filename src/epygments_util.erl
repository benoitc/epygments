%%% -*- erlang -*-
%%%
%%* This file is part of epygments available under the public domain or
%%% MIT license. See the NOTICE for more information.

-module(epygments_util).

-export([priv_dir/0]).

priv_dir() ->
    case code:priv_dir(epygments) of
        {error, _} ->
            %% try to get relative priv dir. useful for tests.
            EbinDir = filename:dirname(code:which(?MODULE)),
            AppPath = filename:dirname(EbinDir),
            filename:join(AppPath, "priv");
        Dir -> Dir
    end.
