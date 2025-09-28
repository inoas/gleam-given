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
import gleam/dict.{type Dict}
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/result
import gleam/string

// ┌───────────────────────────────────────────────────────────────────────────┐
// │  Bool                                                                     │
// └───────────────────────────────────────────────────────────────────────────┘

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

// ┌───────────────────────────────────────────────────────────────────────────┐
// │  Function                                                                 │
// └───────────────────────────────────────────────────────────────────────────┘

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

// ┌───────────────────────────────────────────────────────────────────────────┐
// │  List                                                                     │
// └───────────────────────────────────────────────────────────────────────────┘

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

// ┌───────────────────────────────────────────────────────────────────────────┐
// │  Result                                                                   │
// └───────────────────────────────────────────────────────────────────────────┘

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
  in result: Result(a, e),
  else_return alternative: fn(e) -> b,
  return consequence: fn(a) -> b,
) -> b {
  case result {
    Ok(val) -> consequence(val)
    Error(err) -> alternative(err)
  }
}

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
  in results: List(Result(a, e)),
  else_return alternative: fn(List(e)) -> b,
  return consequence: fn(List(a), List(e)) -> b,
) -> b {
  let #(oks, errors) = results |> result.partition

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
  in results: List(Result(a, e)),
  else_return alternative: fn(List(a), List(e)) -> b,
  return consequence: fn(List(a)) -> b,
) -> b {
  let #(oks, errors) = results |> result.partition

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
  in result: Result(a, e),
  else_return alternative: fn(a) -> b,
  return consequence: fn(e) -> b,
) -> b {
  case result {
    Error(err) -> consequence(err)
    Ok(val) -> alternative(val)
  }
}

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
  in results: List(Result(a, e)),
  else_return alternative: fn(List(a)) -> b,
  return consequence: fn(List(a), List(e)) -> b,
) -> b {
  let #(oks, errors) = results |> result.partition

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
  in results: List(Result(a, e)),
  else_return alternative: fn(List(a), List(e)) -> b,
  return consequence: fn(List(e)) -> b,
) -> b {
  let #(oks, errors) = results |> result.partition

  case oks {
    [] -> consequence(errors)
    _non_zero_oks -> alternative(oks, errors)
  }
}

// ┌───────────────────────────────────────────────────────────────────────────┐
// │  Option                                                                   │
// └───────────────────────────────────────────────────────────────────────────┘

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
  in option: Option(a),
  else_return alternative: fn() -> b,
  return consequence: fn(a) -> b,
) -> b {
  case option {
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
  in options: List(Option(a)),
  else_return alternative: fn(Int) -> b,
  return consequence: fn(List(a), Int) -> b,
) -> b {
  let #(somes, nones_count) = options |> optionx.partition

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
  in options: List(Option(a)),
  else_return alternative: fn(List(a), Int) -> b,
  return consequence: fn(List(a)) -> b,
) -> b {
  let #(somes, nones_count) = options |> optionx.partition

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
  in option: Option(a),
  else_return alternative: fn(a) -> b,
  return consequence: fn() -> b,
) -> b {
  case option {
    None -> consequence()
    Some(val) -> alternative(val)
  }
}

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
  in options: List(Option(a)),
  else_return alternative: fn(List(a)) -> b,
  return consequence: fn(List(a), Int) -> b,
) -> b {
  let #(somes, nones_count) = options |> optionx.partition

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
  in options: List(Option(a)),
  else_return alternative: fn(List(a), Int) -> b,
  return consequence: fn() -> b,
) -> b {
  let #(somes, nones_count) = options |> optionx.partition

  case somes {
    [] -> consequence()
    _non_zero_somes -> alternative(somes, nones_count)
  }
}

// ┌───────────────────────────────────────────────────────────────────────────┐
// │  Integer                                                                  │
// └───────────────────────────────────────────────────────────────────────────┘

/// Checks if the first integer is less than the second and runs the consequence
/// if it is, else runs the alternative.
///
/// ⚠️ NOTICE: Instead of…
///
/// ```gleam
/// let i = 4
/// use <- given.less(5, for: i, else_return: alt_fun)
/// ```
///
/// …consider using this instead for `Int`s:
///
/// ```gleam
/// let i = 4
/// use <- given.that(i < 5, else_return: alt_fun)
/// ```
///
/// This function exists merely for consistency.
///
pub fn less(
  value value: Int,
  than threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case value < threshold {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if the first integer is less than or equal to the second and runs the
/// consequence if it is, else runs the alternative.
///
/// ⚠️ NOTICE: Instead of…
///
/// ```gleam
/// let i = 4
/// use <- given.less_than_or_equal(i, to: 5, else_return: alt_fun)
/// use <- given.less_than_or_equal(i, to: 5, else_return: alt_fun)
/// ```
///
/// …consider using this instead for `Int`s:
///
/// ```gleam
/// let i = 4
/// use <- given.that(i < 5, else_return: alt_fun)
/// ```
///
/// This function exists merely for consistency.
///
pub fn less_than_or_equal(
  value value: Int,
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case value <= threshold {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if the first integer is equal to the second and runs the consequence
/// if it is, else runs the alternative.
///
/// /// ⚠️ NOTICE: Instead of…
///
/// ```gleam
/// let i = 4
/// use <- given.equal(i, to: 5, else_return: alt_fun)
/// ```
///
/// …consider using this instead for `Int`s:
///
/// ```gleam
/// let i = 4
/// use <- given.that(i == 5, else_return: alt_fun)
/// ```
///
/// This function exists merely for consistency.
///
pub fn equal(
  value value: Int,
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case value == threshold {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if the first integer is greater than or equal to the second and runs
/// the consequence if it is, else runs the alternative.
///
/// ⚠️ NOTICE: Instead of…
///
/// ```gleam
/// let i = 4
/// use <- given.greater_than_or_equal(i, to: 5, else_return: alt_fun)
/// ```
///
/// …consider using this instead for `Int`s:
///
/// ```gleam
/// let i = 4
/// use <- given.that(i >= 5, else_return: alt_fun)
/// ```
///
/// This function exists merely for consistency.
///
pub fn greater_than_or_equal(
  value value: Int,
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case value >= threshold {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if the first integer is greater than the second and runs the
/// consequence if it is, else runs the alternative.
///
/// ⚠️ NOTICE: Instead of…
///
/// ```gleam
/// let i = 4
/// use <- given.greater(than: i, for: 5, else_return: alt_fun)
/// ```
///
/// …consider using this instead for `Int`s:
///
/// ```gleam
/// let i = 4
/// use <- given.that(i > 5, else_return: alt_fun)
/// ```
///
/// This function exists merely for consistency.
///
pub fn greater(
  value value: Int,
  than threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case value > threshold {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if all integers in the list are less than the threshold and runs the
/// consequence if they are, else runs the alternative.
///
pub fn all_less(
  values values: List(Int),
  than threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.all(fn(value) { value < threshold }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if all integers in the list are less than or equal to the threshold
/// and runs the consequence if they are, else runs the alternative.
///
pub fn all_less_than_or_equal(
  values values: List(Int),
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.all(fn(value) { value <= threshold }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if all integers in the list are equal to the threshold and runs the
/// consequence if they are, else runs the alternative.
///
pub fn all_equal(
  values values: List(Int),
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.all(fn(value) { value == threshold }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if all integers in the list are not equal to the threshold and runs
/// the consequence if they are, else runs the alternative.
///
pub fn all_not_equal(
  values values: List(Int),
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.all(fn(value) { value != threshold }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if all integers in the list are greater than or equal to the
/// threshold and runs the consequence if they are, else runs the alternative.
///
pub fn all_greater_than_or_equal(
  values values: List(Int),
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.all(fn(value) { value >= threshold }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if all integers in the list are greater than the threshold and runs
/// the consequence if they are, else runs the alternative.
///
pub fn all_greater(
  values values: List(Int),
  than threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.all(fn(value) { value > threshold }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if any integer in the list is less than the threshold and runs the
/// consequence if one is, else runs the alternative.
///
pub fn any_less(
  values values: List(Int),
  than threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.any(fn(value) { value < threshold }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if any integer in the list is less than or equal to the threshold and
/// runs the consequence if one is, else runs the alternative.
///
pub fn any_less_than_or_equal(
  values values: List(Int),
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.any(fn(value) { value <= threshold }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if any integer in the list is equal to the threshold and runs the
/// consequence if one is, else runs the alternative.
///
pub fn any_equal(
  values values: List(Int),
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.any(fn(value) { value == threshold }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if any integer in the list is not equal to the threshold and runs the
/// consequence if one is, else runs the alternative.
///
pub fn any_not_equal(
  values values: List(Int),
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.any(fn(value) { value != threshold }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if any integer in the list is greater than or equal to the threshold
/// and runs the consequence if one is, else runs the alternative.
///
pub fn any_greater_than_or_equal(
  values values: List(Int),
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.any(fn(value) { value >= threshold }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if any integer in the list is greater than the threshold and runs the
/// consequence if one is, else runs the alternative.
///
pub fn any_greater(
  values values: List(Int),
  than threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.any(fn(value) { value > threshold }) {
    True -> consequence()
    False -> alternative()
  }
}

// ┌───────────────────────────────────────────────────────────────────────────┐
// │  Float                                                                    │
// └───────────────────────────────────────────────────────────────────────────┘

/// Checks if the first float is less than the second within the given tolerance
/// and runs the consequence if it is, else runs the alternative.
///
pub fn loosely_less(
  value value: Float,
  than threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case value <. threshold -. tolerance {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if the first float is less than or equal to the second within the
/// given tolerance and runs the consequence if it is, else runs the
/// alternative.
///
pub fn loosely_less_than_or_equal(
  value value: Float,
  to threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case value <=. threshold +. tolerance {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if the first float is equal to the second within the given tolerance
/// and runs the consequence if it is, else runs the alternative.
///
pub fn loosely_equal(
  value value: Float,
  to threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case value >=. threshold -. tolerance && value <=. threshold +. tolerance {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if the first float is greater than or equal to the second within the
/// given tolerance and runs the consequence if it is, else runs the
/// alternative.
///
pub fn loosely_greater_than_or_equal(
  value value: Float,
  to threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case value >=. threshold -. tolerance {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if the first float is greater than the second within the given
/// tolerance and runs the consequence if it is, else runs the alternative.
///
pub fn loosely_greater(
  value value: Float,
  than threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case value >. threshold +. tolerance {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if all floats in the list are less than the threshold within the
/// given tolerance and runs the consequence if they are, else runs the
/// alternative.
///
pub fn all_loosely_less(
  values values: List(Float),
  than threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.all(fn(value) { value <. threshold -. tolerance }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if all floats in the list are less than or equal to the threshold
/// within the given tolerance and runs the consequence if they are, else runs
/// the alternative.
///
pub fn all_loosely_less_than_or_equal(
  values values: List(Float),
  to threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.all(fn(value) { value <=. threshold +. tolerance }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if all floats in the list are equal to the threshold within the given
/// tolerance and runs the consequence if they are, else runs the alternative.
///
pub fn all_loosely_equal(
  values values: List(Float),
  to threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case
    values
    |> list.all(fn(value) {
      value >=. threshold -. tolerance && value <=. threshold +. tolerance
    })
  {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if all floats in the list are not equal to the threshold within the
/// given tolerance and runs the consequence if they are, else runs the
/// alternative.
///
pub fn all_not_loosely_equal(
  values values: List(Float),
  to threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case
    values
    |> list.all(fn(value) {
      value <. threshold -. tolerance || value >. threshold +. tolerance
    })
  {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if all floats in the list are greater than or equal to the threshold
/// within the given tolerance and runs the consequence if they are, else runs
/// the alternative.
///
pub fn all_loosely_greater_than_or_equal(
  values values: List(Float),
  to threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.all(fn(value) { value >=. threshold -. tolerance }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if all floats in the list are greater than the threshold within the
/// given tolerance and runs the consequence if they are, else runs the
/// alternative.
///
pub fn all_loosely_greater(
  values values: List(Float),
  than threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.all(fn(value) { value >. threshold +. tolerance }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if any float in the list is less than the threshold within the given
/// tolerance and runs the consequence if one is, else runs the alternative.
///
pub fn any_loosely_less(
  values values: List(Float),
  than threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.any(fn(value) { value <. threshold -. tolerance }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if any float in the list is less than or equal to the threshold
/// within the given tolerance and runs the consequence if one is, else runs the
/// alternative.
///
pub fn any_loosely_less_than_or_equal(
  values values: List(Float),
  to threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.any(fn(value) { value <=. threshold +. tolerance }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if any float in the list is equal to the threshold within the given
/// tolerance and runs the consequence if one is, else runs the alternative.
///
pub fn any_loosely_equal(
  values values: List(Float),
  to threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case
    values
    |> list.any(fn(value) {
      value >=. threshold -. tolerance && value <=. threshold +. tolerance
    })
  {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if any float in the list is not equal to the threshold within the
/// given tolerance and runs the consequence if one is, else runs the
/// alternative.
///
pub fn any_not_loosely_equal(
  values values: List(Float),
  to threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case
    values
    |> list.any(fn(value) {
      value <. threshold -. tolerance || value >. threshold +. tolerance
    })
  {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if any float in the list is greater than or equal to the threshold
/// within the given tolerance and runs the consequence if one is, else runs the
/// alternative.
///
pub fn any_loosely_greater_than_or_equal(
  values values: List(Float),
  to threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.any(fn(value) { value >=. threshold -. tolerance }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if any float in the list is greater than the threshold within the
/// given tolerance and runs the consequence if one is, else runs the
/// alternative.
///
pub fn any_loosely_greater(
  values values: List(Float),
  than threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.any(fn(value) { value >. threshold +. tolerance }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if the string is empty and runs the consequence if it is, else runs
/// the alternative.
///
pub fn empty_string(
  string string: String,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case string == "" {
    True -> consequence()
    False -> alternative()
  }
}

// ┌───────────────────────────────────────────────────────────────────────────┐
// │  String                                                                   │
// └───────────────────────────────────────────────────────────────────────────┘

/// Checks if the string starts with the given substring and runs the
/// consequence if it does, else runs the alternative.
///
pub fn starts_with(
  string string: String,
  prefix prefix: String,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case string.starts_with(string, prefix) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if the string contains the given substring and runs the consequence
/// if it does, else runs the alternative.
///
pub fn contains_string(
  string string: String,
  in in: String,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case string.contains(string, in) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if the string ends with the given substring and runs the consequence
/// if it does, else runs the alternative.
///
pub fn ends_with(
  suffix suffix: String,
  in string: String,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case string.ends_with(string, suffix) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if all strings in the list start with the given prefix and runs the
/// consequence if they do, else runs the alternative.
///
pub fn all_start_with(
  prefix prefix: String,
  in strings: List(String),
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case strings |> list.all(fn(s) { string.starts_with(s, prefix) }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if any string in the list starts with the given prefix and runs the
/// consequence if one does, else runs the alternative.
///
pub fn any_start_with(
  prefix prefix: String,
  in strings: List(String),
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case strings |> list.any(fn(s) { string.starts_with(s, prefix) }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if all strings in the list end with the given suffix and runs the
/// consequence if they do, else runs the alternative.
///
pub fn all_end_with(
  suffix suffix: String,
  strings strings: List(String),
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case strings |> list.all(fn(s) { string.ends_with(s, suffix) }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if any string in the list ends with the given suffix and runs the
/// consequence if one does, else runs the alternative.
///
pub fn any_end_with(
  suffix suffix: String,
  strings strings: List(String),
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case strings |> list.any(fn(s) { string.ends_with(s, suffix) }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if all strings in the list contain the given substring and runs the
/// consequence if they do, else runs the alternative.
///
pub fn all_contain(
  string sub_string: String,
  in strings: List(String),
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case strings |> list.all(fn(s) { string.contains(s, sub_string) }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if any string in the list contains the given substring and runs the
/// consequence if one does, else runs the alternative.
///
pub fn any_contain(
  string sub_string: String,
  in strings: List(String),
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case strings |> list.any(fn(s) { string.contains(s, sub_string) }) {
    True -> consequence()
    False -> alternative()
  }
}

// ┌───────────────────────────────────────────────────────────────────────────┐
// │  Dict                                                                     │
// └───────────────────────────────────────────────────────────────────────────┘

/// Checks if the dictionary has the given key and runs the consequence if it
/// does, else runs the alternative.
///
pub fn has_key(
  dict dict: Dict(key, value),
  key key,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case dict.has_key(dict, key) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if the dictionary has the given key-value pair and runs the
/// consequence if it does, else runs the alternative.
///
pub fn has_key_value(
  dict dict: Dict(key, value),
  key key,
  value value,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case dict.get(dict, key) {
    Ok(dict_value) if dict_value == value -> consequence()
    _ -> alternative()
  }
}
