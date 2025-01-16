//// This library attempts to make guards:
////
//// - Applicable to `Bool`, `Result` and `Option` types.
//// - Ergonomic to use by providing ways to handle both branches early.
//// - Expressive by making it easy to read through function names and labels.
//// - Comprehendable by not having to negate the conditions.
//// - Safe to use by not accidentally running discarded branches much like
////   `bool.lazy_guard`.
////

import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/result

/// ## Examples
///
/// ```gleam
/// import given
/// import gleam/int
/// let user_understood = case int.random(1) {
///   1 -> True
///   _ -> False
/// }
///
/// use <- given.that(user_understood, return: fn() { "Great!" })
/// // …else handle case where user did not understand here…
/// "Woof!"
/// ```
///
/// ```gleam
/// import given.{that as given}
/// import gleam/int
/// let user_understood = case int.random(1) {
///   1 -> True
///   _ -> False
/// }
///
/// use <- given(user_understood, return: fn() { "Great!" })
/// // …else handle case where user did not understand here…
/// "Woof!"
/// ```
///
pub fn that(
  the_case requirement: Bool,
  return consequence: fn() -> a,
  else_return alternative: fn() -> a,
) -> a {
  case requirement {
    True -> consequence()
    False -> alternative()
  }
}

/// ## Examples
///
/// ```gleam
/// import given
/// let is_admin = False
/// let is_editor = True
///
/// use <- given.any(true_of: [is_admin, is_editor], return: fn() { "Great!" })
/// // …else handle case where user has no special role…
/// "Woof!"
/// ```
///
pub fn any(
  true_of requirements: List(Bool),
  return consequence: fn() -> a,
  else_return alternative: fn() -> a,
) -> a {
  case requirements |> list.any(fn(v) { v == True }) {
    True -> consequence()
    False -> alternative()
  }
}

/// ## Examples
///
/// ```gleam
/// import given
/// let is_active = True
/// let is_confirmed = True
///
/// use <- given.all([is_active, is_confirmed], return: fn() { "Great!" })
/// // …else handle case where user is not both active and confirmed…
/// "Woof!"
/// ```
///
pub fn all(
  true_of requirements: List(Bool),
  return consequence: fn() -> a,
  else_return alternative: fn() -> a,
) -> a {
  case requirements |> list.all(fn(v) { v == True }) {
    True -> consequence()
    False -> alternative()
  }
}

/// ## Examples
///
/// ```gleam
/// import given
/// import gleam/int
/// let user_understood = case int.random(1) {
///   1 -> True
///   _ -> False
/// }
///
/// use <- given.not(user_understood, return: fn() { "Woof!" })
/// // …else handle case where user understood here…
/// "Great!"
/// ```
///
/// ```gleam
/// import given.{not as not_given}
/// import gleam/int
/// let user_understood = case int.random(1) {
///   1 -> True
///   _ -> False
/// }
///
/// use <- not_given(user_understood, return: fn() { "Woof!" })
/// // …else handle case where user understood here…
/// "Great!"
/// ```
pub fn not(
  the_case requirement: Bool,
  return consequence: fn() -> a,
  else_return alternative: fn() -> a,
) -> a {
  case requirement {
    False -> consequence()
    True -> alternative()
  }
}

/// ## Examples
///
/// ```gleam
/// import given
/// let is_admin = False
/// let is_editor = True
///
/// use <- given.not_any([is_admin, is_editor], return: fn() { "At least either Admin or Editor!" })
/// // …else handle case where user no special role…
/// "Woof!"
/// ```
///
/// ```gleam
/// import given
/// let is_admin = False
/// let is_editor = True
///
/// use <- given.not_any(true_of: [is_admin, is_editor], return: fn() { "At least either Admin or Editor!" })
/// // …else handle case where user no special role…
/// "Woof!"
/// ```
///
pub fn not_any(
  true_of requirements: List(Bool),
  return consequence: fn() -> a,
  else_return alternative: fn() -> a,
) -> a {
  case requirements |> list.any(fn(v) { v == True }) {
    False -> consequence()
    True -> alternative()
  }
}

/// ## Examples
///
/// ```gleam
/// import given.{given_all}
/// let is_active = True
/// let is_confirmed = True
///
/// use <- given.not_all([is_active, is_confirmed], return: fn() { "Cylone Sleeper Agent!" })
/// // …else handle case where user is neither active nor confirmed…
/// "Woof!"
/// ```
///
/// ```gleam
/// import given.{given_all}
/// let is_active = True
/// let is_confirmed = True
///
/// use <- given.not_all(true_of: [is_active, is_confirmed], return: fn() { "Cylone Sleeper Agent!" })
/// // …else handle case where user is neither active nor confirmed…
/// "Woof!"
///
pub fn not_all(
  true_of requirements: List(Bool),
  return consequence: fn() -> a,
  else_return alternative: fn() -> a,
) -> a {
  case requirements |> list.all(fn(v) { v == True }) {
    False -> consequence()
    True -> alternative()
  }
}

/// ## Examples
///
/// ```gleam
/// import given
/// let result = Ok("Great")
///
/// use ok_value <- given.ok(in: result, else_return: fn(error_value) { "Error" })
/// // …handle Ok value here…
/// "Ok"
/// ```
///
/// ```gleam
/// import given.{ok as given_ok_in}
/// let result = Ok("Great")
///
/// use ok_value <- given_ok_in(result, else_return: fn(error_value) { "Error" })
/// // …handle Ok value here…
/// "Ok"
/// ```
pub fn ok(
  in rslt: Result(a, e),
  else_return alternative: fn(e) -> c,
  return consequence: fn(a) -> c,
) -> c {
  case rslt {
    Ok(val) -> consequence(val)
    Error(err) -> alternative(err)
  }
}

// TODO: Examples
//
pub fn all_ok(
  of rslts: List(Result(a, e)),
  else_return alternative: fn(List(a), List(e)) -> c,
  return consequence: fn(List(a)) -> c,
) -> c {
  let #(oks, errors) = rslts |> result.partition

  case errors {
    [] -> consequence(oks)
    _some_errors -> alternative(oks, errors)
  }
}

// TODO: Examples
//
pub fn any_ok(
  of rslts: List(Result(a, e)),
  else_return alternative: fn(List(e)) -> c,
  return consequence: fn(List(a), List(e)) -> c,
) -> c {
  let #(oks, errors) = rslts |> result.partition

  case oks {
    [] -> alternative(errors)
    _some_errors -> consequence(oks, errors)
  }
}

/// ## Examples
///
/// ```gleam
/// import given
/// let result = Error(Nil)
///
/// use error_value <- given.error(in: result, else_return: fn(ok_value) { "Ok" })
/// // …handle Error value here…
/// "Error"
/// ```
///
/// ```gleam
/// import given.{error as given_error_in}
/// let result = Error(Nil)
///
/// use error_value <- given_error_in(result, else_return: fn(ok_value) { "Ok" })
/// // …handle Error value here…
/// "Error"
/// ```
///
pub fn error(
  in rslt: Result(a, e),
  else_return alternative: fn(a) -> c,
  return consequence: fn(e) -> c,
) -> c {
  case rslt {
    Error(err) -> consequence(err)
    Ok(val) -> alternative(val)
  }
}

// TODO: Examples
//
pub fn all_error(
  of rslts: List(Result(a, e)),
  else_return alternative: fn(List(a), List(e)) -> c,
  return consequence: fn(List(e)) -> c,
) -> c {
  let #(oks, errors) = rslts |> result.partition

  case oks {
    [] -> alternative(oks, errors)
    _some_errors -> consequence(errors)
  }
}

// TODO: Examples
//
pub fn any_error(
  of rslts: List(Result(a, e)),
  else_return alternative: fn(List(a), List(e)) -> c,
  return consequence: fn(List(e)) -> c,
) -> c {
  let #(oks, errors) = rslts |> result.partition

  case errors {
    [] -> alternative(oks, errors)
    _some_errors -> consequence(errors)
  }
}

/// ## Examples
///
/// ```gleam
/// import given
/// import gleam/option.{Some}
/// let option = Some("One")
///
/// use some_value <- given.some(in: option, else_return: fn() { "None" })
/// // …handle Some value here…
/// "Some value"
/// ```
///
/// ```gleam
/// import given.{some as given_some_in}
/// import gleam/option.{Some}
/// let option = Some("One")
///
/// use some_value <- given_some_in(option, else_return: fn() { "None" })
/// // …handle Some value here…
/// "Some value"
/// ```
///
pub fn some(
  in optn: Option(a),
  else_return alternative: fn() -> c,
  return consequence: fn(a) -> c,
) -> c {
  case optn {
    Some(val) -> consequence(val)
    None -> alternative()
  }
}

// TODO: Examples
//
pub fn all_some(
  of optns: List(Option(a)),
  else_return alternative: fn(List(a), Int) -> c,
  return consequence: fn(List(a)) -> c,
) -> c {
  let #(somes, nones) = optns |> option_partition

  case nones {
    [] -> consequence(somes)
    _nones -> alternative(somes, nones |> list.length)
  }
}

// TODO: Examples
//
pub fn any_some(
  of optns: List(Option(a)),
  else_return alternative: fn(List(a), Int) -> c,
  return consequence: fn(List(a)) -> c,
) -> c {
  let #(somes, nones) = optns |> option_partition

  case somes {
    [] -> alternative(somes, nones |> list.length)
    _somes -> consequence(somes)
  }
}

/// ## Examples
///
/// ```gleam
/// import given
/// import gleam/option.{None}
/// let option = None
///
/// use <- given.none(in: option, else_return: fn(some_value) { "Some value" })
/// // …handle None here…
/// "None"
/// ```
///
/// ```gleam
/// import given.{none as given_none_in}
/// import gleam/option.{None}
/// let option = None
///
/// use <- given_none_in(option, else_return: fn(some_value) { "Some value" })
/// // …handle None here…
/// "None"
/// ```
///
pub fn none(
  in optn: Option(a),
  else_return alternative: fn(a) -> c,
  return consequence: fn() -> c,
) -> c {
  case optn {
    None -> consequence()
    Some(val) -> alternative(val)
  }
}

// TODO: Examples
//
pub fn all_none(
  of optns: List(Option(a)),
  else_return alternative: fn(List(a), Int) -> c,
  return consequence: fn() -> c,
) -> c {
  let #(somes, nones) = optns |> option_partition

  case somes {
    [] -> consequence()
    _somes -> alternative(somes, nones |> list.length)
  }
}

// TODO: Examples
//
pub fn any_none(
  of optns: List(Option(a)),
  else_return alternative: fn(List(a), Int) -> c,
  return consequence: fn() -> c,
) -> c {
  let #(somes, nones) = optns |> option_partition

  case nones {
    [] -> alternative(somes, nones |> list.length)
    _nones -> consequence()
  }
}

/// Given a list of options, returns a pair where the first element is a list
/// of all the values inside `Some` and the second element is a list with all
/// the values None values. The values in both lists appear in reverse order
/// with respect to their position in the original list of options.
///
/// ## Examples
///
/// ```gleam
/// option_partition([Some(1), None, None, Some(2)])
/// // -> #([2, 1], [None, None])
/// ```
///
fn option_partition(options: List(Option(a))) -> #(List(a), List(e)) {
  option_partition_loop(options, [], [])
}

fn option_partition_loop(
  options: List(Option(a)),
  oks: List(a),
  errors: List(e),
) {
  case options {
    [] -> #(oks, errors)
    [Some(a), ..rest] -> option_partition_loop(rest, [a, ..oks], errors)
    [None, ..rest] -> option_partition_loop(rest, oks, [e, ..errors])
  }
}
