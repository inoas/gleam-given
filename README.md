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
gleam add given
```

## Usage

```gleam
import given.{given, not_given}

pub fn given_example() {
  let user_understood = False

  use <- given(user_understood, return: fn() { "💡 Bright!" })
  // …else handle case where user did not understand here…
  "🤯 Woof!"
}

pub fn not_given_example() {
  // Fetch this from some database
  let has_admin_role = True

  use <- not_given(has_admin_role, return: fn() { "✋ Denied!" })
  // …else handle case where they are admin here…
  "👌 Access granted..."
}

pub fn given_ok_in_example() {
  let a_result = Ok("Hello Joe!")

  use ok_value <- given.ok_in(result: a_result, else_return: fn(_error_value) {
    "Error value"
  })
  // …handle Ok value here…
  ok_value
}

pub fn given_ok_example() {
  let a_result = Ok("Hello Joe, again!")

  use ok_value <- given.ok(in: a_result, else_return: fn(_error_value) {
    "Error value"
  })
  // …handle Ok value here…
  ok_value
}

pub fn given_error_in_example() {
  let a_result = Error("Memory exhausted!")

  use error_value <- given.error_in(a_result, else_return: fn(_ok_value) {
    "Ok value"
  })
  // …handle Error value here…
  error_value
}

pub fn given_error_example() {
  let a_result = Error("Memory exhausted, again!")

  use error_value <- given.error(in: a_result, else_return: fn(_ok_value) {
    "Ok value"
  })
  // …handle Error value here…
  error_value
}

import gleam/option.{None, Some}

pub fn given_some_in_example() {
  let an_option = Some("One Penny")

  use some_value <- given.some_in(an_option, else_return: fn() { "Woof!" })
  // …handle Some value here…
  some_value
}

pub fn given_some_example() {
  let an_option = Some("One More Penny")

  use some_value <- given.some(in: an_option, else_return: fn() { "Woof!" })
  // …handle Some value here…
  some_value
}

pub fn given_none_in_example() {
  let an_option = None

  use <- given.none_in(an_option, else_return: fn(_some_value) { "Some value" })
  // …handle None here…
  "None, e.g. Nothing at all"
}

pub fn given_none_example() {
  let an_option = None

  use <- given.none(in: an_option, else_return: fn(_some_value) { "Some value" })
  // …handle None here…
  "None, e.g. Still nothing!"
}

import gleam/io

pub fn main() {
  given_example() |> io.debug
  // "🤯 Woof!"
  not_given_example() |> io.debug
  // "👌 Access granted..."
  given_ok_in_example() |> io.debug
  // "Hello Joe!"
  given_error_in_example() |> io.debug
  // "Memory exhausted!"
  given_some_in_example() |> io.debug
  // "One Penny"
  given_none_in_example() |> io.debug
  // "None, e.g. Nothing at all"
  given_ok_example() |> io.debug
  // "Hello Joe, again!"
  given_error_example() |> io.debug
  // "Memory exhausted, again!"
  given_some_example() |> io.debug
  // "One More Penny"
  given_none_example() |> io.debug
  // "None, e.g. Still nothing"
}
```

### Run usage examples

```sh
gleam run --module given/internal/usage_examples
```

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```
