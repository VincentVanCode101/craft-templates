#!/usr/bin/env bash
set -euo pipefail

# Constants
readonly PROJECT_NAME_STRING="{PROJECT_NAME}"

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <new_project_name>" >&2
    exit 1
fi

readonly new_project_name="$1"

# Determine correct sed option for macOS or Linux
if [[ "$(uname)" == "Darwin" ]]; then
    sed_inplace_option=(-i "")
else
    sed_inplace_option=(-i)
fi

replace() {
    local readonly search_pattern="$1"
    local readonly replacement_string="$2"

    local this_script
    this_script="$(basename "${BASH_SOURCE[0]}")"

    # Use grep to find files containing the pattern, exclude the script itself, and replace placeholders
    grep -rlF --exclude="$this_script" "${search_pattern}" . | xargs sed "${sed_inplace_option[@]}" "s/${search_pattern}/${replacement_string}/g"
}

replace "$PROJECT_NAME_STRING" "$new_project_name"

echo "Renaming completed."
