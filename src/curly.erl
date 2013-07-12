-module(curly).
-export([render/2]).

render(Template, PresenterModule) ->
    {ok, Tokens} = curly_scanner:scan(Template),
    RenderedTokens = render_tokens(Tokens, PresenterModule),
    {ok, string:join(RenderedTokens, "")}.

render_tokens(Tokens, PresenterModule) -> 
    case Tokens of
        [] -> [];
        [reference_start, {text, Reference}, curly_end | Rest] ->
            Value = erlang:apply(PresenterModule, list_to_atom(Reference), []),
            [Value | render_tokens(Rest, PresenterModule)];
        [comment_start, {text, _}, curly_end | Rest] ->
            render_tokens(Rest, PresenterModule);
        [{text, Text} | Rest] -> [Text | render_tokens(Rest, PresenterModule)]
    end.
