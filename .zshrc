# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/humphrey/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/humphrey/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/humphrey/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/humphrey/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Prompt customisation
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%F{156}%n%f %F{086}%~%f %F{227}${vcs_info_msg_0_}%f> '
# PROMPT='%F{118}%*%f %F{215}%n%f %F{086}%~%f %F{227}${vcs_info_msg_0_}%f$ '

# aliases
alias cs2106="cd ~/Documents/School/Y3S2/CS2106\ Operating\ Systems"
alias cs2109s="cd ~/Documents/School/Y3S2/CS2109S\ Artificial\ Intelligence\ and\ Machine\ Learning"
alias cs4221="cd ~/Documents/School/Y3S2/CS4221\ DB\ Design\ \&\ Tuning"
alias cs4231="cd ~/Documents/School/Y3S2/CS4231\ Parallel\ \&\ Distributed\ Algorithms"
alias vim="nvim"
alias dev="~/./dev-tmux.sh"
alias ls="ls -G"

# Autocompletion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files

# vi mode
# bindkey -v
# Use vim keys in tab complete menu:
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -v '^?' backward-delete-char
# Change cursor shape for different vi modes.
# function zle-keymap-select {
# if [[ ${KEYMAP} == vicmd ]] ||
#      [[ $1 = 'block' ]]; then
# echo -ne '\e[1 q'
# elif [[ ${KEYMAP} == main ]] ||
#        [[ ${KEYMAP} == viins ]] ||
#        [[ ${KEYMAP} = '' ]] ||
#        [[ $1 = 'beam' ]]; then
# echo -ne '\e[5 q'
# fi
# }
# zle -N zle-keymap-select
# zle-line-init() {
#     zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
# echo -ne "\e[5 q"
# }
# zle -N zle-line-init
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
# preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
#
#
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home -v 22)
export PATH=$JAVA_HOME/bin:$PATH

# zsh plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=102"

# load zsh-syntax-highlighting; should be last.
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg="#61e3ac",underline
ZSH_HIGHLIGHT_STYLES[precommand]=fg="#61e3ac",underline
ZSH_HIGHLIGHT_STYLES[arg0]=fg="#61e3ac"

# export TERMINFO="/usr/share/terminfo"
macchina
