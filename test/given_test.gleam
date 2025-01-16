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

pub fn not_any_test() {
  {
    let is_admin = False
    let is_editor = True

    use <- given.not_any([is_admin, is_editor], return: fn() {
      "At least either Admin or Editor!"
    })

    // …else handle case where user no special role…
    "User has no special role!"
  }
  |> should.equal("User has no special role!")
}

pub fn not_all_test() {
  {
    let is_human = False
    let is_robot = False

    use <- given.not_all([is_human, is_robot], return: fn() {
      "Obsolete model detected."
    })

    // …else handle case where user is neither active nor confirmed…
    "I am a Cylon!"
  }
  |> should.equal("Obsolete model detected.")
}

pub fn when_test() {
  {
    let enabled = fn() { False }

    use <- given.when(enabled, else_return: fn() { "Not an Admin" })

    // …handle case where user is an Admin…
    "Indeed an Admin"
  }
  |> should.equal("Not an Admin")

  {
    let enabled = fn() { False }

    use <- given.when(enabled, return: fn() { "Indeed an Admin" })

    // …handle case where user is not an Admin…
    "Not an Admin"
  }
  |> should.equal("Not an Admin")
}

pub fn when_not_test() {
  {
    let enabled = fn() { False }

    use <- given.when_not(enabled, else_return: fn() { "Indeed an Admin" })

    // …handle case where user is an Admin…
    "Not an Admin"
  }
  |> should.equal("Not an Admin")
  // {
  //   let enabled = fn() { False }

  //   use <- given.when_not(enabled, return: fn() { "Not an Admin" })

  //   // …handle case where user is not an Admin…
  //   "Indeed an Admin"
  // }
  // |> should.equal("Not an Admin")
}

pub fn empty_test() {
  {
    let list = []

    use <- given.empty(list, else_return: fn() { "Non-empty" })

    // …handle empty list here…
    "Empty"
  }
  |> should.equal("Empty")
}

pub fn non_empty_test() {
  {
    let list = []

    use <- given.non_empty(list, else_return: fn() { "Empty" })

    // …handle non-empty list here…
    "Non-empty"
  }
  |> should.equal("Empty")
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
      "All Errors"
    })

    // …handle at least some OKs here…
    "At least some OKs"
  }
}

pub fn all_ok_test() {
  {
    let results = [Ok("Great"), Error("Bad")]

    use _oks <- given.all_ok(in: results, else_return: fn(_oks, _errors) {
      "Some Errors"
    })

    // …handle all OKs here…
    "All OKs"
  }
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
      "Only OKs"
    })

    // …handle at least some Errors here…
    "At least some Errors"
  }
  |> should.equal("At least some Errors")
}

pub fn all_error_test() {
  {
    let results = [Ok("Great"), Error("Bad")]

    use _errors <- given.all_error(in: results, else_return: fn(_oks, _errors) {
      "Only some Errors"
    })

    // …handle all errors here…
    "All Errors"
  }
  |> should.equal("Only some Errors")
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
      else_return: fn(_nones_count) { "All are None" },
    )

    // …handle at least some None values here…
    "At least some are None"
  }
}

pub fn all_some_test() {
  {
    let options = [Some("One"), None]

    use _somes <- given.all_some(
      in: options,
      else_return: fn(_somes, _nones_count) { "Some are None" },
    )

    // …handle all Some values here…
    "All are Some"
  }
}

pub fn none_test() {
  {
    let option = Some(great)

    use <- given.none(in: option, else_return: fn(_some_value) { great })

    // …user handles None here…
    woof
  }
  |> should.equal(great)

  {
    let option = None

    use <- given.none(in: option, else_return: fn(_some_value) { great })

    // …user handles None here…
    "None encountered!"
  }
  |> should.equal("None encountered!")
}

pub fn any_none_test() {
  {
    let options = [Some("One"), None]

    use _somes, _none_count <- given.any_none(
      in: options,
      else_return: fn(_somes) { "All are Somes" },
    )

    // …handle at least some None values here…
    "At least some are None"
  }
}

pub fn all_none_test() {
  {
    let options = [Some("One"), None]

    use <- given.all_none(in: options, else_return: fn(_somes, _nones_count) {
      "Some are Some"
    })

    // …handle all None values here…
    "All are None"
  }
}
