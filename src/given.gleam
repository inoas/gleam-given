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
/// import given.{given}
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
pub fn given(
  requirement: Bool,
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
/// import given.{not_given}
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
///
pub fn not_given(
  requirement: Bool,
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
/// let result = Ok("Great")
///
/// use ok_value <- given.ok_in(result, else_return: fn(error_value) { "Error" })
/// // …handle Ok value here…
/// "Ok"
/// ```
///
pub fn ok_in(
  result rslt: Result(a, e),
  else_return alternative: fn(e) -> c,
  return consequence: fn(a) -> c,
) -> c {
  case rslt {
    Ok(val) -> consequence(val)
    Error(err) -> alternative(err)
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

/// ## Examples
///
/// ```gleam
/// import given
/// let result = Error(Nil)
///
/// use error_value <- given.error_in(result, else_return: fn(ok_value) { "Ok" })
/// // …handle Error value here…
/// "Error"
/// ```
///
pub fn error_in(
  result rslt: Result(a, e),
  else_return alternative: fn(a) -> c,
  return consequence: fn(e) -> c,
) -> c {
  case rslt {
    Error(err) -> consequence(err)
    Ok(val) -> alternative(val)
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

/// ## Examples
///
/// ```gleam
/// import given
/// import gleam/option.{Some}
/// let option = Some("One")
///
/// use some_value <- given.some_in(option, else_return: fn() { "None" })
/// // …handle Some value here…
/// "Some value"
/// ```
///
pub fn some_in(
  option optn: Option(a),
  else_return alternative: fn() -> c,
  return consequence: fn(a) -> c,
) -> c {
  case optn {
    Some(val) -> consequence(val)
    None -> alternative()
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

/// ## Examples
///
/// ```gleam
/// import given
/// import gleam/option.{None}
/// let option = None
///
/// use <- given.none_in(option, else_return: fn(some_value) { "Some value" })
/// // …handle None here…
/// "None"
/// ```
///
pub fn none_in(
  option optn: Option(a),
  else_return alternative: fn(a) -> c,
  return consequence: fn() -> c,
) -> c {
  case optn {
    None -> consequence()
    Some(val) -> alternative(val)
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
