import argv
import extractor
import generator
import gleam/dict
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import lexer
import parser
import positioned
import simplifile

pub fn list_files(
  base: String,
  list: List(String),
) -> Result(List(String), String) {
  use paths <- result.try(
    simplifile.read_directory(base)
    |> result.map_error(fn(_) { "Failed to read directory: " <> base }),
  )
  use data <- result.try(
    list.try_fold(paths, list, fn(acc, path) {
      use is_directory <- result.try(
        simplifile.is_directory(base <> "/" <> path)
        |> result.map_error(fn(_) {
          "Failed to check if path is directory: " <> base <> "/" <> path
        }),
      )
      use files <- result.try(case is_directory {
        True -> list_files(base <> "/" <> path, acc)
        False -> {
          let #(name, extension) =
            string.split_once(path, ".") |> result.unwrap(#(path, ""))
          case extension {
            "surql" -> Ok([base <> "/" <> name, ..acc])
            _ -> Ok(acc)
          }
        }
      })
      Ok(files)
    }),
  )
  Ok(data)
}

pub fn main() -> Nil {
  let argv = argv.load()
  let path = list.first(argv.arguments) |> result.unwrap("./src")

  let assert Ok(files) = list_files(path, [])
  let assert Ok(content) =
    list.try_map(files, fn(file) { simplifile.read(file <> ".surql") })
  let assert Ok(tokens) =
    list.zip(files, content)
    |> list.try_map(fn(entry) {
      let #(file, content) = entry
      lexer.tokenize(file, content)
      |> result.map_error(fn(e) {
        positioned.render(
          positioned.Positioned(Nil, e.position, e.position),
          content,
        )
        <> "\n\n"
        <> e.message
      })
    })
    |> result.map_error(io.println)

  let assert Ok(nodes) =
    list.zip(tokens, content)
    // |> list.map(fn(l) { list.map(l, fn(p) { p.value }) })
    |> list.try_map(fn(entry) {
      let #(tokens, content) = entry
      parser.parse(tokens)
      |> result.map_error(fn(e) {
        case e {
          parser.UnexpectedToken(expected:, actual:) -> {
            positioned.render(actual, content)
            <> "\n\n"
            <> "Unexpected token: "
            <> string.inspect(actual.value)
            <> "\nExpected one of: "
            <> string.join(
              list.map(expected, fn(e) {
                case e {
                  parser.NodeExpression -> "NodeExpression"
                  parser.NodeType -> "NodeType"
                  parser.Token(token) ->
                    "Token(" <> string.inspect(token) <> ")"
                }
              }),
              ", ",
            )
          }
          parser.UnexpectedEOF(expected:) -> {
            "Unexpected end of file\nExpected one of: "
            <> string.join(
              list.map(expected, fn(e) {
                case e {
                  parser.NodeExpression -> "NodeExpression"
                  parser.NodeType -> "NodeType"
                  parser.Token(token) ->
                    "Token(" <> string.inspect(token) <> ")"
                }
              }),
              ", ",
            )
          }
        }
      })
    })
    |> result.map_error(io.println)
  let assert Ok(tables) =
    list.zip(files, nodes)
    |> list.try_map(fn(entry) { extractor.extract_tables(entry.0, entry.1) })
  let tables =
    list.fold(tables, dict.new(), fn(acc, table) { dict.merge(acc, table) })
    |> extractor.complete_fields_dependencies()
  let tables = generator.process_delegated_table(tables)

  let assert Ok(_) =
    list.zip(files, content)
    |> list.zip(nodes)
    |> list.try_each(fn(entry) {
      let #(#(file, raw), ast) = entry
      use content <- result.try(generator.generate_file(raw, ast, tables))
      use _ <- result.try(
        simplifile.write(file <> ".gleam", content)
        |> result.map_error(fn(_) { "Failed to write file: " <> file }),
      )
      Ok(Nil)
    })

  Nil
}
