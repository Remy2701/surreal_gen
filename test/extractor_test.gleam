import common
import extractor
import gleam/dict
import gleam/option
import gleam/result
import surreal/node
import surreal_ql
import surreal_type

//-----------------------------------------------------------------------------------------------//
//                                         Normal table                                          //
//-----------------------------------------------------------------------------------------------//

/// Extract a table without any additional fields.                                           
/// - The `id` field is automatically included with the correct matching type                     
pub fn extract_regular_table_test() {
  let assert Ok(tables) =
    extractor.extract_tables("./src/db/test", [
      node.DefineNormalTable(
        name: "user",
        schemafull: True,
        permissions: node.Full,
        as_: option.None,
      ),
    ])
    |> result.map(extractor.complete_fields_dependencies)

  assert tables
    == dict.from_list([
      #(
        "user",
        extractor.TableInfo(
          name: common.SnakeCase("user"),
          path: "./src/db/test",
          fields: [
            extractor.TableField(
              dependencies: ["db/test", "surreal/identifier"],
              name: "id",
              type_: surreal_type.Identifier("User"),
              linked_enum: option.None,
              object_fields: [],
            ),
          ],
          enums: [],
          delegated: option.None,
        ),
      ),
    ])
}

/// Extract a table with an extra string field.                                                   
/// - The `id` field is automatically included with the correct matching type                     
/// - The extra field should be added to the same table with the correct matching type            
pub fn extract_with_string_field_test() {
  let assert Ok(tables) =
    extractor.extract_tables("./src/db/test", [
      node.DefineNormalTable(
        name: "user",
        schemafull: True,
        permissions: node.Full,
        as_: option.None,
      ),
      node.DefineField(
        name: node.Identifier("name"),
        table: "user",
        type_: surreal_type.String,
        flexible: False,
        default: option.None,
        assert_: option.None,
        permissions: option.None,
      ),
    ])
    |> result.map(extractor.complete_fields_dependencies)

  assert tables
    == dict.from_list([
      #(
        "user",
        extractor.TableInfo(
          name: common.SnakeCase("user"),
          path: "./src/db/test",
          fields: [
            extractor.TableField(
              dependencies: [
                "db/test",
                "surreal/identifier",
              ],
              name: "id",
              type_: surreal_type.Identifier(common.string_to_pascal_case(
                "user",
              )),
              linked_enum: option.None,
              object_fields: [],
            ),
            extractor.TableField(
              dependencies: [],
              name: "name",
              type_: surreal_type.String,
              linked_enum: option.None,
              object_fields: [],
            ),
          ],
          enums: [],
          delegated: option.None,
        ),
      ),
    ])
}

/// Extract a table with an extra int field.                                                   
/// - The `id` field is automatically included with the correct matching type                     
/// - The extra field should be added to the same table with the correct matching type            
pub fn extract_with_int_field_test() {
  let assert Ok(tables) =
    extractor.extract_tables("./src/db/test", [
      node.DefineNormalTable(
        name: "user",
        schemafull: True,
        permissions: node.Full,
        as_: option.None,
      ),
      node.DefineField(
        name: node.Identifier("age"),
        table: "user",
        type_: surreal_type.Int,
        flexible: False,
        default: option.None,
        assert_: option.None,
        permissions: option.None,
      ),
    ])
    |> result.map(extractor.complete_fields_dependencies)

  assert tables
    == dict.from_list([
      #(
        "user",
        extractor.TableInfo(
          name: common.SnakeCase("user"),
          path: "./src/db/test",
          fields: [
            extractor.TableField(
              dependencies: [
                "db/test",
                "surreal/identifier",
              ],
              name: "id",
              type_: surreal_type.Identifier(common.string_to_pascal_case(
                "user",
              )),
              linked_enum: option.None,
              object_fields: [],
            ),
            extractor.TableField(
              dependencies: [],
              name: "age",
              type_: surreal_type.Int,
              linked_enum: option.None,
              object_fields: [],
            ),
          ],
          enums: [],
          delegated: option.None,
        ),
      ),
    ])
}

/// Extract a table with an extra float field.                                                   
/// - The `id` field is automatically included with the correct matching type                     
/// - The extra field should be added to the same table with the correct matching type            
pub fn extract_with_float_field_test() {
  let assert Ok(tables) =
    extractor.extract_tables("./src/db/test", [
      node.DefineNormalTable(
        name: "user",
        schemafull: True,
        permissions: node.Full,
        as_: option.None,
      ),
      node.DefineField(
        name: node.Identifier("age"),
        table: "user",
        type_: surreal_type.Float,
        flexible: False,
        default: option.None,
        assert_: option.None,
        permissions: option.None,
      ),
    ])
    |> result.map(extractor.complete_fields_dependencies)

  assert tables
    == dict.from_list([
      #(
        "user",
        extractor.TableInfo(
          name: common.SnakeCase("user"),
          path: "./src/db/test",
          fields: [
            extractor.TableField(
              dependencies: [
                "db/test",
                "surreal/identifier",
              ],
              name: "id",
              type_: surreal_type.Identifier(common.string_to_pascal_case(
                "user",
              )),
              linked_enum: option.None,
              object_fields: [],
            ),
            extractor.TableField(
              dependencies: [],
              name: "age",
              type_: surreal_type.Float,
              linked_enum: option.None,
              object_fields: [],
            ),
          ],
          enums: [],
          delegated: option.None,
        ),
      ),
    ])
}

/// Extract a table with an extra bool field.                                                   
/// - The `id` field is automatically included with the correct matching type                     
/// - The extra field should be added to the same table with the correct matching type            
pub fn extract_with_bool_field_test() {
  let assert Ok(tables) =
    extractor.extract_tables("./src/db/test", [
      node.DefineNormalTable(
        name: "user",
        schemafull: True,
        permissions: node.Full,
        as_: option.None,
      ),
      node.DefineField(
        name: node.Identifier("is_active"),
        table: "user",
        type_: surreal_type.Bool,
        flexible: False,
        default: option.None,
        assert_: option.None,
        permissions: option.None,
      ),
    ])
    |> result.map(extractor.complete_fields_dependencies)

  assert tables
    == dict.from_list([
      #(
        "user",
        extractor.TableInfo(
          name: common.SnakeCase("user"),
          path: "./src/db/test",
          fields: [
            extractor.TableField(
              dependencies: [
                "db/test",
                "surreal/identifier",
              ],
              name: "id",
              type_: surreal_type.Identifier(common.string_to_pascal_case(
                "user",
              )),
              linked_enum: option.None,
              object_fields: [],
            ),
            extractor.TableField(
              dependencies: [],
              name: "is_active",
              type_: surreal_type.Bool,
              linked_enum: option.None,
              object_fields: [],
            ),
          ],
          enums: [],
          delegated: option.None,
        ),
      ),
    ])
}

/// Extract a table with an extra datetime field.                                                   
/// - The `id` field is automatically included with the correct matching type                     
/// - The extra field should be added to the same table with the correct matching type            
pub fn extract_with_datetime_field_test() {
  let assert Ok(tables) =
    extractor.extract_tables("./src/db/test", [
      node.DefineNormalTable(
        name: "user",
        schemafull: True,
        permissions: node.Full,
        as_: option.None,
      ),
      node.DefineField(
        name: node.Identifier("created_at"),
        table: "user",
        type_: surreal_type.Datetime,
        flexible: False,
        default: option.None,
        assert_: option.None,
        permissions: option.None,
      ),
    ])
    |> result.map(extractor.complete_fields_dependencies)

  assert tables
    == dict.from_list([
      #(
        "user",
        extractor.TableInfo(
          name: common.SnakeCase("user"),
          path: "./src/db/test",
          fields: [
            extractor.TableField(
              dependencies: [
                "db/test",
                "surreal/identifier",
              ],
              name: "id",
              type_: surreal_type.Identifier(common.string_to_pascal_case(
                "user",
              )),
              linked_enum: option.None,
              object_fields: [],
            ),
            extractor.TableField(
              dependencies: ["birl"],
              name: "created_at",
              type_: surreal_type.Datetime,
              linked_enum: option.None,
              object_fields: [],
            ),
          ],
          enums: [],
          delegated: option.None,
        ),
      ),
    ])
}

/// Extract a table with an extra point field.                                                   
/// - The `id` field is automatically included with the correct matching type                     
/// - The extra field should be added to the same table with the correct matching type            
pub fn extract_with_point_field_test() {
  let assert Ok(tables) =
    extractor.extract_tables("./src/db/test", [
      node.DefineNormalTable(
        name: "user",
        schemafull: True,
        permissions: node.Full,
        as_: option.None,
      ),
      node.DefineField(
        name: node.Identifier("location"),
        table: "user",
        type_: surreal_type.Point,
        flexible: False,
        default: option.None,
        assert_: option.None,
        permissions: option.None,
      ),
    ])
    |> result.map(extractor.complete_fields_dependencies)

  assert tables
    == dict.from_list([
      #(
        "user",
        extractor.TableInfo(
          name: common.SnakeCase("user"),
          path: "./src/db/test",
          fields: [
            extractor.TableField(
              dependencies: [
                "db/test",
                "surreal/identifier",
              ],
              name: "id",
              type_: surreal_type.Identifier(common.string_to_pascal_case(
                "user",
              )),
              linked_enum: option.None,
              object_fields: [],
            ),
            extractor.TableField(
              dependencies: [
                "surreal/point",
              ],
              name: "location",
              type_: surreal_type.Point,
              linked_enum: option.None,
              object_fields: [],
            ),
          ],
          enums: [],
          delegated: option.None,
        ),
      ),
    ])
}

/// Extract a table with an extra identifier field.                                                   
/// - The `id` field is automatically included with the correct matching type                     
/// - The extra field should be added to the same table with the correct matching type            
pub fn extract_with_identifier_field_test() {
  let assert Ok(tables) =
    extractor.extract_tables("./src/db/test", [
      node.DefineNormalTable(
        name: "user",
        schemafull: True,
        permissions: node.Full,
        as_: option.None,
      ),
      node.DefineField(
        name: node.Identifier("parent"),
        table: "user",
        type_: surreal_type.Identifier("user"),
        flexible: False,
        default: option.None,
        assert_: option.None,
        permissions: option.None,
      ),
    ])
    |> result.map(extractor.complete_fields_dependencies)

  assert tables
    == dict.from_list([
      #(
        "user",
        extractor.TableInfo(
          name: common.SnakeCase("user"),
          path: "./src/db/test",
          fields: [
            extractor.TableField(
              dependencies: [
                "db/test",
                "surreal/identifier",
              ],
              name: "id",
              type_: surreal_type.Identifier(common.string_to_pascal_case(
                "user",
              )),
              linked_enum: option.None,
              object_fields: [],
            ),
            extractor.TableField(
              dependencies: [
                "db/test",
                "surreal/identifier",
              ],
              name: "parent",
              type_: surreal_type.Identifier("user"),
              linked_enum: option.None,
              object_fields: [],
            ),
          ],
          enums: [],
          delegated: option.None,
        ),
      ),
    ])
}

/// Extract a table with an extra record field.                                                   
/// - The `id` field is automatically included with the correct matching type                     
/// - The extra field should be added to the same table with the correct matching type            
pub fn extract_with_record_field_test() {
  let assert Ok(tables) =
    extractor.extract_tables("./src/db/test", [
      node.DefineNormalTable(
        name: "user",
        schemafull: True,
        permissions: node.Full,
        as_: option.None,
      ),
      node.DefineField(
        name: node.Identifier("parent"),
        table: "user",
        type_: surreal_type.Record("user"),
        flexible: False,
        default: option.None,
        assert_: option.None,
        permissions: option.None,
      ),
    ])
    |> result.map(extractor.complete_fields_dependencies)

  assert tables
    == dict.from_list([
      #(
        "user",
        extractor.TableInfo(
          name: common.SnakeCase("user"),
          path: "./src/db/test",
          fields: [
            extractor.TableField(
              dependencies: [
                "db/test",
                "surreal/identifier",
              ],
              name: "id",
              type_: surreal_type.Identifier(common.string_to_pascal_case(
                "user",
              )),
              linked_enum: option.None,
              object_fields: [],
            ),
            extractor.TableField(
              dependencies: [
                "db/test",
                "surreal/record",
              ],
              name: "parent",
              type_: surreal_type.Record("user"),
              linked_enum: option.None,
              object_fields: [],
            ),
          ],
          enums: [],
          delegated: option.None,
        ),
      ),
    ])
}

/// Extract a table with an extra optional string field.                                                   
/// - The `id` field is automatically included with the correct matching type                     
/// - The extra field should be added to the same table with the correct matching type            
pub fn extract_with_optional_string_field_test() {
  let assert Ok(tables) =
    extractor.extract_tables("./src/db/test", [
      node.DefineNormalTable(
        name: "user",
        schemafull: True,
        permissions: node.Full,
        as_: option.None,
      ),
      node.DefineField(
        name: node.Identifier("name"),
        table: "user",
        type_: surreal_type.Option(surreal_type.String),
        flexible: False,
        default: option.None,
        assert_: option.None,
        permissions: option.None,
      ),
    ])
    |> result.map(extractor.complete_fields_dependencies)

  assert tables
    == dict.from_list([
      #(
        "user",
        extractor.TableInfo(
          name: common.SnakeCase("user"),
          path: "./src/db/test",
          fields: [
            extractor.TableField(
              dependencies: [
                "db/test",
                "surreal/identifier",
              ],
              name: "id",
              type_: surreal_type.Identifier(common.string_to_pascal_case(
                "user",
              )),
              linked_enum: option.None,
              object_fields: [],
            ),
            extractor.TableField(
              dependencies: ["gleam/option"],
              name: "name",
              type_: surreal_type.Option(surreal_type.String),
              linked_enum: option.None,
              object_fields: [],
            ),
          ],
          enums: [],
          delegated: option.None,
        ),
      ),
    ])
}

/// Extract a table with an extra string field with assertion.                                                   
/// - The `id` field is automatically included with the correct matching type     
/// - An enum should be created for the assertion with the correct values                
/// - The extra field should be added to the same table with the correct matching enum type            
pub fn extract_with_enum_string_field_test() {
  let assert Ok(tables) =
    extractor.extract_tables("./src/db/test", [
      node.DefineNormalTable(
        name: "user",
        schemafull: True,
        permissions: node.Full,
        as_: option.None,
      ),
      node.DefineField(
        name: node.Identifier("role"),
        table: "user",
        type_: surreal_type.String,
        flexible: False,
        default: option.None,
        assert_: option.Some(node.BinaryOperator(
          lhs: node.Parameter("value"),
          operator: node.Inside,
          rhs: node.Array([
            node.Value(surreal_ql.String("admin")),
            node.Value(surreal_ql.String("editor")),
            node.Value(surreal_ql.String("viewer")),
          ]),
        )),
        permissions: option.None,
      ),
    ])
    |> result.map(extractor.complete_fields_dependencies)

  assert tables
    == dict.from_list([
      #(
        "user",
        extractor.TableInfo(
          name: common.SnakeCase("user"),
          path: "./src/db/test",
          fields: [
            extractor.TableField(
              dependencies: [
                "db/test",
                "surreal/identifier",
              ],
              name: "id",
              type_: surreal_type.Identifier(common.string_to_pascal_case(
                "user",
              )),
              linked_enum: option.None,
              object_fields: [],
            ),
            extractor.TableField(
              dependencies: ["db/test"],
              name: "role",
              type_: surreal_type.String,
              linked_enum: option.Some("role"),
              object_fields: [],
            ),
          ],
          enums: [
            #("role", [
              "admin",
              "editor",
              "viewer",
            ]),
          ],
          delegated: option.None,
        ),
      ),
    ])
}

/// Extract a table with an extra string field with assertion.                                                   
/// - The `id` field is automatically included with the correct matching type     
/// - An enum should be created for the assertion with the correct values                
/// - The extra field should be added to the same table with the correct matching enum type            
pub fn extract_with_enum_string_with_none_field_test() {
  let assert Ok(tables) =
    extractor.extract_tables("./src/db/test", [
      node.DefineNormalTable(
        name: "user",
        schemafull: True,
        permissions: node.Full,
        as_: option.None,
      ),
      node.DefineField(
        name: node.Identifier("role"),
        table: "user",
        type_: surreal_type.String,
        flexible: False,
        default: option.None,
        assert_: option.Some(node.BinaryOperator(
          lhs: node.Parameter("value"),
          operator: node.Inside,
          rhs: node.Array([
            node.Value(surreal_ql.String("admin")),
            node.Value(surreal_ql.String("editor")),
            node.Value(surreal_ql.String("viewer")),
            node.None,
          ]),
        )),
        permissions: option.None,
      ),
    ])
    |> result.map(extractor.complete_fields_dependencies)

  assert tables
    == dict.from_list([
      #(
        "user",
        extractor.TableInfo(
          name: common.SnakeCase("user"),
          path: "./src/db/test",
          fields: [
            extractor.TableField(
              dependencies: [
                "db/test",
                "surreal/identifier",
              ],
              name: "id",
              type_: surreal_type.Identifier(common.string_to_pascal_case(
                "user",
              )),
              linked_enum: option.None,
              object_fields: [],
            ),
            extractor.TableField(
              dependencies: [
                "db/test",
              ],
              name: "role",
              type_: surreal_type.String,
              linked_enum: option.Some("role"),
              object_fields: [],
            ),
          ],
          enums: [
            #("role", [
              "admin",
              "editor",
              "viewer",
            ]),
          ],
          delegated: option.None,
        ),
      ),
    ])
}

/// Extract a table with an extra string field with assertion.                                                   
/// - The `id` field is automatically included with the correct matching type     
/// - An enum should be created for the assertion with the correct values                
/// - The extra field should be added to the same table with the correct matching enum type            
pub fn extract_with_optiona_enum_string_with_null_field_test() {
  let assert Ok(tables) =
    extractor.extract_tables("./src/db/test", [
      node.DefineNormalTable(
        name: "user",
        schemafull: True,
        permissions: node.Full,
        as_: option.None,
      ),
      node.DefineField(
        name: node.Identifier("role"),
        table: "user",
        type_: surreal_type.Option(surreal_type.String),
        flexible: False,
        default: option.None,
        assert_: option.Some(node.BinaryOperator(
          lhs: node.Parameter("value"),
          operator: node.Inside,
          rhs: node.Array([
            node.Value(surreal_ql.String("admin")),
            node.Value(surreal_ql.String("editor")),
            node.Value(surreal_ql.String("viewer")),
            node.Value(surreal_ql.Null),
          ]),
        )),
        permissions: option.None,
      ),
    ])
    |> result.map(extractor.complete_fields_dependencies)

  assert tables
    == dict.from_list([
      #(
        "user",
        extractor.TableInfo(
          name: common.SnakeCase("user"),
          path: "./src/db/test",
          fields: [
            extractor.TableField(
              dependencies: [
                "db/test",
                "surreal/identifier",
              ],
              name: "id",
              type_: surreal_type.Identifier(common.string_to_pascal_case(
                "user",
              )),
              linked_enum: option.None,
              object_fields: [],
            ),
            extractor.TableField(
              dependencies: ["db/test", "gleam/option"],
              name: "role",
              type_: surreal_type.Option(surreal_type.String),
              linked_enum: option.Some("role"),
              object_fields: [],
            ),
          ],
          enums: [
            #("role", [
              "admin",
              "editor",
              "viewer",
            ]),
          ],
          delegated: option.None,
        ),
      ),
    ])
}

/// Extract a table with an extra string array field.                                                   
/// - The `id` field is automatically included with the correct matching type                     
/// - The extra field should be added to the same table with the correct matching type            
pub fn extract_with_string_array_field_test() {
  let assert Ok(tables) =
    extractor.extract_tables("./src/db/test", [
      node.DefineNormalTable(
        name: "user",
        schemafull: True,
        permissions: node.Full,
        as_: option.None,
      ),
      node.DefineField(
        name: node.Identifier("tags"),
        table: "user",
        type_: surreal_type.Array(surreal_type.String),
        flexible: False,
        default: option.None,
        assert_: option.None,
        permissions: option.None,
      ),
    ])
    |> result.map(extractor.complete_fields_dependencies)

  assert tables
    == dict.from_list([
      #(
        "user",
        extractor.TableInfo(
          name: common.SnakeCase("user"),
          path: "./src/db/test",
          fields: [
            extractor.TableField(
              dependencies: [
                "db/test",
                "surreal/identifier",
              ],
              name: "id",
              type_: surreal_type.Identifier(common.string_to_pascal_case(
                "user",
              )),
              linked_enum: option.None,
              object_fields: [],
            ),
            extractor.TableField(
              dependencies: [],
              name: "tags",
              type_: surreal_type.Array(surreal_type.String),
              linked_enum: option.None,
              object_fields: [],
            ),
          ],
          enums: [],
          delegated: option.None,
        ),
      ),
    ])
}

/// Extract a table with an extra string array field.                                                   
/// - The `id` field is automatically included with the correct matching type                     
/// - The extra field should be added to the same table with the correct matching type            
pub fn extract_with_string_array_field_with_constraints_test() {
  let assert Ok(tables) =
    extractor.extract_tables("./src/db/test", [
      node.DefineNormalTable(
        name: "user",
        schemafull: True,
        permissions: node.Full,
        as_: option.None,
      ),
      node.DefineField(
        name: node.Identifier("tags"),
        table: "user",
        type_: surreal_type.Array(surreal_type.String),
        flexible: False,
        default: option.None,
        assert_: option.None,
        permissions: option.None,
      ),
      node.DefineField(
        name: node.BinaryOperator(
          node.Identifier("tags"),
          node.Access,
          node.All,
        ),
        table: "user",
        type_: surreal_type.Array(surreal_type.String),
        flexible: False,
        default: option.None,
        assert_: option.None,
        permissions: option.None,
      ),
    ])
    |> result.map(extractor.complete_fields_dependencies)

  assert tables
    == dict.from_list([
      #(
        "user",
        extractor.TableInfo(
          name: common.SnakeCase("user"),
          path: "./src/db/test",
          fields: [
            extractor.TableField(
              dependencies: [
                "db/test",
                "surreal/identifier",
              ],
              name: "id",
              type_: surreal_type.Identifier(common.string_to_pascal_case(
                "user",
              )),
              linked_enum: option.None,
              object_fields: [],
            ),
            extractor.TableField(
              dependencies: [],
              name: "tags",
              type_: surreal_type.Array(surreal_type.String),
              linked_enum: option.None,
              object_fields: [],
            ),
          ],
          enums: [],
          delegated: option.None,
        ),
      ),
    ])
}

/// Extract a table with an extra string array field.                                                   
/// - The `id` field is automatically included with the correct matching type                     
/// - The extra field should be added to the same table with the correct matching type            
pub fn extract_with_nest_fields_test() {
  let assert Ok(tables) =
    extractor.extract_tables("./src/db/test", [
      node.DefineNormalTable(
        name: "user",
        schemafull: True,
        permissions: node.Full,
        as_: option.None,
      ),
      node.DefineField(
        name: node.BinaryOperator(
          node.Identifier("settings"),
          node.Access,
          node.Identifier("private"),
        ),
        table: "user",
        type_: surreal_type.Bool,
        flexible: False,
        default: option.None,
        assert_: option.None,
        permissions: option.None,
      ),
      node.DefineField(
        name: node.BinaryOperator(
          node.Identifier("settings"),
          node.Access,
          node.Identifier("allow_notifications"),
        ),
        table: "user",
        type_: surreal_type.Bool,
        flexible: False,
        default: option.None,
        assert_: option.None,
        permissions: option.None,
      ),
    ])
    |> result.map(extractor.complete_fields_dependencies)

  assert tables
    == dict.from_list([
      #(
        "user",
        extractor.TableInfo(
          name: common.SnakeCase("user"),
          path: "./src/db/test",
          fields: [
            extractor.TableField(
              dependencies: [
                "db/test",
                "surreal/identifier",
              ],
              name: "id",
              type_: surreal_type.Identifier(common.string_to_pascal_case(
                "user",
              )),
              linked_enum: option.None,
              object_fields: [],
            ),
            extractor.TableField(
              dependencies: ["json_value"],
              name: "settings",
              type_: surreal_type.Object,
              linked_enum: option.None,
              object_fields: [
                extractor.TableField(
                  dependencies: [],
                  name: "private",
                  type_: surreal_type.Bool,
                  linked_enum: option.None,
                  object_fields: [],
                ),
                extractor.TableField(
                  dependencies: [],
                  name: "allow_notifications",
                  type_: surreal_type.Bool,
                  linked_enum: option.None,
                  object_fields: [],
                ),
              ],
            ),
          ],
          enums: [],
          delegated: option.None,
        ),
      ),
    ])
}

/// Extract a table with an extra flexible object field.                                                   
/// - The `id` field is automatically included with the correct matching type                     
/// - The extra field should be added to the same table with the correct matching type            
pub fn extract_with_flexible_object_field_test() {
  let assert Ok(tables) =
    extractor.extract_tables("./src/db/test", [
      node.DefineNormalTable(
        name: "user",
        schemafull: True,
        permissions: node.Full,
        as_: option.None,
      ),
      node.DefineField(
        name: node.Identifier("meta"),
        table: "user",
        type_: surreal_type.Object,
        flexible: True,
        default: option.None,
        assert_: option.None,
        permissions: option.None,
      ),
    ])
    |> result.map(extractor.complete_fields_dependencies)

  assert tables
    == dict.from_list([
      #(
        "user",
        extractor.TableInfo(
          name: common.SnakeCase("user"),
          path: "./src/db/test",
          fields: [
            extractor.TableField(
              dependencies: [
                "db/test",
                "surreal/identifier",
              ],
              name: "id",
              type_: surreal_type.Identifier(common.string_to_pascal_case(
                "user",
              )),
              linked_enum: option.None,
              object_fields: [],
            ),
            extractor.TableField(
              dependencies: ["json_value"],
              name: "meta",
              type_: surreal_type.Object,
              linked_enum: option.None,
              object_fields: [],
            ),
          ],
          enums: [],
          delegated: option.None,
        ),
      ),
    ])
}

//-----------------------------------------------------------------------------------------------//
//                                        Relation table                                         //
//-----------------------------------------------------------------------------------------------//

/// Extract a table without any additional fields.                                           
/// - The `id` field is automatically included with the correct matching type                     
pub fn extract_relation_table_test() {
  let assert Ok(tables) =
    extractor.extract_tables("./src/db/test", [
      node.DefineRelationTable(
        name: "friend",
        schemafull: True,
        permissions: node.Full,
        in: "user",
        out: "user",
      ),
    ])
    |> result.map(extractor.complete_fields_dependencies)

  assert tables
    == dict.from_list([
      #(
        "friend",
        extractor.TableInfo(
          name: common.SnakeCase("friend"),
          path: "./src/db/test",
          fields: [
            extractor.TableField(
              dependencies: [
                "db/test",
                "surreal/identifier",
              ],
              name: "id",
              type_: surreal_type.Identifier("Friend"),
              linked_enum: option.None,
              object_fields: [],
            ),
          ],
          enums: [],
          delegated: option.None,
        ),
      ),
    ])
}

/// Extract a table with the in and out fields.                                           
/// - The `id` field is automatically included with the correct matching type                     
pub fn extract_relation_table_with_in_out_fields_test() {
  let assert Ok(tables) =
    extractor.extract_tables("./src/db/test", [
      node.DefineNormalTable(
        name: "user",
        schemafull: True,
        permissions: node.Full,
        as_: option.None,
      ),
      node.DefineRelationTable(
        name: "friend",
        schemafull: True,
        permissions: node.Full,
        in: "user",
        out: "user",
      ),
      node.DefineField(
        name: node.Identifier("in"),
        table: "friend",
        type_: surreal_type.Record("user"),
        flexible: False,
        default: option.None,
        assert_: option.None,
        permissions: option.None,
      ),
      node.DefineField(
        name: node.Identifier("out"),
        table: "friend",
        type_: surreal_type.Record("user"),
        flexible: False,
        default: option.None,
        assert_: option.None,
        permissions: option.None,
      ),
    ])
    |> result.map(extractor.complete_fields_dependencies)

  assert tables
    == dict.from_list([
      #(
        "user",
        extractor.TableInfo(
          name: common.SnakeCase("user"),
          path: "./src/db/test",
          fields: [
            extractor.TableField(
              dependencies: [
                "db/test",
                "surreal/identifier",
              ],
              name: "id",
              type_: surreal_type.Identifier("User"),
              linked_enum: option.None,
              object_fields: [],
            ),
          ],
          enums: [],
          delegated: option.None,
        ),
      ),
      #(
        "friend",
        extractor.TableInfo(
          name: common.SnakeCase("friend"),
          path: "./src/db/test",
          fields: [
            extractor.TableField(
              dependencies: [
                "db/test",
                "surreal/identifier",
              ],
              name: "id",
              type_: surreal_type.Identifier("Friend"),
              linked_enum: option.None,
              object_fields: [],
            ),
            extractor.TableField(
              dependencies: [
                "db/test",
                "surreal/record",
              ],
              name: "in",
              type_: surreal_type.Record("user"),
              linked_enum: option.None,
              object_fields: [],
            ),
            extractor.TableField(
              dependencies: [
                "db/test",
                "surreal/record",
              ],
              name: "out",
              type_: surreal_type.Record("user"),
              linked_enum: option.None,
              object_fields: [],
            ),
          ],
          enums: [],
          delegated: option.None,
        ),
      ),
    ])
}
