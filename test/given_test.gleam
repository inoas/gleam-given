import given.{given, not_given}
import gleam/option.{None, Some}
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

const great = "Great!"

const woof = "Woof!"

pub fn given_test() {
  {
    let user_understood = False
    use <- given(user_understood, return: fn() { great })
    // …else user handles case where user did not understand here…
    woof
  }
  |> should.equal(woof)

  {
    let user_understood = True
    use <- given(user_understood, return: fn() { great })
    // …else user handles case where user did not understand here…
    woof
  }
  |> should.equal(great)
}

pub fn not_given_test() {
  {
    let user_understood = False
    use <- not_given(user_understood, return: fn() { great })
    // …else user handles case where user understood here…
    woof
  }
  |> should.equal(great)

  {
    let user_understood = True
    use <- not_given(user_understood, return: fn() { great })
    // …else user handles case where user understood here…
    woof
  }
  |> should.equal(woof)
}

pub fn given_ok_in_test() {
  {
    let result = Ok(great)
    use ok_value <- given.ok_in(result, else_return: fn(error_value) {
      error_value
    })
    // …user handles Ok value here…
    ok_value
  }
  |> should.equal(great)

  {
    let result = Error(woof)
    use ok_value <- given.ok_in(result, else_return: fn(error_value) {
      error_value
    })
    // …user handles Ok value here…
    ok_value
  }
  |> should.equal(woof)
}

pub fn given_error_in_test() {
  {
    let result = Error(woof)
    use error_value <- given.error_in(result, else_return: fn(ok_value) {
      ok_value
    })
    // …user handles Error value here…
    error_value
  }
  |> should.equal(woof)

  {
    let result = Ok(great)
    use error_value <- given.error_in(result, else_return: fn(ok_value) {
      ok_value
    })
    // …user handles Error value here…
    error_value
  }
  |> should.equal(great)
}

pub fn given_some_in_test() {
  {
    let option = Some(great)
    use some_value <- given.some_in(option, else_return: fn() { woof })
    // …user handles Some value here…
    some_value
  }

  {
    let option = Some(great)
    use some_value <- given.some_in(option, else_return: fn() { woof })
    // …user handles Some value here…
    some_value
  }
}

pub fn given_none_in_test() {
  {
    let option = Some(great)
    use <- given.none_in(option, else_return: fn(some_value) { some_value })
    // …user handles None here…
    woof
  }
  {
    let option = None
    use <- given.none_in(option, else_return: fn(some_value) { some_value })
    // …user handles None here…
    woof
  }
}
