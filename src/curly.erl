-module(curly).
-export([compile/1, render/2]).

render(Template, Presenter) ->
    CompiledTemplate = compile(Template),
    CompiledTemplate(Presenter).

compile(Template) ->
    {ok, Tokens} = curly_scanner:scan(Template),
    ParseTree = curly_parser:parse(Tokens),
    fun(Presenter) ->
        curly_renderer:render(ParseTree, Presenter)
    end.
