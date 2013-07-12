-module(curly_renderer_tests).
-include_lib("eunit/include/eunit.hrl").

rendering_test() ->
    Template = "The clown {{clown}}",
    Presenter = fun(Reference) ->
        case Reference of
            "clown" -> "bozo"
        end
    end,
    {ok, Output} = curly_renderer:render(Template, Presenter),
    ?assertEqual("The clown bozo", Output).
