-module(curly_compiler).
-export([compile/1]).

-spec compile(curly:template()) -> fun((string()) -> string()).
compile(Template) ->
    {ok, Tokens} = curly_scanner:scan(Template),
    ParseTree = curly_parser:parse(Tokens),
    fun(Presenter) ->
        curly_renderer:render(ParseTree, Presenter)
    end.
