-module(curly_renderer).
-export([render/2]).

render(Template, Presenter) ->
    {ok, Tokens} = curly_scanner:scan(Template),
    RenderedTokens = render_tokens(Tokens, Presenter),
    {ok, string:join(RenderedTokens, "")}.

render_tokens(Tokens, Presenter) -> 
    case Tokens of
        [] -> [];
        [reference_start, {text, Reference}, curly_end | Rest] ->
            [Presenter(Reference) | render_tokens(Rest, Presenter)];
        [comment_start, {text, _}, curly_end | Rest] ->
            render_tokens(Rest, Presenter);
        [{text, Text} | Rest] -> [Text | render_tokens(Rest, Presenter)]
    end.
