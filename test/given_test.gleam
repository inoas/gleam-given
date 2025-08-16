import given
import gleam/option.{None, Some}
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

const great = "Great! ✨"

const woof = "Woof! 🐶"

pub fn that_test() {
  {
    let user_understood = False

    use <- given.that(user_understood, return: fn() { great })

    // …else user handles case where user did not understand here…
    woof
  }
  |> should.equal(woof)

  {
    let user_understood = True

    use <- given.that(user_understood, return: fn() { great })

    // …else user handles case where user did not understand here…
    woof
  }
  |> should.equal(great)
}

pub fn any_test() {
  {
    let is_admin = False
    let is_editor = True

    use <- given.any([is_admin, is_editor], return: fn() { great })

    // …else handle case where user has no special role…
    woof
  }
  |> should.equal(great)
}

pub fn all_test() {
  {
    let is_active = True
    let is_confirmed = True

    use <- given.all([is_active, is_confirmed], return: fn() { great })

    // …else handle case where user is not both active and confirmed…
    woof
  }
  |> should.equal(great)
}

pub fn not_test() {
  {
    let user_understood = False

    use <- given.not(user_understood, return: fn() { great })

    // …else user handles case where user understood here…
    woof
  }
  |> should.equal(great)

  {
    let user_understood = True

    use <- given.not(user_understood, return: fn() { great })

    // …else user handles case where user understood here…
    woof
  }
  |> should.equal(woof)
}

pub fn any_not_test() {
  {
    let is_admin = False
    let is_editor = True

    use <- given.any_not([is_admin, is_editor], return: fn() { great })

    // …else handle case where user no special role…
    woof
  }
  |> should.equal(woof)
}

@deprecated("Remove test in 6.0")
pub fn not_any_test() {
  {
    let is_admin = False
    let is_editor = True

    use <- given.not_any([is_admin, is_editor], return: fn() { great })

    // …else handle case where user no special role…
    woof
  }
  |> should.equal(woof)
}

pub fn all_not_test() {
  {
    let is_human = False
    let is_robot = False

    use <- given.all_not([is_human, is_robot], return: fn() { great })

    // …else handle case where user is neither active nor confirmed…
    woof
  }
  |> should.equal(great)
}

@deprecated("Remove test in 6.0")
pub fn not_all_test() {
  {
    let is_human = False
    let is_robot = False

    use <- given.not_all([is_human, is_robot], return: fn() { great })

    // …else handle case where user is neither active nor confirmed…
    woof
  }
  |> should.equal(great)
}

pub fn when_test() {
  {
    let enabled = fn() { False }

    use <- given.when(enabled, return: fn() { great })

    // …handle case where user is not an Admin…
    woof
  }
  |> should.equal(woof)

  {
    let enabled = fn() { False }

    use <- given.when(enabled, else_return: fn() { great })

    // …handle case where user is an Admin…
    woof
  }
  |> should.equal(great)
}

pub fn when_not_test() {
  {
    let enabled = fn() { False }

    use <- given.when_not(enabled, else_return: fn() { great })

    // …handle case where user is an Admin…
    woof
  }
  |> should.equal(woof)

  {
    let enabled = fn() { False }

    use <- given.when_not(enabled, return: fn() { great })

    // …handle case where user is not an Admin…
    woof
  }
  |> should.equal(great)
}

pub fn empty_test() {
  {
    let list = []

    use <- given.empty(list, else_return: fn() { woof })

    // …handle empty list here…
    great
  }
  |> should.equal(great)
}

pub fn not_empty_test() {
  {
    let list = []

    use <- given.not_empty(list, else_return: fn() { woof })

    // …handle non-empty list here…
    great
  }
  |> should.equal(woof)
}

pub fn non_empty_test() {
  {
    let list = []

    use <- given.non_empty(list, else_return: fn() { woof })

    // …handle non-empty list here…
    great
  }
  |> should.equal(woof)
}

pub fn ok_test() {
  {
    let result = Ok(great)
    use ok_value <- given.ok(in: result, else_return: fn(error_value) {
      error_value
    })

    // …user handles Ok value here…
    ok_value
  }
  |> should.equal(great)

  {
    let result = Error(woof)
    use ok_value <- given.ok(in: result, else_return: fn(error_value) {
      error_value
    })

    // …user handles Ok value here…
    ok_value
  }
  |> should.equal(woof)
}

pub fn any_ok_test() {
  {
    let results = [Ok("Great"), Error("Bad")]

    use _oks, _errors <- given.any_ok(in: results, else_return: fn(_errors) {
      woof
    })

    // …handle at least some OKs here…
    great
  }
  |> should.equal(great)
}

pub fn all_ok_test() {
  {
    let results = [Ok("Great"), Error("Bad")]

    use _oks <- given.all_ok(in: results, else_return: fn(_oks, _errors) {
      woof
    })

    // …handle all OKs here…
    great
  }
  |> should.equal(woof)
}

pub fn error_test() {
  {
    let result = Error(woof)

    use _error_value <- given.error(in: result, else_return: fn(_ok_value) {
      great
    })

    // …user handles Error value here…
    woof
  }
  |> should.equal(woof)

  {
    let result = Ok(great)

    use _error_value <- given.error(in: result, else_return: fn(_ok_value) {
      great
    })

    // …user handles Error value here…
    woof
  }
  |> should.equal(great)
}

pub fn any_error_test() {
  {
    let results = [Ok("Great"), Error("Bad")]

    use _oks, _errors <- given.any_error(in: results, else_return: fn(_oks) {
      woof
    })

    // …handle at least some Errors here…
    great
  }
  |> should.equal(great)
}

pub fn all_error_test() {
  {
    let results = [Ok("Great"), Error("Bad")]

    use _errors <- given.all_error(in: results, else_return: fn(_oks, _errors) {
      woof
    })

    // …handle all errors here…
    great
  }
  |> should.equal(woof)
}

pub fn some_test() {
  {
    let option = Some(great)

    use _some_value <- given.some(in: option, else_return: fn() { woof })

    // …user handles Some value here…
    great
  }
  |> should.equal(great)

  {
    let option = Some(great)

    use _some_value <- given.some(in: option, else_return: fn() { woof })

    // …user handles Some value here…
    great
  }
  |> should.equal(great)
}

pub fn any_some_test() {
  {
    let options = [Some("One"), None]

    use _somes, _nones_count <- given.any_some(
      in: options,
      else_return: fn(_nones_count) { woof },
    )

    // …handle at least some None values here…
    great
  }
  |> should.equal(great)
}

pub fn all_some_test() {
  {
    let options = [Some("One"), None]

    use _somes <- given.all_some(
      in: options,
      else_return: fn(_somes, _nones_count) { woof },
    )

    // …handle all Some values here…
    great
  }
  |> should.equal(woof)
}

pub fn none_test() {
  {
    let option = Some(great)

    use <- given.none(in: option, else_return: fn(_some_value) { woof })

    // …user handles None here…
    great
  }
  |> should.equal(woof)

  {
    let option = None

    use <- given.none(in: option, else_return: fn(_some_value) { woof })

    // …user handles None here…
    great
  }
  |> should.equal(great)
}

pub fn any_none_test() {
  {
    let options = [Some("One"), None]

    use _somes, _none_count <- given.any_none(
      in: options,
      else_return: fn(_somes) { woof },
    )

    // …handle at least some None values here…
    great
  }
  |> should.equal(great)
}

pub fn all_none_test() {
  {
    let options = [Some("One"), None]

    use <- given.all_none(in: options, else_return: fn(_somes, _nones_count) {
      woof
    })

    // …handle all None values here…
    great
  }
  |> should.equal(woof)
}
