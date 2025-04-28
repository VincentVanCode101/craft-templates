#!/usr/bin/env sh
set -e

COMMAND=$1

case "$COMMAND" in
install-package)
    pip install -r requirements.txt
    ;;
run)
    shift
    python "$@"
    ;;
*)
    echo "Usage:"
    echo "  ./make install-package"
    echo "  ./make run <script.py>"
    ;;
esac
