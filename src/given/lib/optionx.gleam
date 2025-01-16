import gleam/option.{type Option, None, Some}

/// Given a list of options, returns a pair where the first element is a list
/// of all the values inside `Some` and the second element is a count of all
/// `None` values. The values in the returning list appear in reverse order
/// with respect to their position in the original list of options.
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

fn partition_loop(options: List(Option(a)), somes: List(a), nones: Int) {
  case options {
    [] -> #(somes, nones)
    [Some(a), ..rest] -> partition_loop(rest, [a, ..somes], nones)
    [None, ..rest] -> partition_loop(rest, somes, nones + 1)
  }
}
