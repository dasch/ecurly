-module(curly_parser_tests).
-include_lib("eunit/include/eunit.hrl").

reference_test() ->
    Tokens = [reference_start, {text, "foo"}, curly_end],
    Expected = [{reference, "foo"}],
    ?assertEqual(Expected, curly_parser:parse(Tokens)).

comment_test() ->
    Tokens = [comment_start, {text, "foo"}, curly_end],
    Expected = [{comment, "foo"}],
    ?assertEqual(Expected, curly_parser:parse(Tokens)).
