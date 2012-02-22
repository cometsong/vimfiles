#/bin/sh
# ---------------------------------------------------------------------------- #
#                      shell profile of JaminOne rcfiles                       #
#    (This file is sourced by .bashrc and by .zshrc in interactive sessions.)  #
# ---------------------------------------------------------------------------- #

##### load RCPATH env var #####
source $HOME/.rcpath_env

##### multi-dotfile setup ##### 
source $RCPATH/colors          # load color vars
source $RCPATH/aliases         # load aliases 
source $RCPATH/sh_functions    # load sh functions
if [[ -e $RCPATH/my_aliases ]]; then source $RCPATH/my_aliases; fi  # if 'my' password-full alias file exists, source it.


##### Config Vars #####
TZ="Europe/Zurich"
HISTFILE=$HOME/.history
HISTSIZE=2000
SAVEHIST=$HISTSIZE
PAGER='less'
HOSTNAME=`uname -n`
umask 002

##### LANGUAGE #####
LC_ALL='en_US.UTF-8'
LANG='en_US.UTF-8'
LC_CTYPE=$LANG


# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi


##### Operating Situations #####
function current_os {
  # If Darwin (OS X)
    if [[ `uname -s` = "Darwin" ]]; then export APPLE=TRUE; fi
  # If Linux (Ubuntu,RedHat,etc)
    if [[ `uname -s` = "Linux" ]];  then export LINUX=TRUE; fi
  }
# run current_os func here:
current_os

if [[ -n $APPLE ]]; then EDITOR="mvim"; fi # on Mac, use GUI macvim
if [[ -n $LINUX ]]; then EDITOR='gvim'; fi # on linux, use GUI gvim


