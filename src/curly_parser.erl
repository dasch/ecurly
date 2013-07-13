-module(curly_parser).
-export([parse/1]).

parse([reference_start, {text, Reference}, curly_end | Rest]) ->
    [{reference, Reference} | parse(Rest)];
parse([comment_start, {text, Comment}, curly_end | Rest]) ->
    [{comment, Comment} | parse(Rest)];
parse([{text, Text} | Rest]) ->
    [{text, Text} | parse(Rest)];
parse([]) ->
    [].
