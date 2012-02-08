%%% -*- erlang -*-
%%%
%%* This file is part of epygments available under the public domain or
%%% MIT license. See the NOTICE for more information.

-module(epygments).

-export([all_languages/0,
         highlight/2, highlight/3, highlight/4]).

-type languages() :: [{binary(), binary()}].
-type highlight_options() :: [{binary(), term()}].

-spec all_languages() -> languages().
%% @doc return all languages supported
%% It return a list of {LexeName, LongName} pairs.
all_languages() ->
    Worker = poolboy:checkout(hpool),
    Reply = gen_server:call(Worker, all_languages),
    poolboy:checkin(hpool, Worker),
    Reply.


-spec highlight(Code::binary(), LexerName::binary()) -> term().
%% @equiv highlight(Code, LexerName, <<"SimpleFormatter">>, [])
highlight(Code, LexerName) ->
    highlight(Code, LexerName, <<"SimpleFormatter">>, []).

-spec highlight(Code::binary(), LexerName::binary(),
    FormatterName::binary()) -> term().
%% @equiv highlight(Code, LexerName, FormatterName, [])
highlight(Code, LexerName, FormatterName) ->
    highlight(Code, LexerName, FormatterName, []).


-spec highlight(Code::binary(), LexerName::binary(),
    FormatterName::binary(), Options::highlight_options()) -> term().
%% @equiv highlight(Code, LexerName, FormatterName)
%% @doc highlight current code.
%% <p>Code: code to highlight</p>
%% <p>LexerName: name of the lexer to use.</p>
%% <p>FormatterName: Name of the formatter to use. CDefault is
%% SimpleFormatter, but it could be any <a
%% href="http://pygments.org/docs/formatters/">Pygments formatter</a></p>
%% <p>Options: proplists, list of the options to pass to the formatter.
%% See the doc of the formatters for more informations.</p>
highlight(Code, LexerName, FormatterName, Options) ->
    Worker = poolboy:checkout(hpool),
    Reply = gen_server:call(Worker, {highlight, Code, LexerName,
            FormatterName, Options}),
    poolboy:checkin(hpool, Worker),
    Reply.
