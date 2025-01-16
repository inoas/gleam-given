import given
import gleam/option.{None, Some}
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

const ok_great = "Great! ✨"

const error_woof = "Woof! 🐶"

pub fn given_test() {
  {
    let user_understood = False
    use <- given.that(user_understood, return: fn() { ok_great })
    // …else user handles case where user did not understand here…
    error_woof
  }
  |> should.equal(error_woof)

  {
    let user_understood = True
    use <- given.that(user_understood, return: fn() { ok_great })
    // …else user handles case where user did not understand here…
    error_woof
  }
  |> should.equal(ok_great)
}

pub fn not_given_test() {
  {
    let user_understood = False
    use <- given.not(user_understood, return: fn() { ok_great })
    // …else user handles case where user understood here…
    error_woof
  }
  |> should.equal(ok_great)

  {
    let user_understood = True
    use <- given.not(user_understood, return: fn() { ok_great })
    // …else user handles case where user understood here…
    error_woof
  }
  |> should.equal(error_woof)
}

pub fn given_ok_test() {
  {
    let result = Ok(ok_great)
    use ok_value <- given.ok(in: result, else_return: fn(error_value) {
      error_value
    })
    // …user handles Ok value here…
    ok_value
  }
  |> should.equal(ok_great)

  {
    let result = Error(error_woof)
    use ok_value <- given.ok(in: result, else_return: fn(error_value) {
      error_value
    })
    // …user handles Ok value here…
    ok_value
  }
  |> should.equal(error_woof)
}

pub fn given_ok_unusual_usage_test() {
  {
    let result = Ok(ok_great)
    use _error_value <- given.ok(in: result, return: fn(_ok_value) { ok_great })
    // …user handles Error value here…
    error_woof
  }
  |> should.equal(ok_great)

  {
    let result = Error(error_woof)
    use _error_value <- given.ok(in: result, return: fn(_ok_value) { ok_great })
    // …user handles Error value here…
    error_woof
  }
  |> should.equal(error_woof)
}

pub fn given_error_test() {
  {
    let result = Error(error_woof)
    use _error_value <- given.error(in: result, else_return: fn(_ok_value) {
      ok_great
    })
    // …user handles Error value here…
    error_woof
  }
  |> should.equal(error_woof)

  {
    let result = Ok(ok_great)
    use _error_value <- given.error(in: result, else_return: fn(_ok_value) {
      ok_great
    })
    // …user handles Error value here…
    error_woof
  }
  |> should.equal(ok_great)
}

pub fn given_some_test() {
  {
    let option = Some(ok_great)
    use _some_value <- given.some(in: option, else_return: fn() { error_woof })
    // …user handles Some value here…
    ok_great
  }
  |> should.equal(ok_great)

  {
    let option = Some(ok_great)
    use _some_value <- given.some(in: option, else_return: fn() { error_woof })
    // …user handles Some value here…
    ok_great
  }
  |> should.equal(ok_great)
}

pub fn given_none_test() {
  {
    let option = Some(ok_great)
    use <- given.none(in: option, else_return: fn(_some_value) { ok_great })
    // …user handles None here…
    error_woof
  }
  |> should.equal(ok_great)

  {
    let option = None
    use <- given.none(in: option, else_return: fn(_some_value) { ok_great })
    // …user handles None here…
    "None encountered!"
  }
  |> should.equal("None encountered!")
}

pub fn given_none_unusual_test() {
  {
    let option = Some(ok_great)
    use some_value <- given.none(in: option, return: fn() {
      "None encountered!"
    })
    // …user handles Some value here…
    some_value
  }
  |> should.equal(ok_great)

  {
    let option = None
    use else_some_value <- given.none(in: option, return: fn() {
      "None encountered!"
    })
    // …user handles Some value here…
    else_some_value
  }
  |> should.equal("None encountered!")
}
