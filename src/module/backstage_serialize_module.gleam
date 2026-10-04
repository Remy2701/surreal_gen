import gleam/list
import module.{type Module}

pub fn serializer() -> Module {
  module.binop.access(
    module.identifier.create("serialize"),
    module.identifier.create("Serializer"),
  )
  |> module.add_import(["dynamic", "serialize"])
}

pub fn serializer_of(of: Module) -> Module {
  serializer()
  |> module.function_call.create()
  |> module.function_call.add(of)
}

pub fn string_enum() -> Module {
  module.binop.access(
    module.identifier.create("serialize"),
    module.identifier.create("string_enum"),
  )
  |> module.add_import(["dynamic", "serialize"])
}

pub fn string_enum_of(values: Module, to_string: Module) -> Module {
  string_enum()
  |> module.function_call.create()
  |> module.function_call.add(values)
  |> module.function_call.add(to_string)
}

pub fn timestamp() -> Module {
  module.function_call.create(module.binop.access(
    module.identifier.create("serialize"),
    module.identifier.create("timestamp"),
  ))
  |> module.add_import(["dynamic", "serialize"])
}

pub fn int() -> Module {
  module.function_call.create(module.binop.access(
    module.identifier.create("serialize"),
    module.identifier.create("int"),
  ))
  |> module.add_import(["dynamic", "serialize"])
}

pub fn float() -> Module {
  module.function_call.create(module.binop.access(
    module.identifier.create("serialize"),
    module.identifier.create("float"),
  ))
  |> module.add_import(["dynamic", "serialize"])
}

pub fn string() -> Module {
  module.function_call.create(module.binop.access(
    module.identifier.create("serialize"),
    module.identifier.create("string"),
  ))
  |> module.add_import(["dynamic", "serialize"])
}

pub fn bool() -> Module {
  module.function_call.create(module.binop.access(
    module.identifier.create("serialize"),
    module.identifier.create("bool"),
  ))
  |> module.add_import(["dynamic", "serialize"])
}

pub fn json_value() -> Module {
  module.function_call.create(module.binop.access(
    module.identifier.create("serialize"),
    module.identifier.create("json_value"),
  ))
  |> module.add_import(["dynamic", "serialize"])
}

pub fn nil() -> Module {
  module.function_call.create(module.binop.access(
    module.identifier.create("serialize"),
    module.identifier.create("nil"),
  ))
  |> module.add_import(["dynamic", "serialize"])
}

pub fn optional() -> Module {
  module.function_call.create(module.binop.access(
    module.identifier.create("serialize"),
    module.identifier.create("optional"),
  ))
  |> module.add_import(["dynamic", "serialize"])
}

pub fn optional_of(inner: Module) -> Module {
  optional()
  |> module.function_call.add(inner)
}

pub fn list() -> Module {
  module.function_call.create(module.binop.access(
    module.identifier.create("serialize"),
    module.identifier.create("list"),
  ))
  |> module.add_import(["dynamic", "serialize"])
}

pub fn list_of(inner: Module) -> Module {
  list()
  |> module.function_call.add(inner)
}

pub fn identifier() -> Module {
  module.function_call.create(module.binop.access(
    module.identifier.create("bs_identifier"),
    module.identifier.create("serializer"),
  ))
  |> module.add_aliased_import(
    ["backstage_surreal", "identifier"],
    "bs_identifier",
  )
}

pub fn record() -> Module {
  module.function_call.create(module.binop.access(
    module.identifier.create("bs_record"),
    module.identifier.create("serializer"),
  ))
  |> module.add_aliased_import(["backstage_surreal", "record"], "bs_record")
}

pub fn record_of(inner: Module, id: Module) -> Module {
  record()
  |> module.function_call.add(inner)
  |> module.function_call.add(id)
}

pub fn point() -> Module {
  module.function_call.create(module.binop.access(
    module.identifier.create("bs_point"),
    module.identifier.create("serializer"),
  ))
  |> module.add_aliased_import(["backstage_surreal", "point"], "bs_point")
}

pub fn object() -> Module {
  module.function_call.create(module.binop.access(
    module.identifier.create("serialize"),
    module.identifier.create("object"),
  ))
  |> module.add_import(["dynamic", "serialize"])
}

pub fn object_of(content: List(Module)) -> Module {
  object()
  |> module.function_call.add(
    module.function_definition.create()
    |> module.function_definition.add_untyped_parameter("context")
    |> list.fold(content, _, module.function_definition.add),
  )
}

pub fn field() -> Module {
  module.function_call.create(module.binop.access(
    module.identifier.create("serialize"),
    module.identifier.create("field"),
  ))
  |> module.add_import(["dynamic", "serialize"])
}

pub fn field_of(
  context: Module,
  name: Module,
  serializer: Module,
  getter: Module,
) -> Module {
  field()
  |> module.function_call.add(context)
  |> module.function_call.add(name)
  |> module.function_call.add(serializer)
  |> module.function_call.add(getter)
}

pub fn optional_field() -> Module {
  module.function_call.create(module.binop.access(
    module.identifier.create("serialize"),
    module.identifier.create("optional_field"),
  ))
  |> module.add_import(["dynamic", "serialize"])
}

pub fn optional_field_of(
  context: Module,
  name: Module,
  default: Module,
  serializer: Module,
  getter: Module,
) -> Module {
  optional_field()
  |> module.function_call.add(context)
  |> module.function_call.add(name)
  |> module.function_call.add(default)
  |> module.function_call.add(serializer)
  |> module.function_call.add(getter)
}

pub fn build() -> Module {
  module.function_call.create(module.binop.access(
    module.identifier.create("serialize"),
    module.identifier.create("build"),
  ))
  |> module.add_import(["dynamic", "serialize"])
}

pub fn build_of(context: Module, value: Module) -> Module {
  build()
  |> module.function_call.add(context)
  |> module.function_call.add(value)
}

pub fn success() -> Module {
  module.function_call.create(module.binop.access(
    module.identifier.create("serialize"),
    module.identifier.create("success"),
  ))
  |> module.add_import(["dynamic", "serialize"])
}

pub fn success_of(inner: Module) -> Module {
  success()
  |> module.function_call.add(inner)
}
