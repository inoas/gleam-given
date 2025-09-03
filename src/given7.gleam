//// This file contains additional functionality for the given library,
//// focusing on counting exact numbers of elements that match conditions.
////

import gleam/list

//
// LIST(BOOL) FUNCTIONS
//

/// Checks if exactly n of the conditions are `True` and runs the consequence if so,
/// otherwise runs the alternative.
///
/// ## Examples
///
/// ```gleam
/// let condition1 = True
/// let condition2 = False
/// let condition3 = True
///
/// use <- given.n(2, in: [condition1, condition2, condition3], else_return: fn() { "Not exactly 2!" })
///
/// "✅ Exactly 2 conditions are true!"
/// ```
///
pub fn n(
  exactly count: Int,
  in requirements: List(Bool),
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let true_count = list.filter(requirements, fn(v) { v == True }) |> list.length
  case true_count == count {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if between n and m of the conditions are `True` and runs the consequence if so,
/// otherwise runs the alternative.
///
/// ## Examples
///
/// ```gleam
/// let conditions = [True, False, True, True, False]
///
/// use <- given.n_to_m(2, 4, in: conditions, else_return: fn() { "Not between 2-4!" })
///
/// "✅ Between 2 and 4 conditions are true!"
/// ```
///
pub fn n_to_m(
  at_least min: Int,
  at_most max: Int,
  in requirements: List(Bool),
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let true_count = list.filter(requirements, fn(v) { v == True }) |> list.length
  case true_count >= min && true_count <= max {
    True -> consequence()
    False -> alternative()
  }
}

//
// GENERIC LIST FUNCTIONS
//

/// Checks if exactly n elements in the list satisfy the predicate function
/// and runs the consequence if so, otherwise runs the alternative.
///
/// ## Examples
///
/// ```gleam
/// let numbers = [1, 2, 3, 4, 5]
///
/// use <- given.n_satisfy(2, in: numbers, where: fn(x) { x > 3 }, else_return: fn() { "Not 2 elements > 3" })
///
/// "✅ Exactly 2 numbers are greater than 3!"
/// ```
///
pub fn n_satisfy(
  exactly count: Int,
  in values: List(a),
  where predicate: fn(a) -> Bool,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count = list.filter(values, predicate) |> list.length
  case matching_count == count {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if at least n elements in the list satisfy the predicate function
/// and runs the consequence if so, otherwise runs the alternative.
///
pub fn at_least_n_satisfy(
  min count: Int,
  in values: List(a),
  where predicate: fn(a) -> Bool,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count = list.filter(values, predicate) |> list.length
  case matching_count >= count {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if at most n elements in the list satisfy the predicate function
/// and runs the consequence if so, otherwise runs the alternative.
///
pub fn at_most_n_satisfy(
  max count: Int,
  in values: List(a),
  where predicate: fn(a) -> Bool,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count = list.filter(values, predicate) |> list.length
  case matching_count <= count {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if between min and max elements (inclusive) in the list satisfy the predicate function
/// and runs the consequence if so, otherwise runs the alternative.
///
pub fn between_n_satisfy(
  min min_count: Int,
  and max_count: Int,
  in values: List(a),
  where predicate: fn(a) -> Bool,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count = list.filter(values, predicate) |> list.length
  case matching_count >= min_count && matching_count <= max_count {
    True -> consequence()
    False -> alternative()
  }
}

//
// LIST(INT) FUNCTIONS
//
/// Checks if exactly n integers in the list are less than the threshold and runs the consequence if so,
/// otherwise runs the alternative.
///
pub fn n_less(
  exactly count: Int,
  in values: List(Int),
  than threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count =
    list.filter(values, fn(value) { value < threshold }) |> list.length
  case matching_count == count {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if exactly n integers in the list are less than or equal to the threshold and runs the consequence if so,
/// otherwise runs the alternative.
///
pub fn n_less_than_or_equal(
  exactly count: Int,
  in values: List(Int),
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count =
    list.filter(values, fn(value) { value <= threshold }) |> list.length
  case matching_count == count {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if exactly n integers in the list are equal to the threshold and runs the consequence if so,
/// otherwise runs the alternative.
///
pub fn n_equal(
  exactly count: Int,
  in values: List(Int),
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count =
    list.filter(values, fn(value) { value == threshold }) |> list.length
  case matching_count == count {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if exactly n integers in the list are not equal to the threshold and runs the consequence if so,
/// otherwise runs the alternative.
///
pub fn n_not_equal(
  exactly count: Int,
  in values: List(Int),
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count =
    list.filter(values, fn(value) { value != threshold }) |> list.length
  case matching_count == count {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if exactly n integers in the list are greater than or equal to the threshold and runs the consequence if so,
/// otherwise runs the alternative.
///
pub fn n_greater_than_or_equal(
  exactly count: Int,
  in values: List(Int),
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count =
    list.filter(values, fn(value) { value >= threshold }) |> list.length
  case matching_count == count {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if exactly n integers in the list are greater than the threshold and runs the consequence if so,
/// otherwise runs the alternative.
///
pub fn n_greater(
  exactly count: Int,
  in values: List(Int),
  than threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count =
    list.filter(values, fn(value) { value > threshold }) |> list.length
  case matching_count == count {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if between n and m integers in the list are less than the threshold and runs the consequence if so,
/// otherwise runs the alternative.
///
pub fn n_to_m_less(
  at_least min: Int,
  at_most max: Int,
  in values: List(Int),
  than threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count =
    list.filter(values, fn(value) { value < threshold }) |> list.length
  case matching_count >= min && matching_count <= max {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if between n and m integers in the list are less than or equal to the threshold and runs the consequence if so,
/// otherwise runs the alternative.
///
pub fn n_to_m_less_than_or_equal(
  at_least min: Int,
  at_most max: Int,
  in values: List(Int),
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count =
    list.filter(values, fn(value) { value <= threshold }) |> list.length
  case matching_count >= min && matching_count <= max {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if between n and m integers in the list are equal to the threshold and runs the consequence if so,
/// otherwise runs the alternative.
///
pub fn n_to_m_equal(
  at_least min: Int,
  at_most max: Int,
  in values: List(Int),
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count =
    list.filter(values, fn(value) { value == threshold }) |> list.length
  case matching_count >= min && matching_count <= max {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if between n and m integers in the list are not equal to the threshold and runs the consequence if so,
/// otherwise runs the alternative.
///
pub fn n_to_m_not_equal(
  at_least min: Int,
  at_most max: Int,
  in values: List(Int),
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count =
    list.filter(values, fn(value) { value != threshold }) |> list.length
  case matching_count >= min && matching_count <= max {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if between n and m integers in the list are greater than or equal to the threshold and runs the consequence if so,
/// otherwise runs the alternative.
///
pub fn n_to_m_greater_than_or_equal(
  at_least min: Int,
  at_most max: Int,
  in values: List(Int),
  to threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count =
    list.filter(values, fn(value) { value >= threshold }) |> list.length
  case matching_count >= min && matching_count <= max {
    True -> consequence()
    False -> alternative()
  }
}

//
// LIST(FLOAT) FUNCTIONS
//

/// Checks if exactly n floats in the list are less than the threshold within the given tolerance
/// and runs the consequence if so, otherwise runs the alternative.
///
pub fn n_loosely_less(
  exactly count: Int,
  in values: List(Float),
  than threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count =
    list.filter(values, fn(value) { value <. threshold -. tolerance })
    |> list.length
  case matching_count == count {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if exactly n floats in the list are less than or equal to the threshold within the given tolerance
/// and runs the consequence if so, otherwise runs the alternative.
///
pub fn n_loosely_less_than_or_equal(
  exactly count: Int,
  in values: List(Float),
  to threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count =
    list.filter(values, fn(value) { value <=. threshold +. tolerance })
    |> list.length
  case matching_count == count {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if exactly n floats in the list are equal to the threshold within the given tolerance
/// and runs the consequence if so, otherwise runs the alternative.
///
pub fn n_loosely_equal(
  exactly count: Int,
  in values: List(Float),
  to threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count =
    list.filter(values, fn(value) {
      value >=. threshold -. tolerance && value <=. threshold +. tolerance
    })
    |> list.length
  case matching_count == count {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if exactly n floats in the list are not equal to the threshold within the given tolerance
/// and runs the consequence if so, otherwise runs the alternative.
///
pub fn n_not_loosely_equal(
  exactly count: Int,
  in values: List(Float),
  to threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count =
    list.filter(values, fn(value) {
      value <. threshold -. tolerance || value >. threshold +. tolerance
    })
    |> list.length
  case matching_count == count {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if exactly n floats in the list are greater than or equal to the threshold within the given tolerance
/// and runs the consequence if so, otherwise runs the alternative.
///
pub fn n_loosely_greater_than_or_equal(
  exactly count: Int,
  in values: List(Float),
  to threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count =
    list.filter(values, fn(value) { value >=. threshold -. tolerance })
    |> list.length
  case matching_count == count {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if exactly n floats in the list are greater than the threshold within the given tolerance
/// and runs the consequence if so, otherwise runs the alternative.
///
pub fn n_loosely_greater(
  exactly count: Int,
  in values: List(Float),
  than threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count =
    list.filter(values, fn(value) { value >. threshold +. tolerance })
    |> list.length
  case matching_count == count {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if between n and m integers in the list are greater than the threshold and runs the consequence if so,
/// otherwise runs the alternative.
///
pub fn n_to_m_greater(
  at_least min: Int,
  at_most max: Int,
  in values: List(Int),
  than threshold: Int,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count =
    list.filter(values, fn(value) { value > threshold }) |> list.length
  case matching_count >= min && matching_count <= max {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if between n and m floats in the list are less than the threshold within the given tolerance
/// and runs the consequence if so, otherwise runs the alternative.
///
pub fn n_to_m_loosely_less(
  at_least min: Int,
  at_most max: Int,
  in values: List(Float),
  than threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count =
    list.filter(values, fn(value) { value <. threshold -. tolerance })
    |> list.length
  case matching_count >= min && matching_count <= max {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if between n and m floats in the list are less than or equal to the threshold within the given tolerance
/// and runs the consequence if so, otherwise runs the alternative.
///
pub fn n_to_m_loosely_less_than_or_equal(
  at_least min: Int,
  at_most max: Int,
  in values: List(Float),
  to threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count =
    list.filter(values, fn(value) { value <=. threshold +. tolerance })
    |> list.length
  case matching_count >= min && matching_count <= max {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if between n and m floats in the list are equal to the threshold within the given tolerance
/// and runs the consequence if so, otherwise runs the alternative.
///
pub fn n_to_m_loosely_equal(
  at_least min: Int,
  at_most max: Int,
  in values: List(Float),
  to threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count =
    list.filter(values, fn(value) {
      value >=. threshold -. tolerance && value <=. threshold +. tolerance
    })
    |> list.length
  case matching_count >= min && matching_count <= max {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if between n and m floats in the list are not equal to the threshold within the given tolerance
/// and runs the consequence if so, otherwise runs the alternative.
///
pub fn n_to_m_not_loosely_equal(
  at_least min: Int,
  at_most max: Int,
  in values: List(Float),
  to threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count =
    list.filter(values, fn(value) {
      value <. threshold -. tolerance || value >. threshold +. tolerance
    })
    |> list.length
  case matching_count >= min && matching_count <= max {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if between n and m floats in the list are greater than or equal to the threshold within the given tolerance
/// and runs the consequence if so, otherwise runs the alternative.
///
pub fn n_to_m_loosely_greater_than_or_equal(
  at_least min: Int,
  at_most max: Int,
  in values: List(Float),
  to threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count =
    list.filter(values, fn(value) { value >=. threshold -. tolerance })
    |> list.length
  case matching_count >= min && matching_count <= max {
    True -> consequence()
    False -> alternative()
  }
}

/// Checks if between n and m floats in the list are greater than the threshold within the given tolerance
/// and runs the consequence if so, otherwise runs the alternative.
///
pub fn n_to_m_loosely_greater(
  at_least min: Int,
  at_most max: Int,
  in values: List(Float),
  than threshold: Float,
  tolerating tolerance: Float,
  else_return alternative: fn() -> b,
  return consequence: fn() -> b,
) -> b {
  let matching_count =
    list.filter(values, fn(value) { value >. threshold +. tolerance })
    |> list.length
  case matching_count >= min && matching_count <= max {
    True -> consequence()
    False -> alternative()
  }
}
