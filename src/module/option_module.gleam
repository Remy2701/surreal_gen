import module.{type Module}

pub fn type_(inner: Module) -> Module {
  module.binop.access(
    module.identifier.create("option"),
    module.identifier.create("Option"),
  )
  |> module.function_call.create()
  |> module.function_call.add(inner)
  |> module.add_import(["gleam", "option"])
}
