# Given for Gleam

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

```sh
gleam add given@1
```

```gleam
import given.{given, not_given, given_ok_in, given_error_in, given_some_in, given_none_in}
import gleam/io

pub fn main() {
  given_examples()
  not_given_examples()
  given_ok_in_examples()
  given_error_in_examples()
  given_some_in_examples()
  given_none_in_examples()
}

pub fn given_examples() {
  {
    let user_understood = False
    use <- given(user_understood, return: fn() { great })
    // …else user handles case where user did not understand here…
    woof
  }
  |> io.debug()

  {
    let user_understood = True
    use <- given(user_understood, return: fn() { great })
    // …else user handles case where user did not understand here…
    woof
  }
  |> io.debug()
}

pub fn not_given_examples() {
  {
    let user_understood = False
    use <- not_given(user_understood, return: fn() { great })
    // …else user handles case where user understood here…
    woof
  }
  |> io.debug()

  {
    let user_understood = True
    use <- not_given(user_understood, return: fn() { great })
    // …else user handles case where user understood here…
    woof
  }
  |> io.debug()
}

pub fn given_ok_in_examples() {
  {
    let result = Ok(great)
    use ok_value <- given_ok_in(result, else_return: fn(error_value) {
      error_value
    })
    // …user handles Ok value here…
    ok_value
  }
  |> io.debug()

  {
    let result = Error(woof)
    use ok_value <- given_ok_in(result, else_return: fn(error_value) {
      error_value
    })
    // …user handles Ok value here…
    ok_value
  }
  |> io.debug()
}

pub fn given_error_in_examples() {
  {
    let result = Error(woof)
    use error_value <- given_error_in(result, else_return: fn(ok_value) {
      ok_value
    })
    // …user handles Error value here…
    error_value
  }
  |> io.debug()

  {
    let result = Ok(great)
    use error_value <- given_error_in(result, else_return: fn(ok_value) {
      ok_value
    })
    // …user handles Error value here…
    error_value
  }
  |> io.debug()
}

pub fn given_some_in_examples() {
  {
    let option = Some(great)
    use some_value <- given_some_in(option, else_return: fn() { woof })
    // …user handles Some value here…
    some_value
  }

  {
    let option = Some(great)
    use some_value <- given_some_in(option, else_return: fn() { woof })
    // …user handles Some value here…
    some_value
  }
}

pub fn given_none_in_examples() {
  {
    let option = Some(great)
    use <- given_none_in(option, else_return: fn(some_value) { some_value })
    // …user handles None here…
    woof
  }
  {
    let option = None
    use <- given_none_in(option, else_return: fn(some_value) { some_value })
    // …user handles None here…
    woof
  }
}
```

Further documentation can be found at <https://hexdocs.pm/given>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```
