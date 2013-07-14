-module(curly).
-export([compile/1, render/2, render_with_module/2, render_with_dict/2]).

render(Template, Presenter) ->
    CompiledTemplate = compile(Template),
    CompiledTemplate(Presenter).

render_with_module(Template, Module) ->
    Presenter = fun(Reference) ->
        Function = list_to_atom(Reference),
        erlang:apply(Module, Function, [])
    end,
    render(Template, Presenter).

render_with_dict(Template, Dict) ->
    Presenter = fun(Reference) ->
        Key = list_to_atom(Reference),
        {ok, Value} = dict:find(Key, Dict),
        Value
    end,
    render(Template, Presenter).

compile(Template) -> curly_compiler:compile(Template).
