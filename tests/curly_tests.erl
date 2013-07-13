-module(curly_tests).
-include_lib("eunit/include/eunit.hrl").

rendering_test() ->
    Template = "The clown {{clown}}",
    Presenter = fun(Reference) ->
        case Reference of
            "clown" -> "bozo"
        end
    end,
    {ok, Output} = curly:render(Template, Presenter),
    ?assertEqual("The clown bozo", Output).

comment_test() ->
    Template = "Hello {{! NONONO }}there!",
    Presenter = fun(_) -> "boom" end,
    {ok, Output} = curly:render(Template, Presenter),
    ?assertEqual("Hello there!", Output).