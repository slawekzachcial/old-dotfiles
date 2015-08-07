# Copied from https://github.com/nicknisi/dotfiles
# and added VI mode indicator

# heavily inspired by the wonderful pure theme
# https://github.com/sindresorhus/pure

# For my own and others sanity
# git:
# %b => current branch
# %a => current action (rebase/merge)
# prompt:
# %F => color dict
# %f => reset color
# %~ => current path
# %* => time
# %n => username
# %m => shortname host
# %(?..) => prompt conditional - %(condition.true.false)

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git # You can add hg too if needed: `git hg`
zstyle ':vcs_info:git*' formats ' %b'
zstyle ':vcs_info:git*' actionformats ' %b|%a'

autoload colors && colors

setopt prompt_subst

git_dirty() {
    # check if we're in a git repo
    command git rev-parse --is-inside-work-tree &>/dev/null || return

    # check if it's dirty
    command git diff --quiet --ignore-submodules HEAD &>/dev/null;
    if [[ $? -eq 1 ]]; then
        echo "%F{red}✗%f"
    else
        echo "%F{green}✔%f"
    fi
}

git_prompt_info() {
 ref=$(/usr/bin/git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

needs_push() {
  if [[ $(git cherry -v @{upstream} 2>/dev/null) == "" ]]
  then
    echo ""
  else
    echo "%{$fg_bold[magenta]%}☁%f "
  fi
}

# indicate a job (for example, vim) has been backgrounded
suspended_jobs() {
    sj=$(jobs 2>/dev/null | tail -n 1)
    if [[ $sj == "" ]]; then
        echo ""
    else
        echo "%{$FG[208]%}✱%f"
    fi
}

# VI mode indicator
vim_ins_mode="[ins]"
vim_cmd_mode="[CMD]"
vim_mode=$vim_ins_mode

zle-keymap-select() {
    vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
    zle reset-prompt
}
zle -N zle-keymap-select

zle-line-finish() {
    vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

precmd() {
    vcs_info
    print -P '\n%F{207}%~ `git_dirty`%F{241}$vcs_info_msg_0_%f `needs_push``suspended_jobs`'
}

export PROMPT='%F{241}${vim_mode} %(?.%F{magenta}.%F{red})❯%f '
#export RPROMPT='`git_dirty`%F{241}$vcs_info_msg_0_%f `needs_push``suspended_jobs`'
