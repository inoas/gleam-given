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

  use <- given.that(user_understood, else_return: fn() { "Woof!" })

  "💡 Bright!"
}

pub fn given_not_example() {
  let has_admin_role = False

  use <- given.not(has_admin_role, else_return: fn() { "Access granted!" })

  "✋ Denied!"
}

pub fn given_any_example() {
  let is_admin = False
  let is_editor = True

  use <- given.any([is_admin, is_editor], else_return: fn() { "Cannot pass!" })

  "🎵 Snap - I've got the power!"
}

pub fn given_all_example() {
  let is_active = True
  let is_confirmed = True

  use <- given.all([is_active, is_confirmed], else_return: fn() { "Stop!" })

  "🏇 Ready, steady, go!"
}

pub fn given_any_not_example() {
  let got_veggies = True
  let got_spices = False

  use <- given.any_not([got_veggies, got_spices], else_return: fn() {
    "Preparing a soup!"
  })

  "😭 Ingredient missing..."
}

pub fn given_all_not_example() {
  let is_android = False
  let is_synthetic = False

  use <- given.all_not([is_android, is_synthetic], else_return: fn() {
    "I am a Cylon!"
  })

  "🪦 Obsolete model detected."
}

pub fn given_when_example() {
  let enabled_in_db = fn() { True }

  use <- given.when(enabled_in_db, else_return: fn() { "User disabled!" })

  "✅ User enabled"
}

pub fn given_when_not_example() {
  let enabled_in_db = fn() { False }

  use <- given.when_not(enabled_in_db, else_return: fn() { "User enabled!" })

  "❌ User disabled"
}

pub fn given_empty_example() {
  let list = []

  use <- given.empty(list, else_return: fn() {
    "Full as if you ate two large vegan 🍔!"
  })

  "🛸 Empty like vast space!"
}

pub fn given_non_empty_example() {
  let list = [1]

  use <- given.non_empty(list, else_return: fn() { "Empty like vast space! 🛸" })

  "🍔 Full as if you ate two large vegan!"
}

pub fn given_ok_example() {
  let result = Ok("📞 Hello Joe, again!")

  use val <- given.ok(in: result, else_return: fn(_error) {
    "Joe is unreachable, now 💔."
  })

  val
}

pub fn given_any_ok_example() {
  let results = [Ok("Happy"), Error("Sad")]

  use _oks, _errors <- given.any_ok(in: results, else_return: fn(_errors) {
    "All Error values!"
  })

  "👍 At least one Ok values!"
}

pub fn given_all_ok_example() {
  let results = [Ok("Happy"), Ok("Glad")]

  use _oks <- given.all_ok(in: results, else_return: fn(_oks, _errors) {
    "At least one Error value!"
  })

  "👍👍 All Ok values"
}

pub fn given_error_example() {
  let result = Error("💻 Memory exhausted!")

  use val <- given.error(in: result, else_return: fn(_ok) {
    "Allocating memory..."
  })

  val
}

pub fn given_any_error_example() {
  let results = [Ok("Happy"), Error("Sad")]

  use _oks, _errors <- given.any_error(in: results, else_return: fn(_oks) {
    "No Errors"
  })

  "🚧 At least one Error occured!"
}

pub fn given_all_error_example() {
  {
    let results = [Error("Sad"), Error("Lonely")]

    use _errors <- given.all_error(in: results, else_return: fn(_oks, _errors) {
      "Life is good!"
    })

    "☕ Take care and learn to love yourself!"
  }
}

import gleam/option.{None, Some}

pub fn given_some_example() {
  let option = Some("🪙 One more penny")

  use val <- given.some(in: option, else_return: fn() { "Nothing to spare!" })

  val
}

pub fn given_any_some_example() {
  let options = [Some("One"), None]

  use _somes, _nones_count <- given.any_some(
    in: options,
    else_return: fn(_nones_count) { "Nothing at all." },
  )

  "😅 At least one Some!"
}

pub fn given_all_some_example() {
  let options = [Some("Treasure Chest"), Some("Nugget")]

  use _somes <- given.all_some(
    in: options,
    else_return: fn(_somes, _nones_count) { "Nothing at all" },
  )

  "🏅 There is gold everywhere!"
}

pub fn given_none_example() {
  let option = None

  use <- given.none(in: option, else_return: fn(_some_value) {
    "There is someone sleeping!"
  })

  "🛏, aka None is in this bed!"
}

pub fn given_any_none_example() {
  let options = [Some("One"), None]

  use _somes, _none_count <- given.any_none(
    in: options,
    else_return: fn(_somes) { "Only Somes here!" },
  )

  "🕳️, aka None, detected in the system at least once."
}

pub fn given_all_none_example() {
  let options = [None, None]

  use <- given.all_none(in: options, else_return: fn(_somes, _nones_count) {
    "Someone tipped me :)!"
  })

  "🫙 There is nothing in the jar..."
}

pub fn main() {
  given_that_example() |> echo
  given_any_example() |> echo
  given_all_example() |> echo
  given_not_example() |> echo
  given_any_not_example() |> echo
  given_all_not_example() |> echo
  given_when_example() |> echo
  given_when_not_example() |> echo
  given_empty_example() |> echo
  given_non_empty_example() |> echo
  given_ok_example() |> echo
  given_any_ok_example() |> echo
  given_all_ok_example() |> echo
  given_error_example() |> echo
  given_any_error_example() |> echo
  given_all_error_example() |> echo
  given_some_example() |> echo
  given_any_some_example() |> echo
  given_all_some_example() |> echo
  given_none_example() |> echo
  given_any_none_example() |> echo
  given_all_none_example() |> echo
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
