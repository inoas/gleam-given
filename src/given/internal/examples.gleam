import given.{given, not_given}
import gleam/io
import gleam/option.{None, Some}

pub fn main() {
  given_example() |> io.debug()
  // "🤯 Woof!"

  not_given_example() |> io.debug()
  // "👌 Access granted..."

  given_ok_in_example() |> io.debug()
  // "Hello Joe!"

  given_error_in_example() |> io.debug()
  // "Memory exhausted!"

  given_some_in_example() |> io.debug()
  // "One Penny"

  given_none_in_example() |> io.debug()
  // "Nothing at all"
}

pub fn given_example() {
  let user_understood = False
  use <- given(user_understood, return: fn() { "💡 Bright!" })

  // …else handle case where user did not understand here…

  "🤯 Woof!"
}

pub fn not_given_example() {
  let has_admin_role = True
  // Fetch this from some database
  use <- not_given(has_admin_role, return: fn() { "✋ Denied!" })

  // …else handle case where they are admin here…

  "👌 Access granted..."
}

pub fn given_ok_in_example() {
  let a_result = Ok("Hello Joe!")
  use ok_value <- given.ok_in(a_result, else_return: fn(error_value) {
    error_value
  })

  // …handle Ok value here…

  ok_value
}

pub fn given_error_in_example() {
  let a_result = Error("Memory exhausted!")
  use error_value <- given.error_in(a_result, else_return: fn(ok_value) {
    ok_value
  })
  // …handle Error value here…

  error_value
}

pub fn given_some_in_example() {
  let an_option = Some("One Penny")
  use some_value <- given.some_in(an_option, else_return: fn() { "Woof!" })

  // …handle Some value here…

  some_value
}

pub fn given_none_in_example() {
  let an_option = None
  use <- given.none_in(an_option, else_return: fn(some_value) { some_value })

  // …handle None here…

  "Nothing at all"
}
