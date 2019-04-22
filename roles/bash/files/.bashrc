#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# xdg
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"

export LC_CTYPE="en_US.UTF-8"

# colors
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
WHITE="$(tput setaf 7)"
GRAY="$(tput setaf 8)"
RESET="$(tput sgr0)"
BOLD="$(tput bold)"
DIM="$(tput dim)"
START_UNDERLINE="$(tput smul)"
END_UNDERLINE="$(tput rmul)"
START_SUBSCRIPT="$(tput ssubm)"
END_SUBSCRIPT="$(tput rsubm)"
START_SUPERSCRIPT="$(tput ssupm)"
END_SUPERSCRIPT="$(tput rsupm)"
REVERSE="$(tput rev)"

# prompt
export PS1="\[${RED}\]→\[${RESET}\] "

# colors
alias diff='diff --color=auto'
alias grep='grep --color=auto'

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  alias ls='ls --color=auto'
else
  alias ls='ls -G'
fi

# less / man
export LESS="-R"
export LESS_TERMCAP_mb="${BOLD}${GREEN}"
export LESS_TERMCAP_md="${BOLD}${RED}"
export LESS_TERMCAP_me="${RESET}"
export LESS_TERMCAP_so="${BOLD}${GRAY}"
export LESS_TERMCAP_se="${RESET}"
export LESS_TERMCAP_us="${BOLD}${GREEN}"
export LESS_TERMCAP_ue="${RESET}"
export LESS_TERMCAP_mr="${REVERSE}"
export LESS_TERMCAP_mh="${DIM}"
export LESS_TERMCAP_ZN="${START_SUBSCRIPT}"
export LESS_TERMCAP_ZV="${END_SUBSCRIPT}"
export LESS_TERMCAP_ZO="${START_SUPERSCRIPT}"
export LESS_TERMCAP_ZW="${END_SUPERSCRIPT}"

# ls
alias ll="ls -lh"
alias la="ls -lha"

# tmux
alias tmux='tmux -f "${XDG_CONFIG_HOME}/tmux/tmux.conf"'
export TMUX_PLUGIN_MANAGER_PATH="${XDG_CONFIG_HOME}/tmux/plugins/"

# editor
export EDITOR=$(which vim)
export VISUAL=${EDITOR}
alias v="vim"

# git
alias co="git checkout"
alias gs="git status"
alias ga="git add -A"
alias gc="git commit"
alias gm="git merge"
alias pull="git pull"
alias push="git push"

# fzf
export FZF_DEFAULT_OPTS="--layout=reverse --height 20%"


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
export DOTNET_CLI_TELEMETRY_OPTOUT=true
