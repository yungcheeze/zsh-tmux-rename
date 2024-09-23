#!/usr/bin/env zsh

# zsh-tmux-rename.plugin.zsh
# author: Seong Yong-ju ( @sei40kr )

rename-tmux-window() {
  [[ -z "$TMUX" ]] && return

  pane_name="${PWD##*/}"

  git_dir="$(git rev-parse --absolute-git-dir 2>/dev/null)"

  # in root of bare repo
  if [[ -n "$git_dir" ]]; then
    pane_name="$(basename $git_dir)"
  fi

  # in root of normal repo
  if [[ "$(basename $git_dir 2>/dev/null)" == ".git" ]]; then
    pane_name="$(basename $(dirname $git_dir))"
  fi

  # in worktree
  echo $git_dir
  if echo "$git_dir" | grep "worktrees" > /dev/null; then
    worktree_name="$(basename $git_dir)"
    repo_name="$(basename $(dirname $(dirname $git_dir)))"
    pane_name="$repo_name - $worktree_name"
  fi


  if [[ -n $TMUX_PROJECT_NAME ]]; then
    pane_name="$TMUX_PROJECT_NAME - $pane_name"
  fi

  tmux set-option -w automatic-rename-format "$pane_name"

}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd rename-tmux-window

[[ -z "$TMUX" ]] || rename-tmux-window

