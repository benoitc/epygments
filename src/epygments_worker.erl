-module(epygments_worker).
-behaviour(gen_server).

-export([start_link/1, stop/0, init/1, handle_call/3, handle_cast/2,
         handle_info/2, terminate/2, code_change/3]).


-record(state, {
        port}).


start_link(Args) ->
    gen_server:start_link(?MODULE, Args, []).

stop() ->
    gen_server:cast(?MODULE, stop).

init(_Args) ->
    process_flag(trap_exit, true),
    ScriptPath = filename:join([epygments_util:priv_dir(),
            "highlight.py"]),
    Cmd = "python -u " ++ ScriptPath,
    Port = open_port({spawn, Cmd}, [{packet, 4}, binary, use_stdio]),
    {ok, #state{port=Port}}.

handle_call(all_languages, _From, #state{port=Port}=State) ->
    {ok, Resp} = exec(Port, all_languages),
    {reply, Resp, State};

handle_call({highlight, Code, LexerName, FormatterName, Options},
        _From, #state{port=Port}=State) ->
    {ok, Resp} = exec(Port, {highlight, Code, LexerName, FormatterName,
            Options}),
    {reply, Resp, State};

handle_call(_Msg, _From, State) ->
    {reply, ok, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(stop, State) ->
    {stop, shutdown, State};
handle_info({'EXIT', _, _}, State) ->
    {stop, shutdown, State};
handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, #state{port=Port}) ->
    port_close(Port),
    receive
        {Port, closed} -> ok %% port closed successfully
    after
        1000 -> throw({error, timeout}) %% port hung
    end,
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


exec(Port, Cmd) ->
    Data = term_to_binary(Cmd, [compressed]),
    true = port_command(Port, Data),

    receive
        {Port, {data, RespData}} ->
            {ok, binary_to_term(RespData)}
    after 5000 ->
        {error, timeout}
    end.

