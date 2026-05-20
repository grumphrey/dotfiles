# Prompt customisation
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%F{156}%n%f %F{086}%~%f %F{227}${vcs_info_msg_0_}%f> '
# PROMPT='%F{118}%*%f %F{215}%n%f %F{086}%~%f %F{227}${vcs_info_msg_0_}%f$ '

# aliases
alias v="nvim"
alias vim="nvim"
alias ls="ls -G"
alias l="eza --oneline --icons --git"
alias lt="eza --tree --level=2 --long --icons --git"
alias rg="rg --smart-case --hidden"

# yazi (change the current working directory when exiting yazi)
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}

# Autocompletion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files

# vi mode in shell
bindkey -v
export KEYTIMEOUT=1

# visual feedback for cursor (beam in insert mode, block in normal mode)
function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] ||
		[[ $1 = 'block' ]]; then
	echo -ne '\e[1 q'
elif [[ ${KEYMAP} == main ]] ||
	[[ ${KEYMAP} == viins ]] ||
	[[ ${KEYMAP} = '' ]] ||
	[[ $1 = 'beam' ]]; then
echo -ne '\e[5 q'
	fi
}
zle -N zle-keymap-select
zle-line-init() {
	zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
	echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

export PATH="/Library/Frameworks/Python.framework/Versions/3.14/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home -v 22)
export PATH=$JAVA_HOME/bin:$PATH
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

eval "$(zoxide init --cmd cd zsh)"

# fzf
eval "$(fzf --zsh)" # Shell integration (keybindings + completion)
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"
export FZF_TMUX_OPTS=" -p90%,70% "
export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

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
