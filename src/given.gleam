//// This library attempts to make guards:
////
//// - Applicable to `Bool`, `Result`, `Option` and `List` types.
//// - Ergonomic to use by providing ways to handle both branches early.
//// - Expressive by making it easy to read through function names and labels.
//// - Comprehensible by not having to negate the conditions.
//// - Safe to execute because:
////   - either and or branches are enforced.
////   - not running discarded branch side effects by accident (much like
////     Gleam's standard library `bool.lazy_guard`, and its `bool.guard`).
////

import given/internal/lib/optionx
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/result

/// Checks if the condition is `True` and runs the consequence if it is, else
/// runs the alternative.
///
/// ## Examples
///
/// ```gleam
/// let user_understood = True
///
/// use <- given.that(user_understood, else_return: fn() { "Woof!" })
///
/// "💡 Bright!"
/// ```
///
pub fn that(
  the_case requirement: Bool,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case requirement {
    True -> consequence()
    False -> alternative()
  }
}

// TODO:
// pub fn one()
// pub fn n()

/// Checks if any of the conditions are `True` and runs the consequence if any
/// are, otherwise runs the alternative.
///
/// ## Examples
///
/// ```gleam
/// let is_admin = False
/// let is_editor = True
///
/// use <- given.any([is_admin, is_editor], else_return: fn() { "Cannot pass!" })
///
/// "🎵 Snap - I've got the power!"
/// ```
///
pub fn any(
  are_true_in requirements: List(Bool),
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case requirements |> list.any(fn(v) { v == True }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if all of the conditions are `True` and runs the consequence if all
/// are, otherwise runs the alternative.
///
/// ## Examples
///
/// ```gleam
/// let is_active = True
/// let is_confirmed = True
///
/// use <- given.all([is_active, is_confirmed], else_return: fn() { "Stop!" })
///
/// "🏇 Ready, steady, go!"
/// ```
///
pub fn all(
  are_true_in requirements: List(Bool),
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case requirements |> list.all(fn(v) { v == True }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if the condition is `False` and runs the consequence if it is, else
/// runs the alternative.
///
/// ## Examples
///
/// ```gleam
/// let has_admin_role = False
///
/// use <- given.not(has_admin_role, else_return: fn() { "Access granted!" })
///
/// "✋ Denied!"
/// ```
///
pub fn not(
  the_case requirement: Bool,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case requirement == False {
    True -> consequence()
    False -> alternative()
  }
}

// TODO:
// pub fn one_not()
// pub fn n_not()

/// Checks if any of the conditions are `False` and runs the consequence if any
/// are, otherwise runs the alternative.
///
/// ## Examples
///
/// ```gleam
/// let got_veggies = True
/// let got_spices = False
///
/// use <- given.any_not([got_veggies, got_spices], else_return: fn() {
///   "Preparing a soup!"
/// })
///
/// "😭 Ingredient missing..."
/// ```
///
pub fn any_not(
  are_true_in requirements: List(Bool),
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case requirements |> list.any(fn(v) { v == False }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if all of the conditions are `False` and runs the consequence if all
/// are, otherwise runs the alternative.
///
/// ## Examples
///
/// ```gleam
// let is_android = False
// let is_synthetic = False
//
// use <- given.all_not([is_android, is_synthetic], else_return: fn() {
//   "I am a Cylon!"
// })
//
// "🪦 Obsolete model detected."
/// ```
///
pub fn all_not(
  are_true_in requirements: List(Bool),
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case requirements |> list.all(fn(v) { v == False }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if the condition function returns `True` and runs the consequence if
/// it is, otherwise runs the alternative.
///
/// Use to lazily evaluate a complex condition and return early if it fails.
///
/// ## Examples
///
/// ```gleam
/// let enabled_in_db = fn() { True }
///
/// use <- given.when(enabled_in_db, else_return: fn() { "User disabled!" })
///
/// "✅ User enabled"
/// ```
///
pub fn when(
  the_case condition: fn() -> Bool,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case condition() {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if the condition function returns `False` and runs the consequence if
/// it is, otherwise runs the alternative.
///
/// Use to lazily evaluate a complex condition and return early if they fail.
///
/// ## Examples
///
/// ```gleam
/// let enabled_in_db = fn() { False }
///
/// use <- given.when_not(enabled_in_db, else_return: fn() { "User enabled!" })
///
/// "❌ User disabled"
/// ```
///
pub fn when_not(
  the_case condition: fn() -> Bool,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case condition() == False {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if the list is empty and runs the consequence if it is, otherwise runs
/// the alternative.
///
/// ## Examples
///
/// ```gleam
// let list = []
//
// use <- given.empty(list, else_return: fn() {
//   "Full as if you ate two large vegan 🍔!"
// })
//
// "🛸 Empty like vast space!"
/// ```
///
pub fn empty(
  list list: List(a),
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case list {
    [] -> consequence()
    _not_empty -> alternative()
  }
}

/// Checks if the list is non-empty and runs the consequence if it is, else
/// runs the alternative.
///
/// ## Examples
///
/// ```gleam
/// let list = [1]
///
/// use <- given.non_empty(list, else_return: fn() { "Empty like vast space! 🛸" })
///
/// "🍔 Full as if you ate two large vegan!"
/// ```
///
pub fn non_empty(
  list list: List(a),
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case list {
    [] -> alternative()
    _non_empty -> consequence()
  }
}

/// Checks if the result is an `Ok` and runs the consequence if it is, else
/// runs the alternative.
///
/// ## Examples
///
/// ```gleam
/// let result = Ok("📞 Hello Joe, again!")
///
/// use val <- given.ok(in: result, else_return: fn(_error) {
///   "Joe is unreachable, now 💔."
/// })
///
/// val
/// ```
///
pub fn ok(
  in rslt: Result(a, e),
  else_return alternative: fn(e) -> b,
  return consequence: fn(a) -> b,
) -> b {
  case rslt {
    Ok(val) -> consequence(val)
    Error(err) -> alternative(err)
  }
}

// TODO:
// pub fn one_ok()
// pub fn n_ok()

/// Checks if any of the results are `Ok` and runs the consequence -  passing in
/// the `Ok` and `Error` values - if they are, otherwise runs the alternative passing
/// in all `Error` values.
///
/// ## Examples
///
/// ```gleam
/// let results = [Ok("Happy"), Error("Sad")]
///
/// use _oks, _errors <- given.any_ok(in: results, else_return: fn(_errors) {
///   "All Error values!"
/// })
///
/// "👍 At least one Ok values!"
/// ```
///
pub fn any_ok(
  in rslts: List(Result(a, e)),
  else_return alternative: fn(List(e)) -> b,
  return consequence: fn(List(a), List(e)) -> b,
) -> b {
  let #(oks, errors) = rslts |> result.partition

  case oks {
    [] -> alternative(errors)
    _non_zero_oks -> consequence(oks, errors)
  }
}

/// Checks if all of the results are `Ok` and runs the consequence - passing in
/// the `Ok` values - if they are, otherwise runs the alternative passing in all
/// `Ok` and `Error` values.
///
/// ## Examples
///
/// ```gleam
/// let results = [Ok("Happy"), Ok("Glad")]
///
/// use _oks <- given.all_ok(in: results, else_return: fn(_oks, _errors) {
///   "At least one Error value!"
/// })
///
/// "👍👍 All Ok values"
/// ```
///
pub fn all_ok(
  in rslts: List(Result(a, e)),
  else_return alternative: fn(List(a), List(e)) -> b,
  return consequence: fn(List(a)) -> b,
) -> b {
  let #(oks, errors) = rslts |> result.partition

  case errors {
    [] -> consequence(oks)
    _non_zero_errors -> alternative(oks, errors)
  }
}

/// Checks if the result is an `Error` and runs the consequence if it is, else
/// runs the alternative.
///
/// ## Examples
///
/// ```gleam
/// let result = Error("💻 Memory exhausted!")
///
/// use val <- given.error(in: result, else_return: fn(_ok) {
///   "Allocating memory..."
/// })
///
/// val
/// ```
///
pub fn error(
  in rslt: Result(a, e),
  else_return alternative: fn(a) -> b,
  return consequence: fn(e) -> b,
) -> b {
  case rslt {
    Error(err) -> consequence(err)
    Ok(val) -> alternative(val)
  }
}

// TODO:
// pub fn one_error()
// pub fn n_error()

/// Checks if any of the results are `Error` and runs the consequence - passing
/// in the `Ok` and `Error` values - if they are, otherwise runs the alternative
/// passing in all `Ok` values.
///
/// ## Examples
///
/// ```gleam
/// let results = [Ok("Happy"), Error("Sad")]
///
/// use _oks, _errors <- given.any_error(in: results, else_return: fn(_oks) {
///   "No Errors"
/// })
///
/// "🚧 At least one Error occured!"
/// ```
///
pub fn any_error(
  in rslts: List(Result(a, e)),
  else_return alternative: fn(List(a)) -> b,
  return consequence: fn(List(a), List(e)) -> b,
) -> b {
  let #(oks, errors) = rslts |> result.partition

  case errors {
    [] -> alternative(oks)
    _non_zero_errors -> consequence(oks, errors)
  }
}

/// Checks if all of the results are `Error` and runs the consequence - passing
/// in the `Error` values - if they are, otherwise runs the alternative passing in
/// all `Ok` and `Error` values.
///
/// ## Examples
///
/// ```gleam
/// let results = [Error("Sad"), Error("Lonely")]
///
/// use _errors <- given.all_error(in: results, else_return: fn(_oks, _errors) {
///   "Life is good!"
/// })
///
/// "☕ Take care and learn to love yourself!"
/// ```
///
pub fn all_error(
  in rslts: List(Result(a, e)),
  else_return alternative: fn(List(a), List(e)) -> b,
  return consequence: fn(List(e)) -> b,
) -> b {
  let #(oks, errors) = rslts |> result.partition

  case oks {
    [] -> consequence(errors)
    _non_zero_oks -> alternative(oks, errors)
  }
}

/// Checks if the option is `Some` and runs the consequence if it is, otherwise runs
/// the alternative.
///
/// ## Examples
///
/// ```gleam
/// import gleam/option.{Some}
///
/// let option = Some("🪙 One more penny")
///
/// use val <- given.some(in: option, else_return: fn() { "Nothing to spare!" })
///
/// val
/// ```
///
pub fn some(
  in optn: Option(a),
  else_return alternative: fn() -> b,
  return consequence: fn(a) -> b,
) -> b {
  case optn {
    Some(val) -> consequence(val)
    None -> alternative()
  }
}

// TODO:
// pub fn one_some()
// pub fn n_some()

/// Checks if any of the options are `Some` and runs the consequence - passing
/// in the `Some` values and a count of the `None` values - if they are, else
/// runs the alternative passing in the count of `None` values.
///
/// ## Examples
///
/// ```gleam
/// import gleam/option.{None, Some}
///
/// let options = [Some("One"), None]
///
/// use _somes, _nones_count <- given.any_some(
///   in: options,
///   else_return: fn(_nones_count) { "Nothing at all." },
/// )
///
/// "😅 At least one Some!"
/// ```
///
pub fn any_some(
  in optns: List(Option(a)),
  else_return alternative: fn(Int) -> b,
  return consequence: fn(List(a), Int) -> b,
) -> b {
  let #(somes, nones_count) = optns |> optionx.partition

  case somes {
    [] -> alternative(nones_count)
    _non_zero_somes -> consequence(somes, nones_count)
  }
}

/// Checks if all of the options are `Some` and runs the consequence - passing
/// in the `Some` values - if they are, otherwise runs the alternative passing in
/// the `Some` and a count of the `None` values.
///
/// ## Examples
///
/// ```gleam
/// import gleam/option.{Some}
///
/// let options = [Some("Treasure Chest"), Some("Nugget")]
///
/// use _somes <- given.all_some(
///   in: options,
///   else_return: fn(_somes, _nones_count) { "Nothing at all" },
/// )
///
/// "🏅 There is gold everywhere!"
/// ```
///
pub fn all_some(
  in optns: List(Option(a)),
  else_return alternative: fn(List(a), Int) -> b,
  return consequence: fn(List(a)) -> b,
) -> b {
  let #(somes, nones_count) = optns |> optionx.partition

  case nones_count {
    0 -> consequence(somes)
    _positive_none_count -> alternative(somes, nones_count)
  }
}

/// Checks if the option is `None` and runs the consequence if it is, otherwise runs
/// the alternative.
///
/// ## Examples
///
/// ```gleam
/// import given
/// import gleam/option.{None}
///
/// let option = None
///
/// use <- given.none(in: option, else_return: fn(some_value) { "Some value" })
///
/// // …handle None here…
/// "None"
/// ```
///
/// ```gleam
/// import gleam/option.{None}
///
/// let option = None
///
/// use <- given.none(in: option, else_return: fn(_some_value) {
///   "There is someone sleeping!"
/// })
///
/// "🛏, aka None is in this bed!"
/// ```
///
pub fn none(
  in optn: Option(a),
  else_return alternative: fn(a) -> b,
  return consequence: fn() -> b,
) -> b {
  case optn {
    None -> consequence()
    Some(val) -> alternative(val)
  }
}

// TODO:
// pub fn one_none()
// pub fn n_none()

/// Checks if any of the options are `None` and runs the consequence if they
/// are, otherwise runs the alternative passing in the `Some` values and the count
/// of `None` values.
///
/// ## Examples
///
/// ```gleam
/// import gleam/option.{None, Some}
///
/// let options = [Some("One"), None]
///
/// use _somes, _none_count <- given.any_none(
///   in: options,
///   else_return: fn(_somes) { "Only Somes here!" },
/// )
///
/// "🕳️, aka None, detected in the system at least once."
/// ```
///
pub fn any_none(
  in optns: List(Option(a)),
  else_return alternative: fn(List(a)) -> b,
  return consequence: fn(List(a), Int) -> b,
) -> b {
  let #(somes, nones_count) = optns |> optionx.partition

  case nones_count {
    0 -> alternative(somes)
    _positive_none_count -> consequence(somes, nones_count)
  }
}

/// Checks if all of the options are `None` and runs the consequence if they
/// are, otherwise runs the alternative passing in the `Some` values.
///
/// ## Examples
///
/// ```gleam
/// import gleam/option.{None}
///
/// let options = [None, None]
///
/// use <- given.all_none(in: options, else_return: fn(_somes, _nones_count) {
///   "Someone tipped me :)!"
/// })
///
/// "🫙 There is nothing in the jar..."
/// ```
///
pub fn all_none(
  in optns: List(Option(a)),
  else_return alternative: fn(List(a), Int) -> b,
  return consequence: fn() -> b,
) -> b {
  let #(somes, nones_count) = optns |> optionx.partition

  case somes {
    [] -> consequence()
    _non_zero_somes -> alternative(somes, nones_count)
  }
}
//
// // Int:

// given.less(int, than int, else_return: alternative, return: consequence)
// given.less_than_or_equal(int, to int, else_return: alternative, return: consequence)
// given.equal(int, to int, else_return: alternative, return: consequence)
// given.greater_than_or_equal(int, to int, else_return: alternative, return: consequence)
// given.greater(int, than int, else_return: alternative, return: consequence)

// // List(Int):

// given.one_*
// given.n_*
// given.all_less(ints, than int, else_return: alternative, return: consequence)
// given.all_less_than_or_equal(ints, to int, else_return: alternative, return: consequence)
// given.all_equal(ints, to int, else_return: alternative, return: consequence)
// given.all_not_equal(ints, to int, else_return: alternative, return: consequence)
// given.all_greater_than_or_equal(ints, to int, else_return: alternative, return: consequence)
// given.all_greater(ints, than int, else_return: alternative, return: consequence)
// given.any_less(ints, than int, else_return: alternative, return: consequence)
// given.any_less_than_or_equal(ints, to int, else_return: alternative, return: consequence)
// given.any_equal(ints, to int, else_return: alternative, return: consequence)
// given.any_not_equal(ints, to int, else_return: alternative, return: consequence)
// given.any_greater_than_or_equal(ints, to int, else_return: alternative, return: consequence)
// given.any_greater(ints, than int, else_return: alternative, return: consequence)

// // Float with tolerance:

// given.loosely_less(float, than float, tolerance, else_return: alternative, return: consequence)
// given.loosely_less_than_or_equal(float, to float, tolerance, else_return: alternative, return: consequence)
// given.loosely_equal(float, to float, tolerance, else_return: alternative, return: consequence)
// given.loosely_greater_than_or_equal(float, to float, tolerance, else_return: alternative, return: consequence)
// given.loosely_greater(float, than float, tolerance, else_return: alternative, return: consequence)

// // List(Float) with tolerance:

// given.one_*
// given.n_*
// given.all_loosely_less(floats, than float, tolerance, else_return: alternative, return: consequence)
// given.all_loosely_less_than_or_equal(floats, to float, tolerance, else_return: alternative, return: consequence)
// given.all_loosely_equal(floats, tolerance, else_return: alternative, return: consequence)
// given.all_not_loosely_equal(floats, tolerance, else_return: alternative, return: consequence)
// given.all_loosely_greater_than_or_equal(floats, to float, tolerance, else_return: alternative, return: consequence)
// given.all_loosely_greater(floats, than float, tolerance, else_return: alternative, return: consequence)
// given.any_loosely_less(floats, than float, tolerance, else_return: alternative, return: consequence)
// given.any_loosely_less_than_or_equal(floats, to float, tolerance, else_return: alternative, return: consequence)
// given.any_loosely_equal(floats, tolerance, else_return: alternative, return: consequence)
// given.any_not_loosely_equal(floats, tolerance, else_return: alternative, return: consequence)
// given.any_loosely_greater_than_or_equal(floats, to float, tolerance, else_return: alternative, return: consequence)
// given.any_loosely_greater(floats, than float, tolerance, else_return: alternative, return: consequence)

// // String:

// given.empty_string(string, else_return: alternative, return: consequence)
// given.starts_with(string, head string, else_return: alternative, return: consequence)
// given.contains(string, sub string, else_return: alternative, return: consequence)
// given.ends_with(string, tail string, else_return: alternative, return: consequence)

// // Dict:

// given.has_key(dict, key, else_return: alternative, return: consequence)
// given.has_key_value(dict, key, value, else_return: alternative, return: consequence)
