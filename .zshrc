# History
# =============================================================================
setopt SHARE_HISTORY
HISTSIZE=1000
HISTFILE=~/.zsh_history
SAVEHIST=1000

# Libaries
# =============================================================================
LIBS=(
'/Users/bkim/oh-my-zsh/lib/spectrum.zsh'
'/Users/bkim/oh-my-zsh/lib/directories.zsh'
'/Users/bkim/oh-my-zsh/lib/history.zsh'
)
for i in $LIBS; do [[ -f $i ]] && source $i; done

# Color Setup
# =============================================================================
autoload -U colors && colors

# Keybindings
# =============================================================================
bindkey -v                                                      # enable vi mode
function zle-line-init zle-keymap-select {
    VIM_PROMPT="[% %{$FG[030]%}NORMAL%{$reset_color%}]"         # normal mode
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"   # indicator
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

function history-search-end {
    integer cursor=$CURSOR mark=$MARK                           # takes cursor to 
    if [[ $LASTWIDGET = history-beginning-search-*-end ]]; then # end of the line
        CURSOR=$MARK                                            # during history
    else                                                        # search.
        MARK=$CURSOR
    fi
    if zle .${WIDGET%-end}; then
        zle .end-of-line
    else
        CURSOR=$cursor
        MARK=$mark
        return 1
    fi
}

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end  history-search-end

bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
bindkey "^?"   backward-delete-char                   # required to delete chars
                                                      # with backspace
# Aliases
# =============================================================================
alias vpnc='sudo vpnc --local-port 0'
alias vpnc-disconnect='sudo vpnc-disconnect'
alias google='google-chrome-stable &> /dev/null &!'

# Aliases
# =============================================================================
PATH=$PATH:~/bin

# LS colors
# =============================================================================
if [ $(uname -s) = "Linux" ]; then
    LS_COLORS='di=38;5;33:ex=38;5;40:ln=36'
    export LS_COLORS
elif [ $(uname -s) = "Darwin" ]; then
    export CLICOLOR=1
    export LSCOLORS='exfxcxdxcxegedabagacad'
fi

# Prompt Customization
# =============================================================================
# git-branch information
local TURQUOISE=30
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f'
zstyle ':vcs_info:*' formats       \
    '%F{15}:<%f%F{30}%s%F{15}:%F{30}%b%F{15}>%f'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git cvs svn
vcs_info_wrapper() {
    vcs_info
    if [ -n "$vcs_info_msg_0_" ]; then
        echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
    fi
}

local turquoise="030"
local git_info=$'$(vcs_info_wrapper)'
local name="%{$FG[${turquoise}]%}%n%{$reset_color%}"
local directory="%{$FG[${turquoise}]%}%~%{$reset_color%}"

PROMPT="[${name}${git_info}:${directory}] "

# Useful Functions
# =============================================================================
smartextract () {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2) tar -jxvf $1  ;;
            *.tar.gz)  tar -zxvf $1  ;;
            *.bz2)     bunzip2 $1    ;;
            *.gz)      gunzip $1     ;;
            *.jar)     jar xf $1     ;;
            *.tar)     tar -xvf $1   ;;
            *.tbz2)    tar -jxvf $1  ;;
            *.tgz)     tar -zxvf $1  ;;
            *.zip)     unzip $1      ;;
            *.z)       uncompress $1 ;;
            *) echo "'$1' cannot be extracted via smartextract()." ;;
        esac
    else
        echo "'$1' is not a valid file."
    fi
}

sendkey() {
    cat ~/.ssh/id_rsa.pub | ssh "$1" "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
}

# Setup OpenGrok
# =============================================================================
if [ $(uname -s) = "Linux" ]; then
    export OPENGROK_TOMCAT_BASE=/usr/share/tomcat8
elif [ $(uname -s) = "Darwin" ]; then
    export OPENGROK_TOMCAT_BASE=/usr/local/Cellar/tomcat/9.0.8/libexec
fi
