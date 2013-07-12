-module(curly).
-export([render/2]).

render(Template, Presenter) ->
    curly_renderer:render(Template, Presenter).
