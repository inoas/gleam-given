# 👇Given for Gleam

[![Package <a href="https://github.com/inoas/gleam-given/releases"><img src="https://img.shields.io/github/release/inoas/gleam-given" alt="GitHub release"></a> Version](https://img.shields.io/hexpm/v/given)](https://hex.pm/packages/given)
[![Erlang-compatible](https://img.shields.io/badge/target-erlang-b83998)](https://www.erlang.org/)
[![JavaScript Compatible](https://img.shields.io/badge/target-javascript-f3e155)](https://en.wikipedia.org/wiki/JavaScript)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/given/)
[![Discord](https://img.shields.io/discord/768594524158427167?label=discord%20chat&amp;color=5865F2)](https://discord.gg/Fm8Pwmy)
[![CI Test](https://github.com/inoas/gleam-given/actions/workflows/test.yml/badge.svg?branch=main&amp;event=push)](https://github.com/inoas/gleam-given/actions/workflows/test.yml)

<br>
<br>

<p align="center">
  <img src="https://raw.githubusercontent.com/inoas/gleam-given/main/given-logo.png" alt="Given Logo" style="max-height: 33vh; width: auto; height: auto" width="480" height="480"/>
</p>

<br>

<p align="center">
  <i>
    👇Given is a library written in Gleam to make it safe and easy to early return.
  </i>
</p>

<br>
<br>


## Installation

```sh
gleam add given@1
```

## Usage

```gleam
import given.{given, not_given}
import gleam/io
import gleam/option.{None, Some}

pub fn main() {
  given_example()
  not_given_example()
  given_ok_in_example()
  given_error_in_example()
  given_some_in_example()
  given_none_in_example()
}

pub fn given_example() {
  {
    let user_understood = False
    use <- given(user_understood, return: fn() { "💡 Bright!" })
    // …else user handles case where user did not understand here…
    "🤯 Woof!"
  }
  |> io.debug()
  // "🤯 Woof!"

  Nil
}

pub fn not_given_example() {
  {
    let has_admin_role = True
    // Fetch this from some database
    use <- not_given(has_admin_role, return: fn() { "✋ Denied!" })
    // …else user handles case where they are admin here…
    "👌 Access granted..."
  }
  |> io.debug()
  // "👌 Access granted..."

  Nil
}

pub fn given_ok_in_example() {
  {
    let result = Ok("Hello Joe!")
    use ok_value <- given.ok_in(result, else_return: fn(error_value) {
      error_value
    })
    // …user handles Ok value here…
    ok_value
  }
  |> io.debug()
  // "Hello Joe!"

  Nil
}

pub fn given_error_in_example() {
  {
    let result = Error("Memory exceeded!")
    use error_value <- given.error_in(result, else_return: fn(ok_value) {
      ok_value
    })
    // …user handles Error value here…
    error_value
  }
  |> io.debug()
  // "Memory exceeded!"

  Nil
}

pub fn given_some_in_example() {
  {
    let option = Some("One Penny")
    use some_value <- given.some_in(option, else_return: fn() { "Woof!" })
    // …user handles Some value here…
    some_value
  }
  |> io.debug()
  // "One Penny"

  Nil
}

pub fn given_none_in_example() {
  {
    let option = None
    use <- given.none_in(option, else_return: fn(some_value) { some_value })
    // …user handles None here…
    "Nothing at all"
  }
  |> io.debug()
  // "Nothing at all"

  Nil
}
```

Further documentation can be found at <https://hexdocs.pm/given>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```
