#!/usr/bin/env zsh

# zsh-tmux-rename.plugin.zsh
# author: Seong Yong-ju ( @sei40kr )

rename-tmux-window() {
  [[ -z "$TMUX" ]] && return

  LANG=en_US.UTF-8 vcs_info
  if [[ -n "$vcs_info_msg_0_" ]]; then
    tmux set-option -w automatic-rename-format "${vcs_info_msg_0_}"
  else
    tmux set-option -w automatic-rename-format "${PWD##*/}"
  fi
}

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' formats '%r'

autoload -Uz add-zsh-hook
add-zsh-hook chpwd rename-tmux-window

[[ -z "$TMUX" ]] || rename-tmux-window

