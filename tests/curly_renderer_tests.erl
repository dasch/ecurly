-module(curly_renderer_tests).
-include_lib("eunit/include/eunit.hrl").

rendering_test() ->
    Tokens = [{text, "foo "}, {reference, "bar"}],
    Presenter = fun(Reference) -> string:to_upper(Reference) end,
    {ok, Output} = curly_renderer:render(Tokens, Presenter),
    ?assertEqual("foo BAR", Output).

comment_test() ->
    Tokens = [{text, "foo "}, {comment, "boom"}, {text, "bar"}],
    Presenter = fun(Reference) -> string:to_upper(Reference) end,
    {ok, Output} = curly_renderer:render(Tokens, Presenter),
    ?assertEqual("foo bar", Output).
