//// This library attempts to make guards:
////
//// - Applicable to `Bool`, `Result`, `Option` and `List` types.
//// - Ergonomic to use by providing ways to handle both branches early.
//// - Expressive by making it easy to read through function names and labels.
//// - Comprehensible by not having to negate the conditions.
//// - Safe to execute because:
////   - either and or branches are enforced.
////   - not running discarded branch side effects by accident (much like
////     Gleam stdlib's `bool.lazy_guard`, and unlike Gleam stdlib's
////     `bool.guard`.
////

import given/internal/lib/optionx
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/result

/// Checks if the condition is true and runs the consequence if it is, else
/// runs the alternative.
///
/// ## Examples
///
/// ```gleam
/// import given
///
/// let user_understood = True
///
/// use <- given.that(user_understood, return: fn() { "Great!" })
/// // …else handle case where user did not understand here…
/// "Woof!"
/// ```
///
/// ```gleam
/// import given.{that as given}
///
/// let user_understood = True
///
/// use <- given(user_understood, return: fn() { "Great!" })
/// // …else handle case where user did not understand here…
/// "Woof!"
/// ```
///
pub fn that(
  the_case requirement: Bool,
  return consequence: fn() -> b,
  else_return alternative: fn() -> b,
) -> b {
  case requirement {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if any of the conditions are true and runs the consequence if any
/// are, else runs the alternative.
///
/// ## Examples
///
/// ```gleam
/// import given
///
/// let is_admin = False
/// let is_editor = True
///
/// use <- given.any([is_admin, is_editor], return: fn() { "Great!" })
///
/// // …else handle case where user has no special role…
/// "Woof!"
/// ```
///
/// ```gleam
/// import given
///
/// let is_admin = False
/// let is_editor = True
///
/// use <- given.any(are_true_in: [is_admin, is_editor], return: fn() { "Great!" })
///
/// // …else handle case where user has no special role…
/// "Woof!"
/// ```
///
pub fn any(
  are_true_in requirements: List(Bool),
  return consequence: fn() -> b,
  else_return alternative: fn() -> b,
) -> b {
  case requirements |> list.any(fn(v) { v == True }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if all of the conditions are true and runs the consequence if all
/// are, else runs the alternative.
///
/// ## Examples
///
/// ```gleam
/// import given
///
/// let is_active = True
/// let is_confirmed = True
///
/// use <- given.all([is_active, is_confirmed], return: fn() { "Great!" })
///
/// // …else handle case where user is not both active and confirmed…
/// "Woof!"
/// ```
///
/// ```gleam
/// import given
///
/// let is_active = True
/// let is_confirmed = True
///
/// use <- given.all(are_true_in: [is_active, is_confirmed], return: fn() { "Great!" })
///
/// // …else handle case where user is not both active and confirmed…
/// "Woof!"
/// ```
pub fn all(
  are_true_in requirements: List(Bool),
  return consequence: fn() -> b,
  else_return alternative: fn() -> b,
) -> b {
  case requirements |> list.all(fn(v) { v == True }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if the condition is false and runs the consequence if it is, else
/// runs the alternative.
///
/// ## Examples
///
/// ```gleam
/// import given
///
/// let user_understood = True
///
/// use <- given.not(user_understood, return: fn() { "Woof!" })
///
/// // …else handle case where user understood here…
/// "Great!"
/// ```
///
/// ```gleam
/// import given
///
/// let user_understood = True
///
/// use <- given.not(the_case: user_understood, return: fn() { "Woof!" })
///
/// // …else handle case where user understood here…
/// "Great!"
/// ```
///
/// ```gleam
/// import given.{not as not_given}
///
/// let user_understood = True
///
/// use <- not_given(user_understood, return: fn() { "Woof!" })
///
/// // …else handle case where user understood here…
/// "Great!"
/// ```
///
pub fn not(
  the_case requirement: Bool,
  return consequence: fn() -> b,
  else_return alternative: fn() -> b,
) -> b {
  case requirement {
    False -> consequence()
    True -> alternative()
  }
}

/// Checks if any of the conditions are false and runs the consequence if any
/// are, else runs the alternative.
///
/// ## Examples
///
/// ```gleam
/// import given
///
/// let is_admin = False
/// let is_editor = True
///
/// use <- given.not_any([is_admin, is_editor], return: fn() { "At least either Admin or Editor!" })
///
/// // …else handle case where user no special role…
/// "Woof!"
/// ```
///
/// ```gleam
/// import given
///
/// let is_admin = False
/// let is_editor = True
///
/// use <- given.not_any(are_true_in: [is_admin, is_editor], return: fn() { "At least either Admin or Editor!" })
///
/// // …else handle case where user no special role…
/// "Woof!"
/// ```
///
pub fn any_not(
  are_true_in requirements: List(Bool),
  return consequence: fn() -> b,
  else_return alternative: fn() -> b,
) -> b {
  case requirements |> list.any(fn(v) { v == True }) {
    False -> consequence()
    True -> alternative()
  }
}

/// See `given.any_not()`
///
@deprecated("Use any_not instead")
pub fn not_any(
  are_true_in requirements: List(Bool),
  return consequence: fn() -> b,
  else_return alternative: fn() -> b,
) -> b {
  any_not(
    are_true_in: requirements,
    return: consequence,
    else_return: alternative,
  )
}

/// Checks if all of the conditions are false and runs the consequence if all
/// are, else runs the alternative.
///
/// ## Examples
///
/// ```gleam
/// import given
///
/// let is_active = True
/// let is_confirmed = True
///
/// use <- given.not_all([is_active, is_confirmed], return: fn() { "Cylone Sleeper Agent!" })
///
/// // …else handle case where user is neither active nor confirmed…
/// "Woof!"
/// ```
///
/// ```gleam
/// import given
///
/// let is_active = True
/// let is_confirmed = True
///
/// use <- given.not_all(are_true_in: [is_active, is_confirmed], return: fn() { "Cylone Sleeper Agent!" })
///
/// // …else handle case where user is neither active nor confirmed…
/// "Woof!"
///
pub fn all_not(
  are_true_in requirements: List(Bool),
  return consequence: fn() -> b,
  else_return alternative: fn() -> b,
) -> b {
  case requirements |> list.all(fn(v) { v == True }) {
    False -> consequence()
    True -> alternative()
  }
}

/// See `given.all_not`.
///
@deprecated("Use all_not instead")
pub fn not_all(
  are_true_in requirements: List(Bool),
  return consequence: fn() -> b,
  else_return alternative: fn() -> b,
) -> b {
  all_not(
    are_true_in: requirements,
    return: consequence,
    else_return: alternative,
  )
}

/// Checks if the condition function returns `True` and runs the consequence if
/// it is, else runs the alternative.
///
/// Use to lazily evaluate a complex condition and return early if they fail.
///
/// ## Examples
///
/// ```gleam
/// import given
///
/// let enabled = fn() { False }
///
/// use <- given.when(enabled, else_return: fn() { "Not an Admin" })
///
/// // …handle case where user is an Admin…
/// "Indeed an Admin"
/// ```
///
/// ```gleam
/// import given
///
/// let enabled = fn() { False }
///
/// use <- given.when(enabled, return: fn() { "Indeed an Admin" })
///
/// // …handle case where user is not an Admin…
/// "Not an Admin"
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
/// it is, else runs the alternative.
///
/// Use to lazily evaluate a complex condition and return early if they fail.
///
/// ## Examples
///
/// ```gleam
/// import given
///
/// let enabled = fn() { False }
///
/// use <- given.when_not(enabled, else_return: fn() { "Indeed an Admin" })
///
/// // …handle case where user is not an Admin…
/// "Not an Admin"
/// ```
///
/// ```gleam
/// import given
///
/// let enabled = fn() { False }
///
/// use <- given.when_not(enabled, return: fn() { "Not an Admin" })
///
/// // …handle case where user is an Admin…
/// "Indeed an Admin"
/// ```
///
pub fn when_not(
  the_case condition: fn() -> Bool,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case condition() {
    False -> consequence()
    True -> alternative()
  }
}

/// Checks if the list is empty and runs the consequence if it is, else runs
/// the alternative.
///
/// ## Examples
///
/// ```gleam
/// import given
///
/// let list = []
///
/// use <- given.empty(list, else_return: fn() { "Non-empty" })
///
/// // …handle empty list here…
/// "Empty"
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

/// See `given.not_empty`.
///
@deprecated("Use not_empty instead")
pub fn non_empty(
  list list: List(a),
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  not_empty(list: list, else_return: alternative, return: consequence)
}

/// Checks if the list is non-empty and runs the consequence if it is, else
/// runs the alternative.
///
/// ## Examples
///
/// ```gleam
/// import given
///
/// let list = []
///
/// use <- given.not_empty(list, else_return: fn() { "Empty" })
///
/// // …handle non-empty list here…
/// "Non-empty"
/// ```
///
pub fn not_empty(
  list list: List(a),
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case list {
    [] -> alternative()
    _not_empty -> consequence()
  }
}

/// Checks if the result is an `Ok` and runs the consequence if it is, else
/// runs the alternative.
///
/// ## Examples
///
/// ```gleam
/// import given
///
/// let result = Ok("Great")
///
/// use ok_value <- given.ok(in: result, else_return: fn(error_value) { "Error" })
///
/// // …handle Ok value here…
/// "Ok"
/// ```
///
/// ```gleam
/// import given.{ok as given_ok_in}
///
/// let result = Ok("Great")
///
/// use ok_value <- given_ok_in(result, else_return: fn(error_value) { "Error" })
///
/// // …handle Ok value here…
/// "Ok"
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

/// Checks if any of the results are `Ok` and runs the consequence -  passing in
/// the `Ok` and `Error` values - if they are, else runs the alternative passing
/// in all `Error` values.
///
/// ## Examples
///
/// ```gleam
/// import given
///
/// let results = [Ok("Great"), Error("Bad")]
///
/// use _oks, _errors <- given.any_ok(in: results, else_return: fn(_errors) { "All Errors" })
///
/// // …handle at least some OKs here…
/// "At least some OKs"
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
/// the `Ok` values - if they are, else runs the alternative passing in all
/// `Ok` and `Error` values.
///
/// ## Examples
///
/// ```gleam
/// import given
///
/// let results = [Ok("Great"), Error("Bad")]
///
/// use oks <- given.all_ok(in: results, else_return: fn(_oks, _errors) { "Some Errors" })
///
/// // …handle all OKs here…
/// "All OKs"
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
/// import given
///
/// let result = Error(Nil)
///
/// use error_value <- given.error(in: result, else_return: fn(ok_value) { "Ok" })
///
/// // …handle Error value here…
/// "Error"
/// ```
///
/// ```gleam
/// import given.{error as given_error_in}
///
/// let result = Error(Nil)
///
/// use error_value <- given_error_in(result, else_return: fn(ok_value) { "Ok" })
///
/// // …handle Error value here…
/// "Error"
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

/// Checks if any of the results are `Error` and runs the consequence - passing
/// in the `Ok` and `Error` values - if they are, else runs the alternative
/// passing in all `Ok` values.
///
/// ## Examples
///
/// ```gleam
/// import given
///
/// let results = [Ok("Great"), Error("Bad")]
///
/// use _oks, _errors <- given.any_error(in: results, else_return: fn(_oks) { "Only OKs" })
///
/// // …handle at least some Errors here…
/// "At least some Errors"
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
/// in the `Error` values - if they are, else runs the alternative passing in
/// all `Ok` and `Error` values.
///
/// ## Examples
///
/// ```gleam
/// import given
///
/// let results = [Ok("Great"), Error("Bad")]
///
/// use _errors <- given.all_error(in: results, else_return: fn(_oks, _errors) { "Only some Errors" })
///
/// // …handle all errors here…
/// "All Errors"
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

/// Checks if the option is `Some` and runs the consequence if it is, else runs
/// the alternative.
///
/// ## Examples
///
/// ```gleam
/// import given
/// import gleam/option.{Some}
///
/// let option = Some("One")
///
/// use some_value <- given.some(in: option, else_return: fn() { "None" })
///
/// // …handle Some value here…
/// "Some value"
/// ```
///
/// ```gleam
/// import given.{some as given_some_in}
/// import gleam/option.{Some}
///
/// let option = Some("One")
///
/// use some_value <- given_some_in(option, else_return: fn() { "None" })
///
/// // …handle Some value here…
/// "Some value"
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

/// Checks if any of the options are `Some` and runs the consequence - passing
/// in the `Some` values and a count of the `None` values - if they are, else
/// runs the alternative passing in the count of `None` values.
///
/// ## Examples
///
/// ```gleam
/// import given
///
/// let options = [Some("One"), None]
///
/// use _somes, _nones_count <- given.any_some(in: options, else_return: fn(_nones_count) { "All are None" })
///
/// // …handle at least some None values here…
/// "At least some are None"
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
/// in the `Some` values - if they are, else runs the alternative passing in
/// the `Some` and a count of the `None` values.
///
/// ## Examples
///
/// ```gleam
/// import given
///
/// let options = [Some("One"), None]
///
/// use _somes <- given.all_some(in: options, else_return: fn(_somes, _nones_count) { "Some are None" })
///
/// // …handle all Some values here…
/// "All are Some"
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

/// Checks if the option is `None` and runs the consequence if it is, else runs
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
/// import given.{none as given_none_in}
/// import gleam/option.{None}
///
/// let option = None
///
/// use <- given_none_in(option, else_return: fn(some_value) { "Some value" })
/// // …handle None here…
///
/// "None"
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

/// Checks if any of the options are `None` and runs the consequence if they
/// are, else runs the alternative passing in the `Some` values and the count
/// of `None` values.
///
/// ## Examples
///
/// ```gleam
/// import given
///
/// let options = [Some("One"), None]
///
/// use <- given.any_none(in: options, else_return: fn(_somes) { "All are Some" })
///
/// // …handle at least some None values here…
/// "At least some are None"
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
/// are, else runs the alternative passing in the `Some` values.
///
/// ## Examples
///
/// ```gleam
/// import given
///
/// let options = [Some("One"), None]
///
/// use <- given.all_none(in: options, else_return: fn(_somes, _nones_count) { "Some are Some" })
///
/// // …handle all None values here…
/// "All are None"
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
