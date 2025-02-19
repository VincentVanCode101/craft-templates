#!/usr/bin/env bash
set -euo pipefail

rename_project() {
    local new_project_name="$1"
    local readonly project_name_string="{PROJECT_NAME}"

    if [[ "$(uname)" == "Darwin" ]]; then
        sed_inplace_option=(-i "")
    else
        sed_inplace_option=(-i)
    fi

    replace() {
        local search_pattern="$1"
        local replacement_string="$2"
        local this_script
        this_script="$(basename "${BASH_SOURCE[0]}")"

        # Replace all occurrences of the placeholder in files (excluding this script)
        grep -rlF --exclude="$this_script" "${search_pattern}" . |
            xargs sed "${sed_inplace_option[@]}" "s/${search_pattern}/${replacement_string}/g"
    }

    replace "$project_name_string" "$new_project_name"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "This script is meant to be sourced, not executed directly." >&2
    exit 1
fi
