//// This library attempts to make guards:
////
//// - Applicable to `Bool`, `Result` and `Option` types.
//// - Ergonomic to use by providing ways to handle both branches early.
//// - Expressive by making it easy to read through function names and labels.
//// - Comprehendable by not having to negate the conditions.
//// - Safe to use by not accidentally running discarded branches much like
////   `bool.lazy_guard`.
////

import gleam/option.{type Option, None, Some}

/// ## Examples
///
/// ```gleam
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
pub fn given(
  requirement: Bool,
  return consequence: fn() -> a,
  otherwise alternative: fn() -> a,
) -> a {
  case requirement {
    True -> consequence()
    False -> alternative()
  }
}

/// ## Examples
///
/// ```gleam
/// let user_understood = case int.random(1) {
///   1 -> True
///   _ -> False
/// }
///
/// use <- not_given(user_understood, return: fn() { "Woof!" })
/// // …else handle case where user understood here…
/// "Great!"
/// ```
///
pub fn not_given(
  requirement: Bool,
  return consequence: fn() -> a,
  otherwise alternative: fn() -> a,
) -> a {
  case !requirement {
    True -> consequence()
    False -> alternative()
  }
}

/// ## Examples
///
/// ```gleam
/// use ok_value <- given_ok_in(result, else_return: fn(error_value) { "Error" })
/// // …handle Ok value here…
/// "Ok"
/// ```
///
pub fn given_ok_in(
  result result: Result(a, e),
  else_return alternative: fn(a) -> c,
  otherwise consequence: fn(e) -> c,
) -> c {
  case result {
    Ok(value) -> alternative(value)
    Error(error) -> consequence(error)
  }
}

/// ## Examples
///
/// ```gleam
/// use error_value <- given_error_in(result, else_return: fn(ok_value) { "Ok" })
/// // …handle Error value here…
/// "Error"
/// ```
///
pub fn given_error_in(
  result result: Result(a, e),
  else_return consequence: fn(a) -> c,
  otherwise alternative: fn(e) -> c,
) -> c {
  case result {
    Ok(value) -> consequence(value)
    Error(error) -> alternative(error)
  }
}

/// ## Examples
///
/// ```gleam
/// use some_value <- given_some_in(option, else_return: fn() { "None" })
/// // …handle Some value here…
/// "Some value"
/// ```
///
pub fn given_some_in(
  option option: Option(a),
  else_return consequence: fn() -> c,
  otherwise alternative: fn(a) -> c,
) -> c {
  case option {
    Some(value) -> alternative(value)
    None -> consequence()
  }
}

/// ## Examples
///
/// ```gleam
/// use none_value <- given_none_in(option, else_return: fn(some_value) { "Some value" })
/// // …handle None value here…
/// "None"
/// ```
///
pub fn given_none_in(
  option option: Option(a),
  else_return consequence: fn(a) -> c,
  otherwise alternative: fn() -> c,
) -> c {
  case option {
    Some(value) -> consequence(value)
    None -> alternative()
  }
}
