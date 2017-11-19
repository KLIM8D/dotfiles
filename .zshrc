# init zplug and load modules
source ~/.zsh/zplugrc.zsh

zshrc_modules=(${HOME}/.zsh/modules/*.zsh(N)) # should it be using modules inside .confs directly? 

# load zshrc modules to split up logic
if [ -n "$zshrc_modules" ]; then
  for mod in ${zshrc_modules}; do
    . "$mod"
  done
fi
# TODO: exclude module array? ^

# TODO: tmp.zsh, keys.zsh, vimode.sh, ssh-find-agent.sh
# TODO: platform-specific module? or .profile ?
# TODO: fpath .functions ?

# finally user-specific configurations after modules and zplug has loaded everything
# to avoid overriding and breaking stuff

cdpath=(
  ${cdpath}
)

# needed?
path=(
  $path
  #/usr/local/{bin,sbin}
)

#unlimited history TODO
# IDEA: 
# if SIZE==SAVEHIST # is a while != SAVEHIST good here? :S
# $SIZE=$(wc -l < .history | tr -d ' ')
# then: fc -A .history.old #append to history.old && fc -p # flush
## then: copy to a timestamped .history
## then: make available to searches?
## then: 

HISTFILE="${HOME}/.history"
HISTSIZE=10000
SAVEHIST=10000

# Show history
case $HIST_STAMPS in
  "mm/dd/yyyy") alias history='fc -fl 1' ;;
  "dd.mm.yyyy") alias history='fc -El 1' ;;
  "yyyy-mm-dd") alias history='fc -il 1' ;;
  *) alias history='fc -l 1' ;;
esac

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data
setopt histfindnodups #find no dups in search history
setopt histignorealldups #ignore all duplicate commands

save_all_hist() {
  #  fc -lEn -1 >> ${HOME}/.history_all 

  # does the compliant timestamp
  fc -A "${HOME}"/.history_all 
}

load_all_hist() {
  fc -R "${HOME}"/.history_all
}

precmd_functions=($precmd_functions save_all_hist)
preexec_functions=($preexec_functions notify_hist_limit)

# TODO: keychain/ssh-find-agent (keychain looks best, is it needed on a server?)
# ^ needed for not retyping password on every ssh-session


# Separate ALIAS / FUNCTIONS
if [ -f $HOME/.zsh_aliases ]; then
    source $HOME/.zsh_aliases
fi
# TODO: add to fpath & autoloas
if [ -f $HOME/.functions ]; then
    source $HOME/.functions
fi

# freaking <TAB> wildmenu select like Vim!
zstyle ':completion:*' menu select
# choose the first entry automatically without multiple TAB presses
setopt menu_complete

export LANG=en_DK.UTF-8

# Tab-complete colors
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==36=36}:${(s.:.)LS_COLORS}")'; 

# folder of all of your autocomplete functions
fpath=($HOME/.zsh-completions $fpath)

# Directory colors
eval `dircolors ~/.dircolors`
