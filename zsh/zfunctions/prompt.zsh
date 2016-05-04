setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
        '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
        '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git cvs svn

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
    vcs_info
    if [ -n "$vcs_info_msg_0_" ]; then
        echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
    fi
}
RPROMPT=$'$(vcs_info_wrapper)'


function git_prompt() {
    ref=$(git symbolic-ref HEAD | cut -d'/' -f3)
    echo $ref
}

function prompt_prs_get_color {
    local _hash=$(echo -n ${1} | sha1sum | cut -c 1-10)
    local number=$(( 0x${_hash} % 6 ))
    echo "$(tput bold)$(tput setaf $number)[${1}]"
}

[[ "$SSH_CONNECTION" != '' ]] \
    && prompt_prs_username="→ $USER@$HOST" || prompt_prs_username="$USER"

[[ -n "$USER_PROMPT_COLOR" ]] \
    && USER_PROMPT="%B%F{$USER_PROMPT_COLOR}[$prompt_prs_username]%f%b"\
    || USER_PROMPT=$(prompt_prs_get_color $prompt_prs_username)

[[ -n $PATH_PROMPT_COLOR ]] || PATH_PROMPT_COLOR="%{$fg_bold[yellow]%}"
PATH_PROMPT="%B%F{$PATH_PROMPT_COLOR}[%~]%f%b"
RESET=""

PROMPT="${USER_PROMPT}${PATH_PROMPT}${RESET} "
PS1=$PROMPT
