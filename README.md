# Suweal Generator

[![Package Version](https://img.shields.io/hexpm/v/suweal_gen)](https://hex.pm/packages/suweal_gen)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/suweal_gen/)

An (experimental) code generation library for .surql files.

```toml
[dev_dependencies]
suweal_gen = ">= 0.3.1 and < 1.0.0"
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