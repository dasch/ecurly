-module(curly_scanner).
-export([scan/1]).

-type token() :: comment_start
               | reference_start
               | curly_end
               | {text, string()}.

% Scans a Curly template.
-spec scan(curly:template()) -> {ok, [token()]}.
scan(Template) -> scan(Template, []).

-spec scan(curly:template(), [token()]) -> {ok, [token()]}.
scan("",       Tokens) -> {ok, lists:reverse(Tokens)};
scan(Template, Tokens) ->
    {Rest, Token} = scan_token(Template),
    scan(Rest, [Token | Tokens]).

-spec scan_token(string()) -> {string(), token()}.
scan_token("{{!" ++ Rest) -> {Rest, comment_start};
scan_token("{{"  ++ Rest) -> {Rest, reference_start};
scan_token("}}"  ++ Rest) -> {Rest, curly_end};
scan_token(Text)          -> scan_text(Text).

-spec scan_text(string()) -> {string(), string()}.
scan_text(Text) ->
    {Rest, Letters} = scan_text(Text, []),
    {Rest, {text, lists:reverse(Letters)}}.

scan_text(Text, Letters) ->
    case Text of
        ""           -> {"",           Letters};
        "{{" ++ Rest -> {"{{" ++ Rest, Letters};
        "}}" ++ Rest -> {"}}" ++ Rest, Letters};
        [T | Rest]   -> scan_text(Rest, [T | Letters])
    end.

