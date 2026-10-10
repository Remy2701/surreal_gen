# suweal_gen

[![Package Version](https://img.shields.io/hexpm/v/suweal_gen_unpublished)](https://hex.pm/packages/suweal_gen_unpublished)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/suweal_gen_unpublished/)

An (experimental) code generation library for .surql files.

```toml
[dev_dependencies]
suweal_gen = { git = "https://github.com/Remy2701/suweal_gen.git", ref = "v0.2.2" }
```

# Running the generator

**No integration:**
```sh
gleam run -m suweal_gen
```

**offstage integration:**
```sh
gleam run -m suweal_gen -- --offstage
```

