//// All the functions contain labeled `else_return` and `return` callbacks.
////
//// Depending on readability where given is used one should use `return` or
//// `else_return` labels and positive or negative conditions.
////
//// The one not specified will become the happy path (or expected) path you
//// trot along as part of the `use` callback *body*.
////
//// The function form and argument order is always:
////
//// `condition_name(...data, else_return, return)`
////
//// Thus if you were to omit labels the positive case behind the `return` label
//// becomes the `use`-body.
////
//// Also see:
//// [Railway Oriented Programming](https://fsharpforfunandprofit.com/rop/).

import given

// Can use `return` labels:
fn given_not_example_1() {
  let has_admin_role = True

  use <- given.not(has_admin_role, return: fn() { "Denied!" })

  "👌 Access granted!"
}

// Can use `else_return` labels:
fn given_not_example_2() {
  let has_admin_role = False

  use <- given.not(has_admin_role, else_return: fn() { "Access granted!" })

  "✋ Denied!"
}

fn given_that_example_1() {
  let user_understood = True

  use <- given.that(user_understood, else_return: fn() { "Woof!" })

  "💡 Bright!"
}

fn given_any_example_1() {
  let is_admin = False
  let is_editor = True

  use <- given.any([is_admin, is_editor], else_return: fn() { "Cannot pass!" })

  "🎵 Snap - I've got the power!"
}

fn given_all_example_1() {
  let is_active = True
  let is_confirmed = True

  use <- given.all([is_active, is_confirmed], else_return: fn() { "Stop!" })

  "🏇 Ready, steady, go!"
}

fn given_any_not_example_1() {
  let got_veggies = True
  let got_spices = False

  use <- given.any_not([got_veggies, got_spices], else_return: fn() {
    "Preparing a soup!"
  })

  "😭 Ingredient missing..."
}

fn given_all_not_example_1() {
  let is_android = False
  let is_synthetic = False

  use <- given.all_not([is_android, is_synthetic], else_return: fn() {
    "I am a Cylon!"
  })

  "🪦 Obsolete model detected."
}

fn given_when_example_1() {
  let enabled_in_db = fn() { True }

  use <- given.when(enabled_in_db, else_return: fn() { "User disabled!" })

  "✅ User enabled"
}

fn given_when_not_example_1() {
  let enabled_in_db = fn() { True }

  use <- given.when_not(enabled_in_db, return: fn() { "User disabled!" })

  "🟢 User enabled"
}

fn given_when_not_example_2() {
  let enabled_in_db = fn() { False }

  use <- given.when_not(enabled_in_db, else_return: fn() { "User enabled!" })

  "❌ User disabled"
}

fn given_empty_example_1() {
  let list = []

  use <- given.empty(list, else_return: fn() {
    "Full as if you ate two large vegan 🍔!"
  })

  "🛸 Empty like vast space!"
}

fn given_non_empty_example_1() {
  let list = [1]

  use <- given.non_empty(list, else_return: fn() { "Empty like vast space! 🛸" })

  "🍔 Full as if you ate two large vegan!"
}

fn given_ok_example_1() {
  let result = Ok("📞 Hello Joe, again!")

  use val <- given.ok(in: result, else_return: fn(_error) {
    "Joe is unreachable, now 💔."
  })

  val
}

fn given_any_ok_example_1() {
  let results = [Ok("Happy"), Error("Sad")]

  use _oks, _errors <- given.any_ok(in: results, else_return: fn(_errors) {
    "All Error values!"
  })

  "👍 At least one Ok values!"
}

fn given_all_ok_example_1() {
  let results = [Ok("Happy"), Ok("Glad")]

  use _oks <- given.all_ok(in: results, else_return: fn(_oks, _errors) {
    "At least one Error value!"
  })

  "👍👍 All Ok values"
}

fn given_error_example_1() {
  let result = Error("💻 Memory exhausted!")

  use val <- given.error(in: result, else_return: fn(_ok) {
    "Allocating memory..."
  })

  val
}

fn given_any_error_example_1() {
  let results = [Ok("Happy"), Ok("Two")]

  use _oks <- given.any_error(in: results, return: fn(_oks, _errors) {
    "At least one Error occured!"
  })

  "😊 No Errors"
}

fn given_any_error_example_2() {
  let results = [Ok("Happy"), Error("Sad")]

  use _oks, _errors <- given.any_error(in: results, else_return: fn(_oks) {
    "No Errors"
  })

  "🚧 At least one Error occured!"
}

fn given_all_error_example_1() {
  let results = [Error("Sad"), Error("Lonely")]

  use _errors <- given.all_error(in: results, else_return: fn(_oks, _errors) {
    "Life is good!"
  })

  "☕ Take care and learn to love yourself!"
}

import gleam/option.{None, Some}

fn given_some_example_1() {
  let option = Some("🪙 One more penny")

  use val <- given.some(in: option, else_return: fn() { "Nothing to spare!" })

  val
}

fn given_any_some_example_1() {
  let options = [Some("One"), None]

  use _somes, _nones_count <- given.any_some(
    in: options,
    else_return: fn(_nones_count) { "Nothing at all." },
  )

  "😅 At least one Some!"
}

fn given_all_some_example_1() {
  let options = [Some("Treasure Chest"), Some("Nugget")]

  use _somes <- given.all_some(
    in: options,
    else_return: fn(_somes, _nones_count) { "Nothing at all" },
  )

  "🏅 There is gold everywhere!"
}

fn given_none_example_1() {
  let option = None

  use <- given.none(in: option, else_return: fn(_some_value) {
    "There is someone sleeping!"
  })

  "🛏, aka None is in this bed!"
}

fn given_any_none_example_1() {
  let options = [Some("One"), Some("Two")]

  use _somes <- given.any_none(in: options, return: fn(_somes, _none_count) {
    "None, detected in the system at least once."
  })

  "🧍🧍 Only Somes here!"
}

fn given_any_none_example_2() {
  let options = [Some("One"), None]

  use _somes, _none_count <- given.any_none(
    in: options,
    else_return: fn(_somes) { "Only Somes here!" },
  )

  "🕳️, aka None, detected in the system at least once."
}

fn given_all_none_example_1() {
  let options = [None, None]

  use <- given.all_none(in: options, else_return: fn(_somes, _nones_count) {
    "Someone tipped me :)!"
  })

  "🫙 There is nothing in the jar..."
}

pub fn main() {
  // Bool
  given_not_example_1() |> echo
  given_not_example_2() |> echo
  given_that_example_1() |> echo
  given_any_example_1() |> echo
  given_all_example_1() |> echo
  given_any_not_example_1() |> echo
  given_all_not_example_1() |> echo
  // Function
  given_when_example_1() |> echo
  given_when_not_example_1() |> echo
  given_when_not_example_2() |> echo
  // List
  given_empty_example_1() |> echo
  given_non_empty_example_1() |> echo
  // Result
  given_ok_example_1() |> echo
  given_any_ok_example_1() |> echo
  given_all_ok_example_1() |> echo
  given_error_example_1() |> echo
  given_any_error_example_1() |> echo
  given_any_error_example_2() |> echo
  given_all_error_example_1() |> echo
  // Option
  given_some_example_1() |> echo
  given_any_some_example_1() |> echo
  given_all_some_example_1() |> echo
  given_none_example_1() |> echo
  given_any_none_example_1() |> echo
  given_any_none_example_2() |> echo
  given_all_none_example_1() |> echo
}
