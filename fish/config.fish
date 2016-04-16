# Colors schemes
set --global blanc c2c7cc
set --global vert 9ccc85
set --global rouge cc5c65
set -g red_c (set_color cc5c65)

# Overwrite some default colors
set --global fish_color_command 7ed4e6
set --global fish_color_param 7ed4e6
set --global fish_color_normal 7ed4e6
set --global fish_color_error 7ed4e6

# fish prompt
function fish_prompt --description 'Write out the prompt'
  if not set -q __fish_prompt_normal
  set -g __fish_prompt_normal (set_color $blanc)
  end

  if not set -q __git_cb
  set __git_cb ":"(set_color $rouge)(git branch ^/dev/null | grep \* | sed 's/* //')(set_color $blanc)""
  end

  switch $USER

  case root

  if not set -q __fish_prompt_cwd
      if set -q fish_color_cwd_root
          set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
      else
          set -g __fish_prompt_cwd (set_color $fish_color_cwd)
      end
  end

  printf '%s ' (date "+$red_c%H:%M:%S")
  printf '%s%s' "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb
  printf '\n%s%s%s $ ' $USER

  case '*'

  if not set -q __fish_prompt_cwd
      set -g __fish_prompt_cwd (set_color $vert)
  end

  printf '%s ' (date "+$red_c%H:%M:%S")
  printf '%s%s' "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb
  printf '\n%s%s%s $ ' $USER

  end
end

# Remove greeting
set fish_greeting ""

# Java options
setenv JAVA_OPTS "-Xms2048m -Xmx2048m -XX:MaxPermSize=2048m"
setenv _JAVA_OPTS $JAVA_OPTS
setenv _JAVA_OPTIONS $JAVA_OPTS

# User $PATH
set -x PATH $PATH /usr/local/bin
set -x PATH $PATH /usr/local/share/npm/lib/
set -x PATH $PATH /usr/local/Cellar/
set -x PATH $PATH /usr/local/share/npm/bin/
set -x PATH $PATH /usr/local/share/npm/lib/node_modules
set -x PATH $PATH /usr/local/bin/gulp
set -x PATH $PATH /Users/jbr/android-sdk/tools
set -x PATH $PATH /Users/jbr/android-sdk/platform-tools
set -x PATH $PATH /usr/bin/java
set -x PATH $PATH /Users/jbr/.nvm
set -gx PATH $PATH /usr/local/mysql/bin/

# User export
set -x EDITOR subl -w

# NVM tools
# https://github.com/edc/bass
function nvm
  bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv ';' nvm use v5.10.1
end

# Autocompletions for git
alias g='git'
source /usr/share/bash-completion/completions/git
complete -o default -o nospace -F _git g

# Fisher
set fisher_home ~/.local/share/fisherman
set fisher_config ~/.config/fisherman
source $fisher_home/config.fish
