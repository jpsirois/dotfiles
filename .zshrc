# requirements
# rbenv, npm, ack, teamocil, watnow

export EDITOR='vim'

# PATH {{{

# Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"

# Custom
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/Dropbox/Apps/dotfiles/bin:$PATH"
export PATH="$HOME/Dropbox/Apps/bin:$PATH"

# Node
export NODE_PATH="/usr/local/lib/node_modules:$NODE_PATH"

# }}}

# Prompt {{{

# Colors
autoload -U colors
colors
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt prompt_subst

# PROMPT
local percent="%(?,%{$fg[green]%}%#%{$reset_color%},%{$fg[red]%}%#%{$reset_color%})"

PROMPT='
%F{135}%~%{$reset_color%}  $(git-prompt.rb)
${percent} %{$reset_color%}'

RPROMPT='%F{16}$(date)%{$reset_color%}'

# }}}

# Hooks {{{

# backward delete
bindkey "\e[3~" delete-char

# }}}

# Command History Settings {{{
# Source : http://unix.stackexchange.com/a/1289

SAVEHIST=32768 # Number of entries
HISTSIZE=32768
HISTFILE=~/.zsh-history # File
setopt EXTENDED_HISTORY # Add additional data to history like timestamp
setopt INC_APPEND_HISTORY # Add immidiatly
setopt HIST_FIND_NO_DUPS # Don't show duplicates in search
setopt HIST_IGNORE_SPACE # Don't preserve spaces. You may want to turn it off
setopt NO_HIST_BEEP # Don't beep
setopt SHARE_HISTORY # Share history between session/terminals
setopt APPEND_HISTORY # Don't erase history

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^[[A' history-beginning-search-backward-end
bindkey '^[[B' history-beginning-search-forward-end

# }}}

# Alias - General {{{

alias ..='cd ..'
alias back='cd $OLDPWD'
alias e='echo'
alias c=' clear'
alias ll='ls -lh'
alias la='ls -Ah'
alias l='ls -lah'
alias rm='rm -i'
alias tgz='tar zxf'
alias d='watch --interval 1 date'
#alias f='find . -iname'
alias p='ps aux | ack -i '
alias bm='bmclient'
alias reload='source ~/.zshrc'
alias rmsvn='rm -rf `find . -type d -name ".svn"`'
alias rmds='rm -rf `find . -name ".DS_Store"`'
alias zshrc='open ~/.zshrc'
alias tm="teamocil --here"
alias wn="watnow"

# Find & remove bom signature from text files
alias findbom="grep -orHbm1 \"^`echo -ne '\xef\xbb\xbf'`\" . | sed '/:0:/!d;s/:0:.*//'"
alias removebom="grep -orHbm1 \"^`echo -ne '\xef\xbb\xbf'`\" . | sed '/:0:/!d;s/:0:.*//' | xargs vim -u NONE +'argdo se nobomb | wq'"

# JSON Beautify
function jsbt () { echo "${1}" | json }

# Web
alias vm='cd ~/VM/'
alias hosts='sudo vim /etc/hosts'
alias httpd.conf='sudo vim /etc/apache2/httpd.conf'
alias httpds.conf='sudo vim /etc/apache2/extra/httpd-ssl.conf'
alias vhosts='sudo vim /etc/apache2/extra/httpd-vhosts.conf'

alias ar='sudo apachectl restart | echo "Apache restarted"'

alias webserver="python -m SimpleHTTPServer"
alias bi='bundle install'
alias be='bundle exec '
alias bu='bundle update '

# Misc functions
power () {
 max=$(ioreg -l | fgrep MaxCapacity | cut -d= -f2 | tr -d " ");
 cur=$(ioreg -l | fgrep CurrentCapacity | cut -d= -f2 | tr -d " ");
 battery=$(awk -v "a=$max" -v "b=$cur" 'BEGIN{printf("%.2f%%", b/a * 100)}');
 echo "$battery"
}
function pman () { man -t "${1}" | open -f -a /Applications/Preview.app }
function cpwd () { echo -n $(pwd) | pbcopy }

# }}}

# Alias Git {{{

alias g="git"
# Inpired From https://github.com/rafBM/dotfiles/commit/df906a63987f9839a4f500ecfee0bdad4682e1bc
alias _gl="git log --graph --pretty=format:'%C(yellow)%h%C(reset)%C(bold red)%d%C(reset) %s %C(green)(%cr) %C(cyan)<%an>%C(reset)' --abbrev-commit"
alias gl="_gl -n 30 | ruby -e 'puts STDIN.read.gsub(%(<#{%x(git config user.name).chomp}>), %())'"

alias gs="git status -sbu"
alias gsi="git status -sbu --ignored"
alias ga="git add -p"
alias gi="git add -i"
alias gaa="git add --all"
alias gc="git commit -v"
alias gca="git commit -av"
alias gr="git rebase -i"
alias gpull="git pull --rebase origin"
alias grpull='find . -type d -name .git -exec sh -c "cd \"{}\"/../ && pwd && git pull" \;'
alias gpush="git push origin"
alias gck="git checkout"
alias gst="git stash"
alias gpop="git stash pop"
alias gcount="git rev-list HEAD --count"
alias gd="git diff"
alias gdt="git difftool"
alias gm="git merge"
alias gm="git mergetool"
alias gsub="gsubi && gsubu"
alias gsuba="git submodule add"
alias gsubi="git submodule init"
alias gsubu="git submodule update"
alias gdesactive="mv .git .git-inactive"
alias gactive="mv .git-inactive .git"
alias gundopush="git push -f origin HEAD^:master" # Undo a `git push`
alias gcleanup="find . -name '*.DS_Store' -type f -exec git rm --cached {} \;" # Recursively delete tracked `.DS_Store` files from a Git Repo
alias pistache="git stash" # Lovely nice funny alias

# Git pull in all first level children directory of the current folder
alias gpall="find . -type d -d 1 -exec git --git-dir={}/.git --work-tree=$(pwd)/{} pull origin master \;"

# Git status in all first level children directory of the current folder
#alias gsall="find . -type d -d 1 -exec echo git --git-dir={}/.git --work-tree=$(pwd)/{} status \;"

# Add current folder to ~/.gitlogger with name specified as argument 1
# For use with gitlogger.sh
function glog () {
  (echo "$1:`pwd`";grep -v "`pwd`$" ~/.gitlogger) | sort > ~/.gitlogger.tmp
  mv ~/.gitlogger.tmp ~/.gitlogger
}

# }}}

# Alias SVN {{{

#alias s="svn"
#alias sl="svn log"
#alias ss="svn status"
#alias sc="svn commit"
#alias su="svn update"
#alias sd="svn diff"
#alias saa="svn status | grep '^?' | sed 's/^? *\(.*\)/\"\1\"/g' | xargs svn add"
#alias sra="svn status | grep '^!' | sed 's/^! *\(.*\)/\"\1\"/g' | xargs svn rm"
#alias scl="svn changelist"
#alias sclr="svn changelist --remove"
#alias sstash="svn diff > _svn-diff.txt | svn revert -R ."
#alias sstashpop="patch -p0 -i _svn-diff.txt && rm -rf _svn-diff.txt"
#alias svnkill="find . -name .svn -print0 | xargs -0 rm -rf"

# Thank to http://viget.com/extend/effectively-using-git-with-subversion
alias sclone="git svn clone"
alias spull="git svn rebase"
alias spush="git svn dcommit"

# }}}

# System {{{

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias localip="ipconfig getifaddr en1"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Limit Bandwidth
alias bwa="sudo ipfw pipe 1 config bw 100KB && sudo ipfw add 1 pipe 1 src-port any"
alias bwr="sudo ipfw -q flush"

# }}}

# ZSH Init {{{

# Completions for Ruby, Git, etc.
eval "$(rbenv init -)"
compctl -g '~/.teamocil/*(:t:r)' teamocil
autoload compinit
compinit

# }}}
