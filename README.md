
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tantastic

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-informational?style=flat-square)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

A personal package of R functions, ggplot themes, and other miscellany.

## Installation

You can install the released version of tantastic from [Tan’s R-Universe
page](https://tanho63.r-universe.dev) with:

``` r
install.packages(
  "tantastic", 
  dependencies = TRUE, 
  repos = c("https://tanho63.r-universe.dev", getOption("repos")))
```

## Functions List

- `gen_input_*()` generates a list of Shiny Inputs (either for a list of
  length *n* or for a given list of identifiers)
- `read_inputs()` returns the values of a given list of input IDs
- `unbind_dt()` “unbinds” the Shiny inputs in a table, which is helpful
  if they are generated/regenerated reactively.
- `fmt_dtcol()` colours a DT column based on either the column’s minimum
  and maximum values, or a manually-generated min/max.
- `theme_tantastic()` is an adapted theme from hrbrmstr/hrbrthemes’s
  theme_modern_rc()
- `use_client_tz()` and `get_client_tz()` give access to a Shiny user’s
  timezone
- `progressively()` adds some helpers for progress bars
