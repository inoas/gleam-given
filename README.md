# Given 👇 for Gleam

[![Package <a href="https://github.com/inoas/gleam-given/releases"><img src="https://img.shields.io/github/release/inoas/gleam-given" alt="GitHub release"></a> Version](https://img.shields.io/hexpm/v/given)](https://hex.pm/packages/given)
[![Erlang-compatible](https://img.shields.io/badge/target-erlang-b83998)](https://www.erlang.org/)
[![JavaScript Compatible](https://img.shields.io/badge/target-javascript-f3e155)](https://en.wikipedia.org/wiki/JavaScript)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/given/)
[![Discord](https://img.shields.io/discord/768594524158427167?label=discord%20chat&amp;color=5865F2)](https://discord.gg/Fm8Pwmy)
[![CI Test](https://github.com/inoas/gleam-given/actions/workflows/test.yml/badge.svg?branch=main&amp;event=push)](https://github.com/inoas/gleam-given/actions/workflows/test.yml)

<br>
<br>

<p align="center">
  <img src="https://raw.githubusercontent.com/inoas/gleam-given/main/given-logo.svg" alt="Gleam Given Logo" style="max-height: 33vh; width: auto; height: auto" width="480" height="480"/>
</p>

<br>

<p align="center">
  <i>
    👇 <a href="https://en.wikipedia.org/wiki/Guard_(computer_science)">guards</a> aka <a href="https://en.wikipedia.org/wiki/Structured_programming#Early_exit">early returns</a> for <b>Bool</b>, <b>Result</b>, <b>Option</b>, and <b>List</b> types in a safe and ergonomic way for Gleam!
  </i>
</p>

## Installation

```sh
gleam add given@5
```

## Usage

All the functions contain labeled `else_return` and `return` callbacks. You will
always specify one, usually `else_return` because that is the common or expected
`otherwise` path. The other will become the happy (or rather expected) path you
trot along as part of the `use` callback *body*.

Also see [Railway Oriented Programming](https://fsharpforfunandprofit.com/rop/).

```gleam
import given

pub fn given_that_example() {
  let user_understood = True

  use <- given.that(user_understood, return: fn() { "💡 Bright!" })
  // …else handle case where user did not understand here…
  "🤯 Woof!"
}

pub fn given_not_example() {
  // Fetch this from some database
  let has_admin_role = True

  use <- given.not(has_admin_role, return: fn() { "✋ Denied!" })
  // …else handle case where they are admin here…
  "👌 Access granted..."
}

pub fn given_any_example() {
  let is_admin = False
  let is_editor = True

  use <- given.any([is_admin, is_editor], return: fn() {
    "At least admin or editor"
  })

  // …else handle case where user has no special role…
  "Got nothing to say 🤷‍♂️"
}

pub fn given_all_example() {
  let is_active = True
  let is_confirmed = False

  use <- given.all([is_active, is_confirmed], return: fn() {
    "Ready, steady, go!"
  })

  // …else handle case where user is not both active and confirmed…
  "Not both active and confirmed"
}

pub fn given_any_not_example() {
  let is_admin = False
  let is_editor = True

  use <- given.any_not([is_admin, is_editor], return: fn() {
    "At least either admin or editor!"
  })

  // …else handle case where user no special role…
  "User has no special role!"
}

pub fn given_all_not_example() {
  let is_android = False
  let is_synthetic = False

  use <- given.all_not([is_android, is_synthetic], return: fn() {
    "Obsolete model detected."
  })

  // …else handle case where the user is neither an android nor a synth…
  "I am a Cylon!"
}

pub fn given_when_example() {
  let enabled = fn() { True }

  use <- given.when(enabled, else_return: fn() { "Not an admin" })

  // …handle case where user is an admin…
  "Indeed an admin"
}

pub fn given_when_not_example() {
  let enabled = fn() { False }

  use <- given.when_not(enabled, else_return: fn() { "Indeed an admin" })

  // …handle case where user is not an Admin…
  "Not an admin"
}

pub fn given_empty_example() {
  let list = []

  use <- given.empty(list, return: fn() { "Empty!" })

  // …handle case where list is non-empty…
  "Non-empty!"
}

pub fn given_not_empty_example() {
  let list = [1]

  use <- given.not_empty(list, return: fn() { "Non-empty!" })

  // …handle case where list is empty…
  "Empty!"
}

pub fn given_ok_example() {
  let a_result = Ok("Hello Joe, again!")

  use ok_value <- given.ok(in: a_result, else_return: fn(_error_value) {
    "Error value"
  })
  // …handle Ok value here…
  ok_value
}

pub fn given_any_ok_example() {
  let results = [Ok("Great"), Error("Bad")]

  use _oks, _errors <- given.any_ok(in: results, else_return: fn(_errors) {
    "All errors"
  })

  // …handle at least some OKs here…
  "At least some Ok values"
}

pub fn given_all_ok_example() {
  let results = [Ok("Great"), Error("Bad")]

  use _oks <- given.all_ok(in: results, else_return: fn(_oks, _errors) {
    "Some errors"
  })

  // …handle all OKs here…
  "All Ok values"
}

pub fn given_error_example() {
  let a_result = Error("Memory exhausted, again!")

  use error_value <- given.error(in: a_result, else_return: fn(_ok_value) {
    "Ok value"
  })
  // …handle Error value here…
  error_value
}

pub fn given_any_error_example() {
  let results = [Ok("Good"), Error("Bad")]

  use _oks, _errors <- given.any_error(in: results, else_return: fn(_oks) {
    "Bad"
  })

  // …handle at least some Errors here…
  "Good"
}

pub fn given_all_error_example() {
  {
    let results = [Ok("Nice"), Error("Meh")]

    use _errors <- given.all_error(in: results, else_return: fn(_oks, _errors) {
      "Meh"
    })

    // …handle all errors here…
    "Nice"
  }
}

import gleam/option.{None, Some}

pub fn given_some_example() {
  let an_option = Some("One more penny")

  use some_value <- given.some(in: an_option, else_return: fn() { "Woof!" })
  // …handle Some value here…
  some_value
}

pub fn given_any_some_example() {
  let options = [Some("One"), None]

  use _somes, _nones_count <- given.any_some(
    in: options,
    else_return: fn(_nones_count) { "Just rocks here, move on..." },
  )

  // …handle at least some None values here…
  "We found some gold!"
}

pub fn given_all_some_example() {
  let options = [Some("One"), None]

  use _somes <- given.all_some(
    in: options,
    else_return: fn(_somes, _nones_count) { "Nothing found..." },
  )

  // …handle all Some values here…
  "There is gold everywhere!"
}

pub fn given_none_example() {
  let an_option = None

  use <- given.none(in: an_option, else_return: fn(_some_value) { "Some value" })
  // …handle None here…
  "None, e.g. still nothing!"
}

pub fn given_any_none_example() {
  let options = [Some("One"), None]

  use _somes, _none_count <- given.any_none(
    in: options,
    else_return: fn(_somes) { "Only Nones here!" },
  )

  // …handle at least some None values here…
  "The system detected Some-things."
}

pub fn given_all_none_example() {
  let options = [Some("One"), None]

  use <- given.all_none(in: options, else_return: fn(_somes, _nones_count) {
    "There is something out there..."
  })

  // …handle all None values here…
  "There is nothing out there..."
}

pub fn main() {
  given_that_example() |> echo
  // "💡 Bright!"

  given_any_example() |> echo
  // "At least admin or editor"

  given_all_example() |> echo
  // "Not both active and confirmed"

  given_not_example() |> echo
  // "👌 Access granted..."

  given_any_not_example() |> echo
  // "User has no special role!"

  given_all_not_example() |> echo
  // "Obsolete model detected."

  given_when_example() |> echo
  // "Indeed an admin"

  given_when_not_example() |> echo
  // "Not an admin"

  given_empty_example() |> echo
  // "Empty!"

  given_not_empty_example() |> echo
  // "Non-empty!"

  given_ok_example() |> echo
  // "Hello Joe, again!"

  given_any_ok_example() |> echo
  // "At least some Ok values"

  given_all_ok_example() |> echo
  // "Some Errors"

  given_error_example() |> echo
  // "Memory exhausted, again!"

  given_any_error_example() |> echo
  // "Good"

  given_all_error_example() |> echo
  // "Meh"

  given_some_example() |> echo
  // "One More Penny"

  given_any_some_example() |> echo
  // "We found some Gold!"

  given_all_some_example() |> echo
  // "Nothing found..."

  given_none_example() |> echo
  // "None, e.g. Still nothing"

  given_any_none_example() |> echo
  // "The system detected Some-things."

  given_all_none_example() |> echo
  // "There is something out there..."
}
```

### Run usage examples

```sh
git clone https://github.com/inoas/gleam-given.git
bin/run-examples
```

Further documentation can be found at <https://hexdocs.pm/given>.

## Similar projects

See [gond](https://github.com/inoas/gleam-gond) for multi-branch conditional expression similar to `if-else`, `if`-`else-if`-`else` or `cond` for Gleam.

## Tags

- `guard`
- `guard expression`
- `guard clause`
- `guard code`
- `guard statement`
- `early return`
- `early exit`
- `bool.guard`
- `railway oriented programming`
- `Either Monad`
- `Try Monad`

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```
