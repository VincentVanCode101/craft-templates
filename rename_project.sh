#!/usr/bin/env bash
set -euo pipefail

rename_project() {
    # Constant placeholder to be replaced
    local PROJECT_NAME_STRING="{PROJECT_NAME}"

    if [ "$#" -ne 1 ]; then
        echo "Usage: rename_project <new_project_name>" >&2
        return 1
    fi

    local new_project_name="$1"

    # Determine correct sed option for macOS or Linux
    local sed_inplace_option=()
    if [[ "$(uname)" == "Darwin" ]]; then
        sed_inplace_option=(-i "")
    else
        sed_inplace_option=(-i)
    fi

    # Internal helper function to perform replacement in files
    replace() {
        local search_pattern="$1"
        local replacement_string="$2"

        local this_script
        this_script="$(basename "${BASH_SOURCE[0]}")"

        # Use grep to find files containing the pattern, exclude the script itself, and perform the replacement
        grep -rlF --exclude="$this_script" "${search_pattern}" . | xargs sed "${sed_inplace_option[@]}" "s/${search_pattern}/${replacement_string}/g"
    }

    replace "$PROJECT_NAME_STRING" "$new_project_name"

    echo "Renaming completed."
}

# Prevent this file from being executed directly.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "This script is meant to be sourced, not executed directly." >&2
    exit 1
fi
