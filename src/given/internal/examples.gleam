import given.{not as not_given, that as given}

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

pub fn given_ok_example() {
  let a_result = Ok("Hello Joe, again!")

  use ok_value <- given.ok(in: a_result, else_return: fn(_error_value) {
    "Error value"
  })
  // …handle Ok value here…
  ok_value
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

pub fn given_some_example() {
  let an_option = Some("One More Penny")

  use some_value <- given.some(in: an_option, else_return: fn() { "Woof!" })
  // …handle Some value here…
  some_value
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
  given_ok_example() |> io.debug
  // "Hello Joe, again!"
  given_error_example() |> io.debug
  // "Memory exhausted, again!"
  given_some_example() |> io.debug
  // "One More Penny"
  given_none_example() |> io.debug
  // "None, e.g. Still nothing"
}
