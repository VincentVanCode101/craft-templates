#!/bin/bash
# text_utils.sh
# Contains generic helper functions for text replacement in files.

# Escape a multiline string for use in a sed substitution.
# Arguments:
#   $1 - The multiline string.

# Concatenate all lines of a multi line string into a single line and escape '/' and literal newlines.
# -----------------------------------------------------------------------------
# This block of code transforms a multiline string into an escaped, single-line
# string that can be safely used as the replacement text in a sed substitution.
#
# The problem:
# When you try to insert a multiline string directly into a sed substitution
# command (e.g., using s/pattern/replacement/), sed gets confused by the
# literal newline characters and any delimiter characters (like '/') present in
# the string. These unescaped characters break sed’s expected syntax, causing
# errors such as "unterminated `s' command".
#
# What the command does:
# 1. 'printf '%s' "$multilinestring"'
#    - Prints the contents of the variable 'multilinestring' exactly as-is.
#
# The sed loop :a; N; $!ba is a idiom used to “slurp” the entire input
# into the pattern space. This means that instead of processing one line at a
# time, sed collects all the lines together so that later operations (like substitutions)
# can work on the complete input as a single block.

# 2. Piping into sed with a sequence of commands:
#
#    a. '-e ':a''
#       - Defines a label 'a' for later use in a loop.
#
#    b. '-e 'N''
#       - Appends the next line of input into the pattern space, allowing us
#         to work with multiple lines as one continuous string.
#
#    c. '-e '$!ba''
#       - Checks if we are not at the last line ('$!'); if not, it branches
#         back to label 'a'. This effectively concatenates the entire file
#         (or input) into a single line in the pattern space.
#
#    d. '-e 's/\//\\\//g''
#       - Globally replaces every forward slash '/' with an escaped forward slash '\/'.
#         This is crucial because '/' is used as the delimiter in sed’s 's' command.
#
#    e. '-e 's/\n/\\n/g''
#       - Replaces actual newline characters with the two-character sequence '\n'.
#         This conversion turns the multiline content into a single-line string
#         that represents newlines explicitly, ensuring sed interprets them correctly.
#
# 3. The final escaped string is stored in the variable 'escaped'.
#
# With 'escaped' now containing a properly formatted string, we can safely embed
# it into a sed substitution without causing syntax errors due to unescaped newlines
# or delimiter conflicts.
# -----------------------------------------------------------------------------
_escape_multiline_string() {
    local input="$1"

    local search_slash='/'
    local replacement_slash='\\/'

    printf '%s' "$input" | sed -e ':a' -e 'N' -e '$!ba' \
        -e "s|${search_slash}|${replacement_slash}|g" \
        -e 's|\n|\\n|g'
}

# Generic replacement function.
# Replaces the first occurrence of a search pattern in a file with the replacement text.
# Arguments:
#   $1 - File path in which the replacement occurs.
#   $2 - Search pattern (regular expression).
#   $3 - Replacement text (can be multi–line).
replace_in_file() {
    local file=$1
    local search_pattern=$2
    local replacement_text=$3

    if [ ! -f "$file" ]; then
        echo "ERROR: File '$file' does not exist." >&2
        return 1
    fi

    local sed_inplace_option=()
    if [[ "$(uname)" == "Darwin" ]]; then
        sed_inplace_option=(-i "")
    else
        sed_inplace_option=(-i)
    fi

    local escaped
    escaped=$(_escape_multiline_string "$replacement_text")

    sed "${sed_inplace_option[@]}" "s|${search_pattern}|${escaped}|" "$file"
}

# Prevent execution if the file is run directly.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "This script is meant to be sourced, not executed directly." >&2
    exit 1
fi
