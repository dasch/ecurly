-module(curly_renderer_tests).
-include_lib("eunit/include/eunit.hrl").

rendering_test() ->
    Template = "The clown {{clown}}",
    Presenter = fun(Reference) ->
        erlang:apply(circus, list_to_atom(Reference), [])
    end,
    {ok, Output} = curly_renderer:render(Template, Presenter),
    ?assertEqual("The clown bozo", Output).
