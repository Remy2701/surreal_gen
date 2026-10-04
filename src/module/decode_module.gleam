import module.{type Module}

pub fn decoder() -> Module {
  module.binop.access(
    module.identifier.create("decode"),
    module.identifier.create("Decoder"),
  )
  |> module.add_import(["gleam", "dynamic", "decode"])
}

pub fn decoder_of(of: Module) -> Module {
  decoder()
  |> module.function_call.create()
  |> module.function_call.add(of)
}

pub fn then(inner: Module) -> Module {
  module.binop.access(
    module.identifier.create("decode"),
    module.identifier.create("then"),
  )
  |> module.function_call.create()
  |> module.function_call.add(inner)
  |> module.add_import(["gleam", "dynamic", "decode"])
}

pub fn string() -> Module {
  module.binop.access(
    module.identifier.create("decode"),
    module.identifier.create("string"),
  )
  |> module.add_import(["gleam", "dynamic", "decode"])
}

pub fn success() -> Module {
  module.binop.access(
    module.identifier.create("decode"),
    module.identifier.create("success"),
  )
  |> module.add_import(["gleam", "dynamic", "decode"])
}

pub fn success_of(value: Module) -> Module {
  success()
  |> module.function_call.create()
  |> module.function_call.add(value)
}

pub fn failure() -> Module {
  module.binop.access(
    module.identifier.create("decode"),
    module.identifier.create("failure"),
  )
  |> module.add_import(["gleam", "dynamic", "decode"])
}

pub fn failure_of(value: Module, error: Module) -> Module {
  failure()
  |> module.function_call.create()
  |> module.function_call.add(value)
  |> module.function_call.add(error)
}
