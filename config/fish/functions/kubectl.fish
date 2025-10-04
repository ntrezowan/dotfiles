# Copyright 2016 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# See the License for the specific language governing permissions and
# limitations under the License.
# fish completion for kubectl                              -*- shell-script -*-

function __kubectl_debug
    set -l file "$BASH_COMP_DEBUG_FILE"
    if test -n "$file"
        echo "$argv" >> $file
    end
function __kubectl_perform_completion
    __kubectl_debug "Starting __kubectl_perform_completion"

    # Extract the last arg and escape it in case it is a space
    set -l lastArg (string escape -- (commandline -ct))
    __kubectl_debug "last arg: $lastArg"
    set -l requestComp "KUBECTL_ACTIVE_HELP=0 $args[1] __complete $args[2..-1] $lastArg"

    __kubectl_debug "Calling $requestComp"
    set -l results (eval $requestComp 2> /dev/null)

    # Some programs may output extra empty lines after the directive.
    # Let's ignore them or else it will break completion.
    # Ref: https://github.com/spf13/cobra/issues/1279
    for line in $results[-1..1]
        if test (string trim -- $line) = ""
            # Found an empty line, remove it
            set results $results[1..-2]
            break
        end
    end
    set -l directiveLine $results[-1]

    # For Fish, when completing a flag with an = (e.g., <program> -n=<TAB>)
    # completions must be prefixed with the flag
    set -l flagPrefix (string match -r -- '-.*=' "$lastArg")

    __kubectl_debug "Comps: $comps"
    __kubectl_debug "DirectiveLine: $directiveLine"
    __kubectl_debug "flagPrefix: $flagPrefix"

    for comp in $comps
        printf "%s%s\n" "$flagPrefix" "$comp"
    end

    printf "%s\n" "$directiveLine"
end

function __kubectl_perform_completion_once
    __kubectl_debug "Starting __kubectl_perform_completion_once"

    if test -n "$__kubectl_perform_completion_once_result"
        return 0
    end

    set --global __kubectl_perform_completion_once_result (__kubectl_perform_completion)
    if test -z "$__kubectl_perform_completion_once_result"
        __kubectl_debug "No completions, probably due to a failure"

    return 0
end

function __kubectl_clear_perform_completion_once_result
    __kubectl_debug ""
    set --erase __kubectl_perform_completion_once_result
end

function __kubectl_requires_order_preservation
    __kubectl_debug ""
    __kubectl_debug "========= checking if order preservation is required =========="

    __kubectl_perform_completion_once

    __kubectl_debug "Directive is: $directive"

    set -l shellCompDirectiveKeepOrder 32
    __kubectl_debug "Keeporder is: $keeporder"

    if test $keeporder -ne 0
        __kubectl_debug "This does require order preservation"
        return 0
    end

    __kubectl_debug "This doesn't require order preservation"
    return 1
end


# This function does two things:
# - Obtain the completions and store them in the global __kubectl_comp_results
# - Return false if file completion should be performed
function __kubectl_prepare_completions
    __kubectl_debug ""
    __kubectl_debug "========= starting completion logic =========="

    # Start fresh
    set --erase __kubectl_comp_results

    __kubectl_perform_completion_once
    __kubectl_debug "Completion results: $__kubectl_perform_completion_once_result"

    if test -z "$__kubectl_perform_completion_once_result"
        __kubectl_debug "No completion, probably due to a failure"
        # Might as well do file completion, in case it helps
        return 1
    end

    set --global __kubectl_comp_results $__kubectl_perform_completion_once_result[1..-2]

    __kubectl_debug "Completions are: $__kubectl_comp_results"
    __kubectl_debug "Directive is: $directive"

    set -l shellCompDirectiveError 1
    set -l shellCompDirectiveNoSpace 2
    set -l shellCompDirectiveNoFileComp 4
    set -l shellCompDirectiveFilterFileExt 8
    set -l shellCompDirectiveFilterDirs 16

    if test -z "$directive"
        set directive 0
    end

    set -l compErr (math (math --scale 0 $directive / $shellCompDirectiveError) % 2)
    if test $compErr -eq 1
        __kubectl_debug "Received error directive: aborting."
    end

    if test $filefilter -eq 1; or test $dirfilter -eq 1
        return 1
    end


    # If we want to prevent a space, or if file completion is NOT disabled,
    # we need to count the number of valid completions.
    # To do so, we will filter on prefix as the completions we have received
    # may not already be filtered so as to allow fish to match on different
        set -l prefix (commandline -t | string escape --style=regex)

# Copyright 2016 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# fish completion for kubectl                              -*- shell-script -*-

function __kubectl_debug
    set -l file "$BASH_COMP_DEBUG_FILE"
    if test -n "$file"
        echo "$argv" >> $file
    end
end

function __kubectl_perform_completion
    __kubectl_debug "Starting __kubectl_perform_completion"

    # Extract all args except the last one
    set -l args (commandline -opc)
    # Extract the last arg and escape it in case it is a space
    set -l lastArg (string escape -- (commandline -ct))

    __kubectl_debug "args: $args"
    __kubectl_debug "last arg: $lastArg"

    # Disable ActiveHelp which is not supported for fish shell
    set -l requestComp "KUBECTL_ACTIVE_HELP=0 $args[1] __complete $args[2..-1] $lastArg"

    __kubectl_debug "Calling $requestComp"
    set -l results (eval $requestComp 2> /dev/null)

    # Some programs may output extra empty lines after the directive.
    # Let's ignore them or else it will break completion.
    # Ref: https://github.com/spf13/cobra/issues/1279
    for line in $results[-1..1]
        if test (string trim -- $line) = ""
            # Found an empty line, remove it
            set results $results[1..-2]
        else
            # Found non-empty line, we have our proper output
            break
        end
    end

    set -l comps $results[1..-2]
    set -l directiveLine $results[-1]

    # For Fish, when completing a flag with an = (e.g., <program> -n=<TAB>)
    # completions must be prefixed with the flag
    set -l flagPrefix (string match -r -- '-.*=' "$lastArg")

    __kubectl_debug "Comps: $comps"
    __kubectl_debug "DirectiveLine: $directiveLine"
    __kubectl_debug "flagPrefix: $flagPrefix"

    for comp in $comps
        printf "%s%s\n" "$flagPrefix" "$comp"
    end