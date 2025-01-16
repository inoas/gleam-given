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

pub fn given_not_any_example() {
  let is_admin = False
  let is_editor = True

  use <- given.not_any([is_admin, is_editor], return: fn() {
    "At least either Admin or Editor!"
  })

  // …else handle case where user no special role…
  "User has no special role!"
}

pub fn given_not_all_example() {
  let is_human = False
  let is_robot = False

  use <- given.not_all([is_human, is_robot], return: fn() {
    "Obsolete model detected."
  })

  // …else handle case where user is neither active nor confirmed…
  "I am a Cylon!"
}

pub fn given_when_example() {
  let enabled = fn() { True }

  use <- given.when(enabled, else_return: fn() { "Not an Admin" })

  // …handle case where user is an Admin…
  "Indeed an Admin"
}

pub fn given_when_not_example() {
  let enabled = fn() { False }

  use <- given.when_not(enabled, else_return: fn() { "Indeed an Admin" })

  // …handle case where user is not an Admin…
  "Not an Admin"
}

pub fn given_empty_example() {
  let list = []

  use <- given.empty(list, return: fn() { "Empty!" })

  // …handle case where user is non-empty…
  "Non-empty!"
}

pub fn given_non_empty_example() {
  let list = [1]

  use <- given.non_empty(list, return: fn() { "Non-empty!" })

  // …handle case where user is empty…
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
    "All Errors"
  })

  // …handle at least some OKs here…
  "At least some OKs"
}

pub fn given_all_ok_example() {
  let results = [Ok("Great"), Error("Bad")]

  use _oks <- given.all_ok(in: results, else_return: fn(_oks, _errors) {
    "Some Errors"
  })

  // …handle all OKs here…
  "All OKs"
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
  let an_option = Some("One More Penny")

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
  "We found some Gold!"
}

pub fn given_all_some_example() {
  let options = [Some("One"), None]

  use _somes <- given.all_some(
    in: options,
    else_return: fn(_somes, _nones_count) { "Nothing found..." },
  )

  // …handle all Some values here…
  "There is Gold everywhere!"
}

pub fn given_none_example() {
  let an_option = None

  use <- given.none(in: an_option, else_return: fn(_some_value) { "Some value" })
  // …handle None here…
  "None, e.g. Still nothing!"
}

pub fn given_any_none_example() {
  let options = [Some("One"), None]

  use _somes, _none_count <- given.any_none(
    in: options,
    else_return: fn(_somes) { "Only Nones Here!" },
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

import gleam/io

pub fn main() {
  given_that_example() |> io.debug
  // "💡 Bright!"

  given_any_example() |> io.debug
  // "At least admin or editor"

  given_all_example() |> io.debug
  // "Not both active and confirmed"

  given_not_example() |> io.debug
  // "👌 Access granted..."

  given_not_any_example() |> io.debug
  // "User has no special role!"

  given_not_all_example() |> io.debug
  // "Obsolete model detected."

  given_when_example() |> io.debug
  // "Indeed an Admin"

  given_when_not_example() |> io.debug
  // "Not an Admin"

  given_empty_example() |> io.debug
  // "Empty!"

  given_non_empty_example() |> io.debug
  // "Non-empty!"

  given_ok_example() |> io.debug
  // "Hello Joe, again!"

  given_any_ok_example() |> io.debug
  // "At least some OKs"

  given_all_ok_example() |> io.debug
  // "Some Errors"

  given_error_example() |> io.debug
  // "Memory exhausted, again!"

  given_any_error_example() |> io.debug
  // "Good"

  given_all_error_example() |> io.debug
  // "Meh"

  given_some_example() |> io.debug
  // "One More Penny"

  given_any_some_example() |> io.debug
  // "We found some Gold!"

  given_all_some_example() |> io.debug
  // "Nothing found..."

  given_none_example() |> io.debug
  // "None, e.g. Still nothing"

  given_any_none_example() |> io.debug
  // "The system detected Some-things."

  given_all_none_example() |> io.debug
  // "There is something out there..."
}
