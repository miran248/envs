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
gray0=0
red=1
green=2
yellow=3
blue=4
purple=5
cyan=6
gray5=7 # normal
gray3=8
orange=9
gray1=10
gray2=11
gray4=12 # darker
gray6=13 # brighter
brown=14
gray7=15
black=16

RED="$(tput setaf ${red})"
GREEN="$(tput setaf ${green})"
BLUE="$(tput setaf ${blue})"
DARK="$(tput setaf ${gray4})"
NORMAL="$(tput setaf ${gray5})"
BRIGHT="$(tput setaf ${gray6})"
RESET="$(tput sgr0)"
BOLD="$(tput bold)"

# prompt
export PS1="\[${RED}\]→\[${RESET}\] "

# history
export HISTCONTROL=ignoreboth:erasedups

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
# underline
export LESS_TERMCAP_us="$(tput smul)${BOLD}${GREEN}" # start
export LESS_TERMCAP_ue="$(tput rmul)${RESET}" # end
# blink
export LESS_TERMCAP_mb="${BOLD}${BLUE}" # start
# bold
export LESS_TERMCAP_md="${BOLD}${RED}" # start
# half bright
export LESS_TERMCAP_mh="$(tput dim)${DARK}" # start
# reverse
export LESS_TERMCAP_mr="$(tput rev)" # start
# end mb, md, mh, mr, ..
export LESS_TERMCAP_me="${RESET}"
# standout
export LESS_TERMCAP_so="${BOLD}${BRIGHT}" # start
export LESS_TERMCAP_se="${RESET}" # end
# subscript
export LESS_TERMCAP_ZN=$(tput ssubm) # start
export LESS_TERMCAP_ZV=$(tput rsubm) # end
# superscript
export LESS_TERMCAP_ZO=$(tput ssupm) # start
export LESS_TERMCAP_ZW=$(tput rsupm) # end

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

# rsync
alias rsync="rsync -avzPc"


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
