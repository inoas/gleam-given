import given/internal/lib/optionx
import gleam/option.{None, Some}
import gleeunit/should

pub fn partition_test() {
  {
    [Some("Wibble"), None, None, Some("Wobble")]
    |> optionx.partition
    |> should.equal(#(["Wibble", "Wobble"], 2))
  }
}
