-module(curly_scanner_tests).
-include_lib("eunit/include/eunit.hrl").

reference_test() ->
    Template = "foo {{bar}} baz",
    ExpectedTokens = [
        {text, "foo "},
        reference_start,
        {text, "bar"},
        curly_end,
        {text, " baz"}
    ],
    {ok, Tokens} = curly_scanner:scan(Template),
    ?assertEqual(ExpectedTokens, Tokens).

comment_test() ->
    Template = "{{! foo }}",
    ExpectedTokens = [
        comment_start,
        {text, " foo "},
        curly_end
    ],
    {ok, Tokens} = curly_scanner:scan(Template),
    ?assertEqual(ExpectedTokens, Tokens).
