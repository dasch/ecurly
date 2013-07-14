-module(curly).
-export([compile/1, render/2, render_with_module/2]).

render(Template, Presenter) ->
    CompiledTemplate = compile(Template),
    CompiledTemplate(Presenter).

render_with_module(Template, Module) ->
    Presenter = fun(Reference) ->
        Function = list_to_atom(Reference),
        erlang:apply(Module, Function, [])
    end,
    render(Template, Presenter).

compile(Template) -> curly_compiler:compile(Template).
