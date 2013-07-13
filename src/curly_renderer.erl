-module(curly_renderer).
-export([render/2]).

render(ParseTree, Presenter) ->
    RenderedTokens = render_tokens(ParseTree, Presenter),
    {ok, string:join(RenderedTokens, "")}.

render_tokens(ParseTree, Presenter) -> 
    case ParseTree of
        [] -> [];
        [{reference, Reference} | Rest] ->
            [Presenter(Reference) | render_tokens(Rest, Presenter)];
        [{comment, _} | Rest] ->
            render_tokens(Rest, Presenter);
        [{text, Text} | Rest] ->
            [Text | render_tokens(Rest, Presenter)]
    end.
