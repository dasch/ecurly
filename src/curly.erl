-module(curly).
-export([compile/1, render/2, render_with_module/2, render_with_dict/2]).
-export_type([template/0]).

-type template()          :: string().
-type presenter()         :: fun((string()) -> string()).
-type compiled_template() :: fun((presenter()) -> string()).

% @doc Renders a template with a presenter function.
-spec render(template(), presenter()) -> string().
render(Template, Presenter) ->
    CompiledTemplate = compile(Template),
    CompiledTemplate(Presenter).

% @doc Renders a template with a module presenter.
-spec render_with_module(template(), module()) -> string().
render_with_module(Template, Module) ->
    Presenter = fun(Reference) ->
        Function = list_to_atom(Reference),
        erlang:apply(Module, Function, [])
    end,
    render(Template, Presenter).

% @doc Renders a template with a dict presenter.
-spec render_with_dict(template(), dict:dict(atom(), string())) -> string().
render_with_dict(Template, Dict) ->
    Presenter = fun(Reference) ->
        Key = list_to_atom(Reference),
        {ok, Value} = dict:find(Key, Dict),
        Value
    end,
    render(Template, Presenter).

% @doc Compiles a template to a function.
-spec compile(template()) -> compiled_template().
compile(Template) -> curly_compiler:compile(Template).
