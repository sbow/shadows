# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/git/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Configure plugins
plugins=(
	git
	zsh-autosuggestions
	zsh-completions
	copypath
	copyfile
	copybuffer
	history
	dirhistory
	)

#NVidia cuda setup and local path
export PATH="/usr/local/cuda-12.2/bin:$PATH"
export PATH="/home/shaun/.local/bin:$PATH"

# Setup pyenv (handles multiple python installations on one system, ie: for dbx)
# On this system: pyenv is for python versions, pipenv for pip and virtualenv package management
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


##############################################################################
## History Configuration
###############################################################################
HISTSIZE=10000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=10000               #Number of history entries to save to disk
#HISTDUP=erase               #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed

# setup ls colors
LS_COLORS='no=00;37:fi=00:di=00;33:ln=04;36:pi=40;33:so=01;35:bd=40;33;01:'
export LS_COLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# ALIAS commands
alias ls='exa --grid'

# setup environment variables for databrix extention (dbx)
export DATABRICKS_HOST="https://adb-1850188018120852.12.azuredatabricks.net/"
export DATABRICKS_TOKEN=""


