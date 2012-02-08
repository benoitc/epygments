# epygments

epygments is a simple wrapper to [Pygments](http://pygments.org/) to
highlight source code from your erlang program.

## Requirements

- Python 2.5x & sup.
- [erlport](http://erlport.org/) - Erlang port protocol for Python
- [Pygments](http://pygments.org/)

## installation

You can install manually the python dependancies or use Pip:

    $ pip install -r requirements.txt

to use compile epygments:

    $ make

to create the doc:

    $ make docs

then open index.html in the doc folder.

## Use it:

For now epygments offers you 2 function that you can use in your
application:

- `epygments:all_languages/0` : get all languages
- `epygments:highlight/2`, `epygments:highlight/3`, `epygments:highlight/4` : prettify the source code. See the reference doc for more informations.

## Test it:


    $ erl -pa ebin -pa deps/poolboy/ebin
    Erlang R15B (erts-5.9) [source] [64-bit] [smp:4:4] [async-threads:0] [hipe] [kernel-poll:false]

    Eshell V5.9  (abort with ^G)
    1> application:start(epygments).
    ok
    2> epygments:all_languages().
    [{<<"text">>,<<"Plain text">>},
     {<<"Cucumber">>,<<"Gherkin">>},
     {<<"abap">>,<<"ABAP">>},
     {<<"ada">>,<<"Ada">>},
     {<<"ahk">>,<<"autohotkey">>},
     {<<"antlr">>,<<"ANTLR">>},
     {<<"antlr-as">>,<<"ANTLR With ActionScript Target">>},
     {<<"antlr-cpp">>,<<"ANTLR With CPP Target">>},
     {<<"antlr-csharp">>,<<"ANTLR With C# Target">>},
     {<<"antlr-java">>,<<"ANTLR With Java Target">>},
     {<<"antlr-objc">>,<<"ANTLR With ObjectiveC Target">>},
     {<<"antlr-perl">>,<<"ANTLR With Perl Target">>},
     {<<"antlr-python">>,<<"ANTLR With Python Target">>},
     {<<"antlr-ruby">>,<<"ANTLR With Ruby Target">>},
     {<<"apacheconf">>,<<"ApacheConf">>},
     {<<"applescript">>,<<"AppleScript">>},
     {<<"as">>,<<"ActionScript">>},
     {<<"as3">>,<<"ActionScript 3">>},
     {<<"aspx-cs">>,<<"aspx-cs">>},
     {<<"aspx-vb">>,<<"aspx-vb">>},
     {<<"asy">>,<<"Asymptote">>},
     {<<"basemake">>,<<"Makefile">>},
     {<<"bash">>,<<"Bash">>},
     {<<"bat">>,<<"Batchfile">>},
     {<<"bbcode">>,<<"BBCode">>},
     {<<"befunge">>,<<"Befu"...>>},
     {<<"blit"...>>,<<...>>},
     {<<...>>,...},
     {...}|...]
    2> epygments:highlight(<<"def test(a):\n     if a == 0:\n    return True">>, <<"python">>).
    "<span class=\"k\">def</span> <span class=\"nf\">test</span><span class=\"p\">(</span><span class=\"n\">a</span><span class=\"p\">):</span>\n     <span class=\"k\">if</span> <span class=\"n\">a</span> <span class=\"o\">==</span> <span class=\"mi\">0</span><span class=\"p\">:</span>\n    <span class=\"k\">return</span> <span class=\"bp\">True</span>\n"



