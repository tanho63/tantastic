#' Delete merged GitHub branches
#'
#' @return invisible(TRUE)
#' @export
git_cleanup <- function() {
  system(
    paste(
      # Prune remote branches that no longer exist
      "git fetch -p &&",
      # Delete all local branches that have been merged to main
      "for branch in $(git for-each-ref --format '%(refname) %(upstream:track)'",
      "refs/heads | awk '$2 == \"[gone]\" {sub(\"refs/heads/\", \"\", $1); print $1}');",
      "do git branch -D $branch; done"
    )
  )
  return(invisible(TRUE))
}
