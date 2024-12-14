import given.{
  given, given_error_in, given_none_in, given_ok_in, given_some_in, not_given,
}
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
    use ok_value <- given_ok_in(result, else_return: fn(error_value) {
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
    use error_value <- given_error_in(result, else_return: fn(ok_value) {
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
    use some_value <- given_some_in(option, else_return: fn() { "Woof!" })
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
    use <- given_none_in(option, else_return: fn(some_value) { some_value })
    // …user handles None here…
    "Nothing at all"
  }
  |> io.debug()
  // "Nothing at all"

  Nil
}
