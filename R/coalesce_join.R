#' Join two dataframes, coalescing any columns with common names
#'
#' @inheritParams dplyr::left_join
#'
#' @export
coalesce_join <- function(x, y, by, type = c("left", "inner", "full")){
  # rlang::check_installed(c("dplyr", "data.table"))
  type <- rlang::arg_match0(type, c("left", "inner", "full"))

  stopifnot(
    is.data.frame(x),
    is.data.frame(y),
    is.character(by) && length(by) >= 1
  )

  x <- as.data.frame(x)
  y <- as.data.frame(y)

  if(nrow(y) == 0) {
    cli::cli_warn("{rlang::caller_arg(y)} has no rows, exiting early")
    return(x)
  }

  keys_x <- ifelse(names(by) == "", by, names(by))
  keys_y <- by

  check_keys <- c(
    "Join `by` keys in x are not unique" = nrow(x) != nrow(unique(x[keys_x])),
    "Join `by` keys in y are not unique" = nrow(y) != nrow(unique(y[keys_y])),
    "Join `by` keys in x have NAs" = any(is.na(x[keys_x])),
    "Join `by` keys in y have NAs"= any(is.na(y[keys_y]))
  )

  if(any(check_keys)) {
    cli::cli_warn(
      names(check_keys)[which(check_keys)]
    )
  }

  joined_cols <- c(setdiff(names(x), keys_x), setdiff(names(y), keys_y))
  dupl_cols <- joined_cols[duplicated(joined_cols)]

  join <- switch(type,
                 "left" = dplyr::left_join,
                 "inner" = dplyr::inner_join,
                 "full" = dplyr::full_join)

  merged_df <- join(
    x = x,
    y = y,
    by = by,
    suffix = c("..x","..y"),
    na_matches = "never"
  )

  data.table::setDT(merged_df)

  for (col in dupl_cols) {
    data.table::set(
      merged_df,
      j = col,
      value = dplyr::coalesce(merged_df[[paste0(col, "..x")]], merged_df[[paste0(col, "..y")]])
    )
    data.table::set(merged_df, j = paste0(col, "..x"), value = NULL)
    data.table::set(merged_df, j = paste0(col, "..y"), value = NULL)
  }

  out <- merged_df[,c(keys_x,unique(joined_cols)), with = FALSE]
  data.table::setDF(out)

  return(out)
}
