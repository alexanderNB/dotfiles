#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

IDE=$"codium"
export VISUAL="$IDE"
export EDITOR="$IDE"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias chere='$IDE . --reuse-window'
alias nchere='$IDE . --new-window'
alias chome='$IDE ~ --reuse-window'
alias nchome='$IDE ~'
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
alias debug='~/.config/hypr/scripts/debug.sh'

.contains_element() {
    local element match="$1"
    echo "match: $match"
    echo "element: $element"
    shift
    for element; do
        [[ "$element" == "$match" ]] && return 0
    done
    return 1
}

.super_path() {
    local search="$1" command="$2" use_grep=false
    shift 2
    local -a extra_args=()

    # Loop through all arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
        -grep)
            use_grep=true
            shift
            ;;
        *)
            extra_args+=("$1")
            shift
            ;;
        esac
    done

    local find_base=(find "$HOME" -path "$HOME/.local/share/Trash" -prune -o -path "$HOME/.config/VSCodium/User/workspaceStorage" -prune -o -path "$HOME/.config/Code - OSS/User/workspaceStorage" -prune -o)

    if [ "$use_grep" = true ]; then
        mapfile -t found < <("${find_base[@]}" -print | grep -E "$search[^/]*$")
    else
        mapfile -t found < <("${find_base[@]}" -name "$search" -print)
    fi

    local found_count=${#found[@]}

    if ((found_count == 0)); then
        if [ "$use_grep" = false ]; then
            .super_path "$search" "$command" -grep "${extra_args[@]}" && return
        fi
        echo "Found no matches."
        return
    fi

    if ((found_count == 1)); then
        local current_found="${found[0]}"
        if [ "$(file -b "$current_found")" != "directory" ]; then
            current_found="$(dirname $current_found)"
            echo Changed to directory $current_found
        fi
        "$command" "$current_found" "${extra_args[@]}" # Yeah thats a thing
        return

    fi

    # Found more than 1

    local -a directories=()
    local -a valid_found=()

    local skipped=0

    for i in "${!found[@]}"; do
        local display=${found[i]/#"$HOME"/"~"}
        #[ "$(file -b "$current_found")" != "directory" ]
        if [ "$(file -b "${found[i]}")" != "directory" ]; then
            in_directory=0
            for item in "${directories[@]}"; do
                if [[ "$item" == "$(dirname "${found[i]}")" ]]; then
                    in_directory=1
                    break
                fi

            done
            if [[ $in_directory -eq 1 ]]; then
                skipped=$((skipped + 1))
                continue
            else
                valid_found+=("${found[i]}")
            fi
        else
            directories+=("${found[i]}")
            valid_found+=("${found[i]}")
        fi

        local file_type=""
        if [[ "${display##*/}" != *.* && "$(file -b "${found[i]}")" != directory ]]; then
            file_type="$(file -b "${found[i]}")"
            file_type="${file_type%%,*}"
            file_type="  |> $file_type"
            # file_type="  |> ${$(file -b "${found[i]}")%%,*}"
        fi

        printf "  %2d) %s\n" $((i + 1 - skipped)) "$display$file_type"
    done

    local choice
    while true; do
        read -p "Enter number to $command (1–$((found_count - skipped))): " choice
        if [[ "$choice" =~ ^[1-9][0-9]*$ ]] && ((choice >= 1 && choice <= found_count - skipped)); then
            local current_found="${valid_found[choice - 1]}"
            if [ "$(file -b "$current_found")" != "directory" ]; then
                current_found="$(dirname $current_found)"
            fi

            "$command" "$current_found" "${extra_args[@]}"
            return
        fi
        echo "Invalid selection. Please enter a number between 1 and $((found_count - skipped))."
    done

}

cdpath() { .super_path "$1" cd "${@:2}"; }

cpath() { .super_path "$1" $IDE --reuse-window "${@:2}"; }

ncpath() { .super_path "$1" $IDE --new-window "${@:2}"; }

path() { .super_path "$1" echo "${@:2}"; }
# search for NAME with Trash excluded

trash="./.local/share/Trash"
#ignore_naming_convention=
find_spaces() {
    f1=$(find . \
        -path $trash -prune -o \
        -path ./.cache -prune -o \
        -path ./.mozilla -prune -o \
        -path ./.config/discord -prune -o \
        -path ./.config/VS$IDE -prune -o \
        -path ./.config/obsidian -prune -o \
        -path ./.vscode-oss/extensions -prune -o \
        -path ./SyncedObsidian -prune -o \
        -print | grep -E " [^\/]*$")

    f2=$(find ./SyncedObsidian/.obsidian | grep " " | grep -v conflict | grep -v " ".*/)

    if [ "$f1" ]; then
        while read -r name; do
            echo "$name"
        done <<<"$f1"
        if [ "$f1" ]; then
            while read -r name; do
                echo "$name"
            done <<<"$f2"
        fi
    elif [ "$f1" ]; then
        while read -r name; do
            echo "$name"
        done <<<"$f2"
    else
        echo "No spaces found in searched paths"
    fi
}

# In ~/.bashrc
find_dups() {
    # 1) find all dirs (excluding Trash)
    # 2) print full path and basename
    # 3) sort by basename
    # 4) extract only the basenames that repeat
    local dups
    dups=$(find . \
        -path "./.cache" -prune -o \
        -path "./.config" -prune -o \
        -path "./.ipython" -prune -o \
        -path "./.local" -prune -o \
        -path "./.mozilla" -prune -o \
        -path "./.pki" -prune -o \
        -path "./.ssh" -prune -o \
        -path "./.vscode-oss" -prune -o \
        -path "./.local/share/Trash" -prune -o \
        -path "./yay" -prune -o \
        -path "./Downloads" -prune -o \
        -type d -print |
        grep -v /hidden/ |
        awk -F/ '{ print $NF }' |
        sort |
        uniq -d)

    #  echo -z $dubs
    #  echo -z "$dups"
    #  return
    if [ -z "$dups" ]; then
        echo "No duplicate directory names found under here"
        return
    fi

    echo "Duplicate directory names found:"
    # For each duplicate leaf-name, re-run find to list all paths
    while read -r name; do
        echo
        echo "  ▶ $name"
        find . \
            -path "./.cache" -prune -o \
            -path "./.config" -prune -o \
            -path "./.ipython" -prune -o \
            -path "./.local" -prune -o \
            -path "./.mozilla" -prune -o \
            -path "./.pki" -prune -o \
            -path "./.ssh" -prune -o \
            -path "./.vscode-oss" -prune -o \
            -path "./.local/share/Trash" -prune -o \
            -path "./yay" -prune -o \
            -path "./Downloads" -prune -o \
            -type d -name "$name" -print |
            sed 's/^/    /'
    done <<<"$dups"
}

# Created by `pipx` on 2025-05-04 11:53:51
export PATH="$PATH:~/.local/bin"

eval "$(zoxide init --cmd cd bash)"
export FZF_DEFAULT_COMMAND='find . -type f -not -path "./.steam/*" -not -path "./.cache/*" -not -path "./.local/share/Steam/*" -not -path "./.local/share/lutris/*"'
# export FZF_DEFAULT_COMMAND='find . -type f -not -path "./.cache"'
eval "$(fzf --bash)"
