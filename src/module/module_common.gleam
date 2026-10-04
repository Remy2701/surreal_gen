import common
import module.{type Module}

pub fn type_identifier(name: String) -> Module {
  name |> common.string_to_pascal_case |> module.identifier.create
}
