-module(curly_renderer_tests).
-include_lib("eunit/include/eunit.hrl").

rendering_test() ->
    Template = "The clown {{clown}}",
    {ok, Output} = curly:render(Template, circus),
    ?assertEqual("The clown bozo", Output).
