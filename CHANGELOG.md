# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

<!-- ## [Unreleased] -->

## [5.0.0] - 2025-01-16

- Removed duplicate functions:
  - `given.given`
    use qualified `given.that(...` or
    unqualified import `given` instead.
  - `given.not_given`
    use qualified `given.not(in:...` or
    unqualified import `not_given` instead.
  - `given.ok_in`
    use qualified `given.ok(in:...` or
    unqualified import `given_ok_in` instead.
  - `given.error_in`,
    use qualified `given.error(in:...` or
    unqualified import `given_error_in` instead.
- Added:
  - `given.all` to check if all elements in a list are true.
  - `given.any` to check if any elements in a list are true.
  - `given.not_all` to check if all elements in a list are false.
  - `given.not_any` to check if any elements in a list are false.
  - `given.when` to allow for more complex lazy conditions.
  - `given.when_not` to allow for more complex lazy conditions.
  - `given.empty` to check if a list is empty.
  - `given.not_empty` to check if a list is not empty.
  - `given.all_ok` to check if all results are ok.
  - `given.any_ok` to check if any results are ok.
  - `given.all_error` to check if all results are errors.
  - `given.any_error` to check if any results are errors.
  - `given.all_some` to check if all options are some.
  - `given.any_some` to check if any options are some.
  - `given.all_none` to check if all options are none.
  - `given.any_none` to check if any options are none.

## [4.1.1] - 2025-01-01

- Improved examples.

## [4.1.0] - 2025-01-01

- Added alternatives function names and label names:
 - `given.ok(in: result...)` as an alternative to `given.ok_in(result:...)`
 - `given.error(in: result...)` as an alternative to `given.error_in(result:...)`
 - `given.some(in: option...)` as an alternative to `given.some_in(option:...)`
 - `given.none(in: option...)` as an alternative to `given.none_in(option:...)`
- Fixed readme to add the correct latest version.

## [4.0.1] - 2025-01-01

- Improved unit tests.
- Improved examples.
- Improved readme.

## [4.0.0] - 2025-01-01

Bugfix release of 3.0.2 but containing breaking change:

- `given.ok_in` has the labels switched, before:

   ```gleam
   pub fn ok_in(
     result rslt: Result(a, e),
     else_return consequence: fn(a) -> c,
     return alternative: fn(e) -> c,
   ) -> c
   ```

   after:

   ```gleam
   pub fn ok_in(
     result rslt: Result(a, e),
     else_return alternative: fn(e) -> c,
     return consequence: fn(a) -> c,
   ) -> c
   ```

## [3.0.2] - 2024-12-16

- Fix readme.

## [3.0.1] - 2024-12-16

- Added one inverse example for `none_in`.

## [3.0.0] - 2024-12-16

- Updated labels and internal code to be more consistent.
git
## [2.0.0] - 2024-12-14

- Removed `given` function prefixes from most functions to cut down import
  boilerplate and reduce local namespace pollution.

## [1.0.0] - 2024-12-14

- Initial release.
