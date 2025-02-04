#!/usr/bin/env bash
set -euo pipefail

# Constants
readonly PROJECT_NAME_STRING="{PROJECT_NAME}"

main() {
    if [ "$#" -ne 1 ]; then
        echo "Usage: $0 <new_project_name>" >&2
        exit 1
    fi

    readonly new_project_name="$1"

    # Determine the correct in-place option for sed based on the operating system.
    # macOS (Darwin) requires an empty backup suffix after -i, while GNU sed does not.
    local sed_inplace_option
    if [[ "$(uname)" == "Darwin" ]]; then
        sed_inplace_option="-i ''"
    else
        sed_inplace_option="-i"
    fi

    replace "${PROJECT_NAME_STRING}" "${new_project_name}" "${sed_inplace_option}"
}

replace() {
    local readonly search_pattern="$1"
    local readonly replacement_string="$2"
    local readonly sed_inplace_option="$3"

    # Exclude the current script file from the grep search so that it does not replace its own placeholder.
    local this_script
    this_script="$(basename "${BASH_SOURCE[0]}")"

    # Use grep to find files that contain the search pattern, excluding the script file, then pass them to sed for replacement.
    #
    # Note: The xargs option "-d '\n'" is a GNU extension. On macOS, you might need to use:
    #       grep -rlF "${search_pattern}" . | tr '\n' '\0' | xargs -0 sed ${sed_inplace_option} "s/${search_pattern}/${replacement_string}/g"
    #       if filenames could contain spaces or newlines.
    # TODO: test that
    grep -rlF --exclude="$this_script" "${search_pattern}" . | xargs -d '\n' sed ${sed_inplace_option} "s/${search_pattern}/${replacement_string}/g"
}

main "$@"
