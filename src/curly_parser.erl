-module(curly_parser).
-export([parse/1]).

-type object() :: {reference, string()}
                | {comment, string()}
                | {text, string()}.

-spec parse([curly_scanner:token()]) -> [object()].
parse([reference_start, {text, Reference}, curly_end | Rest]) ->
    [{reference, Reference} | parse(Rest)];
parse([comment_start, {text, Comment}, curly_end | Rest]) ->
    [{comment, Comment} | parse(Rest)];
parse([{text, Text} | Rest]) ->
    [{text, Text} | parse(Rest)];
parse([]) ->
    [].
