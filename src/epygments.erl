-module(epygments).

-export([all_languages/0,
         highlight/2, highlight/3, highlight/4]).

all_languages() ->
    Worker = poolboy:checkout(hpool),
    Reply = gen_server:call(Worker, all_languages),
    poolboy:checkin(hpool, Worker),
    Reply.

highlight(Code, LexerName) ->
    highlight(Code, LexerName, <<"SimpleFormatter">>, []).

highlight(Code, LexerName, FormatterName) ->
    highlight(Code, LexerName, FormatterName, []).

highlight(Code, LexerName, FormatterName, Options) ->
    Worker = poolboy:checkout(hpool),
    Reply = gen_server:call(Worker, {highlight, Code, LexerName,
            FormatterName, Options}),
    poolboy:checkin(hpool, Worker),
    Reply.
