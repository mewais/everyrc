# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# We use preexec and precmd hook functions for Bash
# If you have anything that's using the Debug Trap or PROMPT_COMMAND
# change it to use preexec or precmd
# See also https://github.com/rcaloras/bash-preexec

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0232323" #black
    echo -en "\e]P82B2B2B" #darkgrey
    echo -en "\e]P1D75F5F" #darkred
    echo -en "\e]P9E33636" #red
    echo -en "\e]P287AF5F" #darkgreen
    echo -en "\e]PA98E34D" #green
    echo -en "\e]P3D7AF87" #brown
    echo -en "\e]PBFFD75F" #yellow
    echo -en "\e]P48787AF" #darkblue
    echo -en "\e]PC7373C9" #blue
    echo -en "\e]P5BD53A5" #darkmagenta
    echo -en "\e]PDD633B2" #magenta
    echo -en "\e]P65FAFAF" #darkcyan
    echo -en "\e]PE44C9C9" #cyan
    echo -en "\e]P7E5E5E5" #lightgrey
    echo -en "\e]PFFFFFFF" #white
    clear #for background artifacting
    color_prompt=yes
fi

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# If this is an xterm set more declarative titles 
# "dir: last_cmd" and "actual_cmd" during execution
# If you want to exclude a cmd from being printed see line 156
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\$(print_title)\a\]$PS1"
    __el_LAST_EXECUTED_COMMAND=""
    print_title () 
    {
        __el_FIRSTPART=""
        __el_SECONDPART=""
        if [ "$PWD" == "$HOME" ]; then
            __el_FIRSTPART=$(gettext --domain="pantheon-files" "Home")
        else
            if [ "$PWD" == "/" ]; then
                __el_FIRSTPART="/"
            else
                __el_FIRSTPART="${PWD##*/}"
            fi
        fi
        if [[ "$__el_LAST_EXECUTED_COMMAND" == "" ]]; then
            echo "$__el_FIRSTPART"
            return
        fi
        #trim the command to the first segment and strip sudo
        if [[ "$__el_LAST_EXECUTED_COMMAND" == sudo* ]]; then
            __el_SECONDPART="${__el_LAST_EXECUTED_COMMAND:5}"
            __el_SECONDPART="${__el_SECONDPART%% *}"
        else
            __el_SECONDPART="${__el_LAST_EXECUTED_COMMAND%% *}"
        fi 
        printf "%s: %s" "$__el_FIRSTPART" "$__el_SECONDPART"
    }
    put_title()
    {
        __el_LAST_EXECUTED_COMMAND="${BASH_COMMAND}"
        printf "\033]0;%s\007" "$1"
    }
    
    # Show the currently running command in the terminal title:
    # http://www.davidpashley.com/articles/xterm-titles-with-bash.html
    update_tab_command()
    {
        # catch blacklisted commands and nested escapes
        case "$BASH_COMMAND" in
            *\033]0*|update_*|echo*|printf*|clear*|cd*)
            __el_LAST_EXECUTED_COMMAND=""
                ;;
            *)
            put_title "${BASH_COMMAND}"
            ;;
        esac
    }
    preexec_functions+=(update_tab_command)
    ;;
*)
    ;;
esac

##################################################################################################
############################################ ALIASES #############################################
##################################################################################################
alias vtop='vtop --theme wizard'

##################################################################################################
############################################## PS1 ###############################################
##################################################################################################
export XDG_CONFIG_DIRS=$XDG_CONFIG_DIRS:~/.config/
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh

##################################################################################################
############################################## PIN ###############################################
##################################################################################################
export PINPATH=/work/mewais/pin
export PATH=$PATH:$PINPATH
alias vim='nvim'

##################################################################################################
############################################ ECLIPSE #############################################
##################################################################################################
export ECLIPSE_HOME=/media/mewais/Work/Softwares/Eclipse/eclipse
export PATH=$ECLIPSE_HOME:$PATH

##################################################################################################
############################################# MENTOR #############################################
##################################################################################################
export MENTOR_HOME=/media/mewais/Work/Softwares/Mentor/
export MODELSIM_HOME=$MENTOR_HOME/modelsim
export CALIBRE_HOME=$MENTOR_HOME/calibre/ixl_cal_2011.2_34.26
export MGLS_LICENSE_FILE=$MENTOR_HOME/license.dat

export MGC_HOME=$CALIBRE_HOME
export PATH=$MODELSIM_HOME/modeltech/bin:$CALIBRE_HOME/bin:$PATH
alias vsim='LD_PRELOAD=/media/mewais/Work/Softwares/Mentor/modelsim/libfreetype.so.6.10.1 vsim'

##################################################################################################
############################################ SYNOPSYS ############################################
##################################################################################################
export SYNOPSYS_HOME=/media/mewais/Work/Softwares/Synopsys/
export DC_HOME=$SYNOPSYS_HOME/DC
export CD_HOME=$SYNOPSYS_HOME/CD
export CX_HOME=$SYNOPSYS_HOME/CX
export FM_HOME=$SYNOPSYS_HOME/FM
export HSPICE_HOME=$SYNOPSYS_HOME/HSpice
export ICC_HOME=$SYNOPSYS_HOME/ICC
export PT_HOME=$SYNOPSYS_HOME/PT
export SCL_HOME=$SYNOPSYS_HOME/SCL

export SNPSLMD_LICENSE_FILE=$SYNOPSYS_HOME/synopsys.dat

export PATH=$CD_HOME/bin:$DC_HOME/bin:$CX_HOME/bin:$FM_HOME/bin:$HSPICE_HOME/hspice/bin:$ICC_HOME/bin:$PT_HOME/bin:$PATH
export PATH=$SCL_HOME/linux/bin/:$PATH

##################################################################################################
############################################# ANDROID ############################################
##################################################################################################
export ANDROID_HOME=/media/mewais/Work/Softwares/Android/android-studio/
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/
export PATH=$ANDROID_HOME/bin/:$PATH
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/media/mewais/Work/Softwares/Google/google-cloud-sdk/path.bash.inc' ]; then source '/media/mewais/Work/Softwares/Google/google-cloud-sdk/path.bash.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/media/mewais/Work/Softwares/Google/google-cloud-sdk/completion.bash.inc' ]; then source '/media/mewais/Work/Softwares/Google/google-cloud-sdk/completion.bash.inc'; fi

##################################################################################################
############################################### TECH #############################################
##################################################################################################
export FREEPDK45="/work/mewais/TheECore/Tech/FreePDK45/"
export OPENRAM_HOME="/work/mewais/TheECore/Third/OpenRAM/compiler"
export OPENRAM_TECH="/work/mewais/TheECore/Third/OpenRAM/technology"

##################################################################################################
################################################ QT5 #############################################
##################################################################################################
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:"/usr/include/x86_64-linux-gnu/qt5"
