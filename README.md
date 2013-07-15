ecurly
======

Curly templates for Erlang!

```erlang
% Templates are simple strings:
Template = "Hello {{name}}!",

% You can render the template using `curly:render_with_dict` if you want to
% supply the values of the references with a dict().
Dict = dict:from_list([{name, "World"}]),
{ok, "Hello World!"} = curly:render_with_dict(Template, Dict),

% You can also use a module to supply the values. It needs to export a function
% with the name of the reference. In this example, `some_module` exports
% `name/0`.
{ok, "Hello World!"} = curly:render_with_module(Template, some_module),

% Finally, you can supply a function of your own to look up reference values.
Presenter = fun(Reference) ->
    case Reference of
        "name" -> "World"
    end
end,
{ok, "Hello World!"} = curly:render(Template, Presenter),

kthxbye.
```
