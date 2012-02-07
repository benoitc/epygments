-module(epygments).

-export([all_languages/0]).

all_languages() ->
    Worker = poolboy:checkout(hpool),
    Reply = gen_server:call(Worker, all_languages),
    poolboy:checkin(hpool, Worker),
    Reply.
