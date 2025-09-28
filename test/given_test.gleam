import given
import gleam/option.{None, Some}
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

const great = "Great! ✨"

const woof = "Woof! 🐶"

pub fn that_test() {
  {
    let user_understood = False

    use <- given.that(user_understood, return: fn() { great })

    woof
  }
  |> should.equal(woof)

  {
    let user_understood = True

    use <- given.that(user_understood, return: fn() { great })

    woof
  }
  |> should.equal(great)
}

pub fn any_test() {
  {
    let is_admin = False
    let is_editor = True

    use <- given.any([is_admin, is_editor], return: fn() { great })

    woof
  }
  |> should.equal(great)
}

pub fn all_test() {
  {
    let is_active = True
    let is_confirmed = True

    use <- given.all([is_active, is_confirmed], return: fn() { great })

    woof
  }
  |> should.equal(great)
}

pub fn not_test() {
  {
    let user_understood = False

    use <- given.not(user_understood, return: fn() { great })

    woof
  }
  |> should.equal(great)

  {
    let user_understood = True

    use <- given.not(user_understood, return: fn() { great })

    woof
  }
  |> should.equal(woof)
}

pub fn any_not_test() {
  {
    let is_admin = False
    let is_editor = True

    use <- given.any_not([is_admin, is_editor], else_return: fn() { woof })

    great
  }
  |> should.equal(great)
}

pub fn all_not_test() {
  {
    let is_human = False
    let is_robot = False

    use <- given.all_not([is_human, is_robot], return: fn() { great })

    woof
  }
  |> should.equal(great)
}

pub fn when_test() {
  {
    let enabled = fn() { False }

    use <- given.when(enabled, return: fn() { great })

    woof
  }
  |> should.equal(woof)

  {
    let enabled = fn() { False }

    use <- given.when(enabled, else_return: fn() { great })

    woof
  }
  |> should.equal(great)
}

pub fn when_not_test() {
  {
    let enabled = fn() { False }

    use <- given.when_not(enabled, else_return: fn() { great })

    woof
  }
  |> should.equal(woof)

  {
    let enabled = fn() { False }

    use <- given.when_not(enabled, return: fn() { great })

    woof
  }
  |> should.equal(great)
}

pub fn empty_test() {
  {
    let list = []

    use <- given.empty(list, else_return: fn() { woof })

    great
  }
  |> should.equal(great)
}

pub fn non_empty_test() {
  {
    let list = []

    use <- given.non_empty(list, else_return: fn() { woof })

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

    ok_value
  }
  |> should.equal(great)

  {
    let result = Error(woof)
    use ok_value <- given.ok(in: result, else_return: fn(error_value) {
      error_value
    })

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

    woof
  }
  |> should.equal(woof)

  {
    let result = Ok(great)

    use _error_value <- given.error(in: result, else_return: fn(_ok_value) {
      great
    })

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

    great
  }
  |> should.equal(woof)
}

pub fn some_test() {
  {
    let option = Some(great)

    use _some <- given.some(in: option, else_return: fn() { woof })

    great
  }
  |> should.equal(great)

  {
    let option = Some(great)

    use _some <- given.some(in: option, else_return: fn() { woof })

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

    great
  }
  |> should.equal(woof)
}

pub fn none_test() {
  {
    let option = Some(great)

    use <- given.none(in: option, else_return: fn(_some) { woof })

    great
  }
  |> should.equal(woof)

  {
    let option = None

    use <- given.none(in: option, else_return: fn(_some) { woof })

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

    great
  }
  |> should.equal(woof)
}

pub fn less_test() {
  use <-
    given.less(the_value: 2, than: 3, else_return: fn() { woof }, return: fn() {
      great
    })
    |> should.equal(great)

  use <-
    given.less(the_value: 3, than: 2, else_return: fn() { woof }, return: fn() {
      great
    })
    |> should.equal(woof)
  todo
}

pub fn less_than_or_equal_test() {
  use <-
    given.less_than_or_equal(
      the_value: 2,
      to: 2,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.less_than_or_equal(
      the_value: 3,
      to: 2,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn equal_test() {
  use <-
    given.equal(the_value: 2, to: 2, else_return: fn() { woof }, return: fn() {
      great
    })
    |> should.equal(great)

  use <-
    given.equal(the_value: 2, to: 3, else_return: fn() { woof }, return: fn() {
      great
    })
    |> should.equal(woof)
  todo
}

pub fn greater_than_or_equal_test() {
  use <-
    given.greater_than_or_equal(
      the_value: 3,
      to: 2,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.greater_than_or_equal(
      the_value: 2,
      to: 3,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn greater_test() {
  use <-
    given.greater(
      the_value: 3,
      than: 2,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.greater(
      the_value: 2,
      than: 3,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn all_less_test() {
  use <-
    given.all_less(
      the_values: [1, 2, 3],
      than: 5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.all_less(
      the_values: [1, 2, 6],
      than: 5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn all_less_than_or_equal_test() {
  use <-
    given.all_less_than_or_equal(
      the_values: [1, 2, 3],
      to: 3,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.all_less_than_or_equal(
      the_values: [1, 2, 4],
      to: 3,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn all_equal_test() {
  use <-
    given.all_equal(
      the_values: [2, 2, 2],
      to: 2,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.all_equal(
      the_values: [2, 2, 3],
      to: 2,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn all_not_equal_test() {
  use <-
    given.all_not_equal(
      the_values: [1, 2, 3],
      to: 4,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.all_not_equal(
      the_values: [1, 2, 4],
      to: 4,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn all_greater_than_or_equal_test() {
  use <-
    given.all_greater_than_or_equal(
      the_values: [5, 6, 7],
      to: 5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.all_greater_than_or_equal(
      the_values: [5, 6, 4],
      to: 5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn all_greater_test() {
  use <-
    given.all_greater(
      the_values: [6, 7, 8],
      than: 5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.all_greater(
      the_values: [6, 7, 5],
      than: 5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn any_less_test() {
  use <-
    given.any_less(
      the_values: [5, 6, 2],
      than: 3,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.any_less(
      the_values: [5, 6, 4],
      than: 3,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn any_less_than_or_equal_test() {
  use <-
    given.any_less_than_or_equal(
      the_values: [5, 6, 2],
      to: 2,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.any_less_than_or_equal(
      the_values: [5, 6, 4],
      to: 2,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn any_equal_test() {
  use <-
    given.any_equal(
      the_values: [5, 6, 2],
      to: 6,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.any_equal(
      the_values: [5, 7, 2],
      to: 6,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn any_not_equal_test() {
  use <-
    given.any_not_equal(
      the_values: [5, 6, 2],
      to: 6,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.any_not_equal(
      the_values: [6, 6, 6],
      to: 6,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn any_greater_than_or_equal_test() {
  use <-
    given.any_greater_than_or_equal(
      the_values: [5, 6, 2],
      to: 6,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.any_greater_than_or_equal(
      the_values: [1, 2, 3],
      to: 6,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn any_greater_test() {
  use <-
    given.any_greater(
      the_values: [5, 6, 2],
      than: 5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.any_greater(
      the_values: [1, 2, 3],
      than: 5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn loosely_less_test() {
  use <-
    given.loosely_less(
      the_value: 2.0,
      than: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.loosely_less(
      the_value: 2.8,
      than: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn loosely_less_than_or_equal_test() {
  use <-
    given.loosely_less_than_or_equal(
      the_value: 3.4,
      to: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.loosely_less_than_or_equal(
      the_value: 3.6,
      to: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn loosely_equal_test() {
  use <-
    given.loosely_equal(
      the_value: 3.4,
      to: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.loosely_equal(
      the_value: 2.4,
      to: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn loosely_greater_than_or_equal_test() {
  use <-
    given.loosely_greater_than_or_equal(
      the_value: 2.6,
      to: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.loosely_greater_than_or_equal(
      the_value: 2.4,
      to: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn loosely_greater_test() {
  use <-
    given.loosely_greater(
      the_value: 3.6,
      than: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.loosely_greater(
      the_value: 3.4,
      than: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn all_loosely_less_test() {
  use <-
    given.all_loosely_less(
      the_values: [1.0, 2.0, 2.4],
      than: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.all_loosely_less(
      the_values: [1.0, 2.0, 2.6],
      than: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn all_loosely_less_than_or_equal_test() {
  use <-
    given.all_loosely_less_than_or_equal(
      the_values: [1.0, 2.0, 3.4],
      to: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.all_loosely_less_than_or_equal(
      the_values: [1.0, 2.0, 3.6],
      to: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn all_loosely_equal_test() {
  use <-
    given.all_loosely_equal(
      the_values: [2.6, 3.0, 3.4],
      to: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.all_loosely_equal(
      the_values: [2.6, 3.0, 3.6],
      to: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn all_not_loosely_equal_test() {
  use <-
    given.all_not_loosely_equal(
      the_values: [1.0, 4.0, 5.0],
      to: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.all_not_loosely_equal(
      the_values: [1.0, 3.0, 4.0],
      to: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn all_loosely_greater_than_or_equal_test() {
  use <-
    given.all_loosely_greater_than_or_equal(
      the_values: [2.6, 3.0, 3.4],
      to: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.all_loosely_greater_than_or_equal(
      the_values: [2.4, 3.0, 3.4],
      to: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn all_loosely_greater_test() {
  use <-
    given.all_loosely_greater(
      the_values: [3.6, 4.0, 4.6],
      than: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.all_loosely_greater(
      the_values: [3.4, 4.0, 4.6],
      than: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn any_loosely_less_test() {
  use <-
    given.any_loosely_less(
      the_values: [1.0, 2.0, 2.4],
      than: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.any_loosely_less(
      the_values: [3.6, 4.0, 4.6],
      than: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn any_loosely_less_than_or_equal_test() {
  use <-
    given.any_loosely_less_than_or_equal(
      the_values: [1.0, 2.0, 3.4],
      to: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.any_loosely_less_than_or_equal(
      the_values: [3.6, 4.0, 4.6],
      to: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn any_loosely_equal_test() {
  use <-
    given.any_loosely_equal(
      the_values: [2.6, 3.0, 3.4],
      to: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.any_loosely_equal(
      the_values: [1.0, 4.0, 5.0],
      to: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn any_not_loosely_equal_test() {
  use <-
    given.any_not_loosely_equal(
      the_values: [1.0, 4.0, 5.0],
      to: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.any_not_loosely_equal(
      the_values: [3.0, 3.0, 3.0],
      to: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn any_loosely_greater_than_or_equal_test() {
  use <-
    given.any_loosely_greater_than_or_equal(
      the_values: [2.6, 3.0, 3.4],
      to: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.any_loosely_greater_than_or_equal(
      the_values: [1.0, 2.0, 2.4],
      to: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn any_loosely_greater_test() {
  use <-
    given.any_loosely_greater(
      the_values: [3.6, 4.0, 4.6],
      than: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.any_loosely_greater(
      the_values: [1.0, 2.0, 2.4],
      than: 3.0,
      tolerating: 0.5,
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn empty_string_test() {
  use <-
    given.empty_string(the_string: "", else_return: fn() { woof }, return: fn() {
      great
    })
    |> should.equal(great)

  use <-
    given.empty_string(
      the_string: "not empty",
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn starts_with_test() {
  use <-
    given.starts_with(
      the_string: "foobar",
      head: "foo",
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.starts_with(
      the_string: "barfoo",
      head: "foo",
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn contains_string_test() {
  use <-
    given.contains_string(
      the_string: "foobar",
      sub: "oba",
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.contains_string(
      the_string: "foobar",
      sub: "baz",
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn ends_with_test() {
  use <-
    given.ends_with(
      the_string: "foobar",
      tail: "bar",
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.ends_with(
      the_string: "foobar",
      tail: "foo",
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn all_start_with_test() {
  use <-
    given.all_start_with(
      the_strings: ["foo", "foobar", "fooz"],
      head: "foo",
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.all_start_with(
      the_strings: ["foo", "bar", "fooz"],
      head: "foo",
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn any_start_with_test() {
  use <-
    given.any_start_with(
      the_strings: ["bar", "baz", "foo"],
      head: "foo",
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.any_start_with(
      the_strings: ["bar", "baz", "qux"],
      head: "foo",
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn all_end_with_test() {
  use <-
    given.all_end_with(
      the_strings: ["bar", "foobar", "bazbar"],
      tail: "bar",
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)

  use <-
    given.all_end_with(
      the_strings: ["bar", "bazbar"],
      tail: "bar",
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)
  todo
}

pub fn any_end_with_test() {
  use <-
    given.any_end_with(
      the_strings: ["bar", "foobar", "bazbar"],
      tail: "bar",
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.any_end_with(
      the_strings: ["foo", "baz", "qux"],
      tail: "bar",
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn all_contain_test() {
  use <-
    given.all_contain(
      the_strings: ["foobar", "barfoo", "bazbar"],
      sub: "bar",
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.all_contain(
      the_strings: ["foobar", "baz"],
      sub: "bar",
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}

pub fn any_contain_test() {
  use <-
    given.any_contain(
      the_strings: ["foo", "baz", "bar"],
      sub: "bar",
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(great)

  use <-
    given.any_contain(
      the_strings: ["foo", "baz", "qux"],
      sub: "bar",
      else_return: fn() { woof },
      return: fn() { great },
    )
    |> should.equal(woof)
  todo
}
