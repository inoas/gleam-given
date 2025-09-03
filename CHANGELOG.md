# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

<!--## [Unreleased]-->
## [6.0.0] - 2025-09-??

**NOTICE: 6.0 contains a breaking change where `return` and `else_return`
argument order were unified**:

**TO MAKE CERTAIN LOGIC IS NOT INVERTED BY ACCIDENT USE `else_return` and/or
`return` ARGUMENT LABELS WHEN UPGRADING TO 6.0!**

- Following functions have their return and else_return argument order switched:
  - `given.that`
  - `given.any`
  - `given.all`
  - `given.not`
  - `given.any_not`
  - `given.all_not`
- Function documentation has been improved and unified with the examples.
- Examples have been improved.

## [5.2.1] - 2025-09-03

**NOTICE: 6.0 will have a breaking change where `return` and `else_return`
argument order will be unified**:

**TO MAKE CERTAIN LOGIC IS NOT INVERTED USE `else_return` and/or `return` ARG
LABELS BEFORE UPGRADING TO 6.0!**

- Fixed a bug in `given.any_not` (and deprecated `given.not_any`) where the
  result was inverse of what it should be.
- Improved readme and examples.
- Reverted the decision to replace `given.non_empty` with `given.not_empty`.
  Both will exist till 6.0 but then only `given.non_empty`.


## [5.2.0] - 2025-08-16

- Added `given.not_empty` to improve naming consistency.
- Deprecated `given.non_empty` which will be removed in 6.0

## [5.1.0] - 2025-07-08

- Added `given.all_not` and `given.any_not`.
- Deprecated `given.not_all` which will be removed in 6.0.
- Deprecated `given.not_any` which will be removed in 6.0.
- Updated dependencies and other chores.

## [5.0.4] - 2025-04-20

- Removed a warning of unused `io.debug` when compiling the dependency or
  running the example.

## [5.0.3] - 2025-03-06

- Fixed license shown in hex to be in line with license in repo.

## [5.0.2] - 2025-01-16

- Fixed more function doc blocks.

## [5.0.1] - 2025-01-16

- Fix deps constraint in `gleam.toml`.

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
  - `given.non_empty` to check if a list is non-empty.
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
