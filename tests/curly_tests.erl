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

comment_rendering_test() ->
    Template = "Hello {{! NONONO }}there!",
    Presenter = fun(_) -> "boom" end,
    {ok, Output} = curly:render(Template, Presenter),
    ?assertEqual("Hello there!", Output).

rendering_with_module_test() ->
    Template = "Hello {{foo}}!",
    {ok, Output} = curly:render_with_module(Template, fixture),
    ?assertEqual("Hello World!", Output).

rendering_with_dict_test() ->
    Template = "Hello {{foo}}!",
    Dict = dict:from_list([{foo, "World"}]),
    {ok, Output} = curly:render_with_dict(Template, Dict),
    ?assertEqual("Hello World!", Output).

