import argv
import clip
import clip/arg
import clip/flag
import common
import extractor
import generator
import gleam/dict
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import lexer
import parser
import simplifile

/// List the files ending with ".surql" in the given directory and its 
/// subdirectories recursively.
fn list_files(
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

/// Define the command-line interface for the tool.
fn command() {
  clip.command({
    use backstage <- clip.parameter
    use path <- clip.parameter

    common.Configuration(backstage, path)
  })
  |> clip.flag(
    flag.new("backstage") |> flag.help("Enable backstage integration"),
  )
  |> clip.arg(
    arg.new("path")
    |> arg.default("./src")
    |> arg.help("Path to the source directory"),
  )
}

pub fn main() -> Nil {
  // Parse the arguments
  let assert Ok(config) =
    command()
    |> clip.run(argv.load().arguments)

  // List the files
  let assert Ok(files) = list_files(config.path, [])

  // Read all *.surql files
  let assert Ok(content) =
    list.try_map(files, fn(file) { simplifile.read(file <> ".surql") })

  // Tokenize the content of the files
  let assert Ok(tokens) =
    list.zip(files, content)
    |> list.try_map(fn(entry) {
      let #(file, content) = entry
      lexer.tokenize(file, content)
      |> result.map_error(lexer.render_error(_, content))
    })
    |> result.map_error(io.println)

  // Parse the tokens into AST nodes
  let assert Ok(nodes) =
    list.zip(tokens, content)
    |> list.try_map(fn(entry) {
      let #(tokens, content) = entry
      parser.parse(tokens)
      |> result.map_error(parser.render_error(_, content))
    })
    |> result.map_error(io.println)

  // Extract tables from the AST nodes
  let assert Ok(tables) =
    list.zip(files, nodes)
    |> list.try_map(fn(entry) { extractor.extract_tables(entry.0, entry.1) })

  // Complete table extraction
  let tables =
    list.fold(tables, dict.new(), fn(acc, table) { dict.merge(acc, table) })
    |> extractor.complete_fields_dependencies()
    |> generator.process_delegated_table

  // Generate the output files
  let assert Ok(_) =
    list.zip(files, content)
    |> list.zip(nodes)
    |> list.try_each(fn(entry) {
      let #(#(file, raw), ast) = entry
      use content <- result.try(generator.generate_file(
        config,
        raw,
        ast,
        tables,
      ))
      use _ <- result.try(
        simplifile.write(file <> ".gleam", content)
        |> result.map_error(fn(_) { "Failed to write file: " <> file }),
      )
      Ok(Nil)
    })

  Nil
}
