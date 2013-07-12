-module(curly).
-export([render/2]).

render(Template, PresenterModule) ->
    curly_renderer:render(Template, PresenterModule).
