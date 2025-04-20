import gleam/list
import gleam/option.{type Option, None, Some}

/// Similar to stdlib's `result.partition`,
/// but for `Option` instead of `Result`.
///
/// Given a list of options, returns a pair where the first element is a list
/// of all the values inside `Some` and the second element is a count of all
/// `None` values.
///
/// In contrast to stdlib's result.partition the values in the returning list
/// DO NOT appear in reverse order with respect to their position in the
/// original list of options.
///
/// ## Examples
///
/// ```gleam
/// partition([Some("Wibble"), None, None, Some("Wobble")])
/// // -> #(["Wibble", "Wobble"], 2)
/// ```
///
pub fn partition(options: List(Option(a))) -> #(List(a), Int) {
  partition_loop(options, [], 0)
}

fn partition_loop(options: List(Option(a)), somes: List(a), none_count: Int) {
  let #(somes, nones_count) = case options {
    [] -> #(somes, none_count)
    [Some(a), ..rest] -> partition_loop(rest, [a, ..somes], none_count)
    [None, ..rest] -> partition_loop(rest, somes, none_count + 1)
  }

  #(somes |> list.reverse, nones_count)
}
