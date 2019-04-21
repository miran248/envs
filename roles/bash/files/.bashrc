#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# xdg
XDG_CONFIG_HOME="${HOME}/.config"
XDG_CACHE_HOME="${HOME}/.cache"
XDG_DATA_HOME="${HOME}/.local/share"

LC_CTYPE="en_US.UTF-8"

# prompt
RED="\[$(tput setaf 1)\]"
RESET="\[$(tput sgr0)\]"
PS1="${RED}→${RESET} "

# colors
alias diff='diff --color=auto'
alias grep='grep --color=auto'

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  alias ls='ls --color=auto'
else
  alias ls='ls -G'
fi

LESS=-R
LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
LESS_TERMCAP_ue=$'\E[0m'        # reset underline

man() {
  LESS_TERMCAP_md=$'\e[01;31m' \
  LESS_TERMCAP_me=$'\e[0m' \
  LESS_TERMCAP_se=$'\e[0m' \
  LESS_TERMCAP_so=$'\e[01;44;33m' \
  LESS_TERMCAP_ue=$'\e[0m' \
  LESS_TERMCAP_us=$'\e[01;32m' \
  command man "$@"
}

# ls
alias ll="ls -lh"
alias la="ls -lha"

# tmux
alias tmux='tmux -f "${XDG_CONFIG_HOME}/tmux/tmux.conf"'
TMUX_PLUGIN_MANAGER_PATH="${XDG_CONFIG_HOME}/tmux/plugins/"

# editor
alias v="vim"

# git
alias co="git checkout"
alias gs="git status"
alias ga="git add -A"
alias gc="git commit -m"
alias gm="git merge"
alias pull="git pull"
alias push="git push"

# fzf
FZF_DEFAULT_OPTS="--layout=reverse --height 20%"


function gld {
	git log --after="$* 00:00" --before="$* 23:59" --pretty=format:%s --no-merges --author Miran
}

function tl {
	b="$*"
	a=$[b - 1]
	git log --pretty=format:%s --branches --no-merges "`printf "%0*d" 4 $a`"..."`printf "%0*d" 4 $b`"
}

alias rmds="find . -name '.DS_Store' -type f -delete"
alias rmicon="find . -name 'Icon\r' -type f -delete"

alias gl="gld `date +%Y-%m-%d`"

alias rtv2="mpv https://rtvslolive.akamaized.net/hls/live/584144/tv_slo2/slo2/r-playlist.m3u8";

alias f="fd | fzf"

function sl() {
  streamlink --hls-live-restart -o "$(date +"%Y%m%d%H%M%S.mp4")" "$1" best
}

function yt() {
  youtube-dl -f bestvideo+bestaudio -i --no-playlist "$1"
}

function gpgenv {
  # Default gpg folder
  DEFAULTGNUPGHOME=$HOME/.gnupg

  # Kill current instance
  gpgconf --remove-socketdir --kill gpg-agent

  # Export selected gpg folder
  export GNUPGHOME=${1:-$DEFAULTGNUPGHOME}

  # Export selected gpg folder for gui apps
  launchctl setenv GNUPGHOME $GNUPGHOME

  # Launch new instance
  gpgconf --create-socketdir --launch gpg-agent

  # Link socket
  ln -sf $GNUPGHOME/S.gpg-agent.ssh $SSH_AUTH_SOCK

  gpg-connect-agent updatestartuptty /bye

  echo "Switched to $GNUPGHOME"
}

export GPG_TTY=$(tty)
export PINENTRY_USER_DATA="USE_CURSES=1"
export DOTNET_CLI_TELEMETRY_OPTOUT=true
