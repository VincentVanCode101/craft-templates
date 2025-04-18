#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<EOF
Usage: $(basename "$0") <command> [args…]

Commands:
  install-package [pkg1 pkg2 …]   Install packages via install_packages.R
                                   (falls back to packages.txt if no pkgs given)
  run <script.R> [script-args…]    Run an arbitrary R script with Rscript
EOF
  exit 1
}

cmd=${1:-}
shift || true

case "$cmd" in

  install-package)
    # pass any additional args through to install_packages.R:
    # if none given, it’ll read packages.txt
    Rscript install_packages.R "$@"
    ;;

  run)
    if [[ $# -lt 1 ]]; then
      echo "Error: run needs a script filename" >&2
      usage
    fi
    Rscript "$@"
    ;;

  *)
    echo "Error: unknown command '$cmd'" >&2
    usage
    ;;
esac
