-module(curly).
-export([render/2]).

render(Template, Presenter) ->
    {ok, Tokens} = curly_scanner:scan(Template),
    ParseTree = curly_parser:parse(Tokens),
    curly_renderer:render(ParseTree, Presenter).
