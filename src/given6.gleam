import gleam/dict.{type Dict}
import gleam/list
import gleam/string

// // List(Int):

// given.one_*
// given.n_*

// // List(Float) with tolerating:

// given.one_*
// given.n_*

// Integer comparison functions
/// Checks if the first integer is less than the second and runs the consequence if it is, else
/// runs the alternative.
///
pub fn less(
  the_value value: Int,
  than threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case value < threshold {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if the first integer is less than or equal to the second and runs the consequence if it is, else
/// runs the alternative.
///
pub fn less_than_or_equal(
  the_value value: Int,
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case value <= threshold {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if the first integer is equal to the second and runs the consequence if it is, else
/// runs the alternative.
///
pub fn equal(
  the_value value: Int,
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case value == threshold {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if the first integer is greater than or equal to the second and runs the consequence if it is, else
/// runs the alternative.
///
pub fn greater_than_or_equal(
  the_value value: Int,
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case value >= threshold {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if the first integer is greater than the second and runs the consequence if it is, else
/// runs the alternative.
///
pub fn greater(
  the_value value: Int,
  than threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case value > threshold {
    True -> consequence()
    False -> alternative()
  }
}

// List of integers comparison functions
/// Checks if all integers in the list are less than the threshold and runs the consequence if they are, else
/// runs the alternative.
///
pub fn all_less(
  the_values values: List(Int),
  than threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.all(fn(value) { value < threshold }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if all integers in the list are less than or equal to the threshold and runs the consequence if they are, else
/// runs the alternative.
///
pub fn all_less_than_or_equal(
  the_values values: List(Int),
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.all(fn(value) { value <= threshold }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if all integers in the list are equal to the threshold and runs the consequence if they are, else
/// runs the alternative.
///
pub fn all_equal(
  the_values values: List(Int),
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.all(fn(value) { value == threshold }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if all integers in the list are not equal to the threshold and runs the consequence if they are, else
/// runs the alternative.
///
pub fn all_not_equal(
  the_values values: List(Int),
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.all(fn(value) { value != threshold }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if all integers in the list are greater than or equal to the threshold and runs the consequence if they are, else
/// runs the alternative.
///
pub fn all_greater_than_or_equal(
  the_values values: List(Int),
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.all(fn(value) { value >= threshold }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if all integers in the list are greater than the threshold and runs the consequence if they are, else
/// runs the alternative.
///
pub fn all_greater(
  the_values values: List(Int),
  than threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.all(fn(value) { value > threshold }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if any integer in the list is less than the threshold and runs the consequence if one is, else
/// runs the alternative.
///
pub fn any_less(
  the_values values: List(Int),
  than threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.any(fn(value) { value < threshold }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if any integer in the list is less than or equal to the threshold and runs the consequence if one is, else
/// runs the alternative.
///
pub fn any_less_than_or_equal(
  the_values values: List(Int),
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.any(fn(value) { value <= threshold }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if any integer in the list is equal to the threshold and runs the consequence if one is, else
/// runs the alternative.
///
pub fn any_equal(
  the_values values: List(Int),
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.any(fn(value) { value == threshold }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if any integer in the list is not equal to the threshold and runs the consequence if one is, else
/// runs the alternative.
///
pub fn any_not_equal(
  the_values values: List(Int),
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.any(fn(value) { value != threshold }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if any integer in the list is greater than or equal to the threshold and runs the consequence if one is, else
/// runs the alternative.
///
pub fn any_greater_than_or_equal(
  the_values values: List(Int),
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.any(fn(value) { value >= threshold }) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if any integer in the list is greater than the threshold and runs the consequence if one is, else
/// runs the alternative.
///
pub fn any_greater(
  the_values values: List(Int),
  than threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case values |> list.any(fn(value) { value > threshold }) {
    True -> consequence()
    False -> alternative()
  }
}

// Float comparison functions with tolerance
/// Checks if the first float is less than the second within the given tolerance and runs the consequence if it is, else
/// runs the alternative.
///
pub fn loosely_less(
  the_value value: Float,
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

/// Checks if the first float is less than or equal to the second within the given tolerance and runs the consequence if it is, else
/// runs the alternative.
///
pub fn loosely_less_than_or_equal(
  the_value value: Float,
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

/// Checks if the first float is equal to the second within the given tolerance and runs the consequence if it is, else
/// runs the alternative.
///
pub fn loosely_equal(
  the_value value: Float,
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

/// Checks if the first float is greater than or equal to the second within the given tolerance and runs the consequence if it is, else
/// runs the alternative.
///
pub fn loosely_greater_than_or_equal(
  the_value value: Float,
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

/// Checks if the first float is greater than the second within the given tolerance and runs the consequence if it is, else
/// runs the alternative.
///
pub fn loosely_greater(
  the_value value: Float,
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

// List of floats comparison functions with tolerance
/// Checks if all floats in the list are less than the threshold within the given tolerance and runs the consequence if they are, else
/// runs the alternative.
///
pub fn all_loosely_less(
  the_values values: List(Float),
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

/// Checks if all floats in the list are less than or equal to the threshold within the given tolerance and runs the consequence if they are, else
/// runs the alternative.
///
pub fn all_loosely_less_than_or_equal(
  the_values values: List(Float),
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

/// Checks if all floats in the list are equal to the threshold within the given tolerance and runs the consequence if they are, else
/// runs the alternative.
///
pub fn all_loosely_equal(
  the_values values: List(Float),
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

/// Checks if all floats in the list are not equal to the threshold within the given tolerance and runs the consequence if they are, else
/// runs the alternative.
///
pub fn all_not_loosely_equal(
  the_values values: List(Float),
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

/// Checks if all floats in the list are greater than or equal to the threshold within the given tolerance and runs the consequence if they are, else
/// runs the alternative.
///
pub fn all_loosely_greater_than_or_equal(
  the_values values: List(Float),
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

/// Checks if all floats in the list are greater than the threshold within the given tolerance and runs the consequence if they are, else
/// runs the alternative.
///
pub fn all_loosely_greater(
  the_values values: List(Float),
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

/// Checks if any float in the list is less than the threshold within the given tolerance and runs the consequence if one is, else
/// runs the alternative.
///
pub fn any_loosely_less(
  the_values values: List(Float),
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

/// Checks if any float in the list is less than or equal to the threshold within the given tolerance and runs the consequence if one is, else
/// runs the alternative.
///
pub fn any_loosely_less_than_or_equal(
  the_values values: List(Float),
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

/// Checks if any float in the list is equal to the threshold within the given tolerance and runs the consequence if one is, else
/// runs the alternative.
///
pub fn any_loosely_equal(
  the_values values: List(Float),
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

/// Checks if any float in the list is not equal to the threshold within the given tolerance and runs the consequence if one is, else
/// runs the alternative.
///
pub fn any_not_loosely_equal(
  the_values values: List(Float),
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

/// Checks if any float in the list is greater than or equal to the threshold within the given tolerance and runs the consequence if one is, else
/// runs the alternative.
///
pub fn any_loosely_greater_than_or_equal(
  the_values values: List(Float),
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

/// Checks if any float in the list is greater than the threshold within the given tolerance and runs the consequence if one is, else
/// runs the alternative.
///
pub fn any_loosely_greater(
  the_values values: List(Float),
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

// String operations
/// Checks if the string is empty and runs the consequence if it is, else
/// runs the alternative.
///
pub fn empty_string(
  the_string string: String,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case string == "" {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if the string starts with the given substring and runs the consequence if it does, else
/// runs the alternative.
///
pub fn starts_with(
  the_string string: String,
  head prefix: String,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case string.starts_with(string, prefix) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if the string contains the given substring and runs the consequence if it does, else
/// runs the alternative.
///
pub fn contains(
  the_string string: String,
  sub substring: String,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case string.contains(string, substring) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if the string ends with the given substring and runs the consequence if it does, else
/// runs the alternative.
///
pub fn ends_with(
  the_string string: String,
  tail suffix: String,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case string.ends_with(string, suffix) {
    True -> consequence()
    False -> alternative()
  }
}

// Dictionary operations
/// Checks if the dictionary has the given key and runs the consequence if it does, else
/// runs the alternative.
///
pub fn has_key(
  the_dict dict: Dict(key, value),
  key key,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case dict.has_key(dict, key) {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if the dictionary has the given key-value pair and runs the consequence if it does, else
/// runs the alternative.
///
pub fn has_key_value(
  the_dict dict: Dict(key, value),
  key key,
  value value,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  case dict.get(dict, key) {
    Ok(val) if val == value -> consequence()
    _ -> alternative()
  }
}
