-module(curly_scanner).
-export([scan/1]).

% Scans a Curly template.
scan(Template) -> scan(Template, []).

scan("",       Tokens) -> {ok, lists:reverse(Tokens)};
scan(Template, Tokens) ->
    {Rest, Token} = scan_token(Template),
    scan(Rest, [Token | Tokens]).

scan_token("{{!" ++ Rest) -> {Rest, comment_start};
scan_token("{{"  ++ Rest) -> {Rest, reference_start};
scan_token("}}"  ++ Rest) -> {Rest, curly_end};
scan_token(Text) ->
            {Rest, Letters} = scan_text(Text),
            {Rest, {text, lists:reverse(Letters)}}.

scan_text(Text) -> scan_text(Text, []).

scan_text(Text, Letters) ->
    case Text of
        ""           -> {"",           Letters};
        "{{" ++ Rest -> {"{{" ++ Rest, Letters};
        "}}" ++ Rest -> {"}}" ++ Rest, Letters};
        [T | Rest]   -> scan_text(Rest, [T | Letters])
    end.

