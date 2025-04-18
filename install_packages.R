# install_packages.R
args <- commandArgs(trailingOnly = TRUE)

# if you passed names on the CLI, use them; otherwise read from packages.txt
pkgs <- if (length(args) > 0) {
  args
} else if (file.exists("packages.txt")) {
  scan("packages.txt", what = "character", sep = "\n", quiet = TRUE)
} else {
  stop("No packages.txt found and no packages passed via args.")
}

install_if_missing <- function(p) {
  if (!requireNamespace(p, quietly = TRUE)) {
    install.packages(p, repos = "https://cloud.r-project.org/")
  }
}

invisible(lapply(pkgs, install_if_missing))
message("Done installing: ", paste(pkgs, collapse = ", "))
