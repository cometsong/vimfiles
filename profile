###########################
#                         #
#     JaminOne, v0.6      #
#                         #
###########################

# Base .profile Config for .rcfiles

##### Situations #####
function current_os {
  # If Darwin (OS X)
    if [[ `uname -s` = "Darwin" ]] export APPLE=TRUE;
  # If Linux (Ubuntu,RedHat,etc)
    if [[ `uname -s` = "Linux" ]]  export LINUX=TRUE;
  }
# run current_os func here:
current_os

##### Config Vars #####
TZ="Europe/Zurich"
HISTFILE=$HOME/.zsh_history
HISTSIZE=2000
SAVEHIST=$HISTSIZE
PAGER='less'
HOSTNAME=`uname -n`

#LANGUAGE=
LC_ALL='en_US.UTF-8'
LANG='en_US.UTF-8'
LC_CTYPE=C
DISPLAY=:0

if [[ -n $APPLE ]] EDITOR='vim'   # on Mac, use CLI vim
if [[ -n $LINUX ]] EDITOR='gvim'  # on linux, use GUI gvim


export PATH=/usr/local/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/libexec:${HOME}/bin
export PATH=${PATH}:/usr/local/mysql/bin:/usr/local/git/bin:/opt/php/bin

# Set path to rcfiles git repository
RCPATH=/Users/leopold/code/rcfiles
# multi-dotfile setup
source $RCPATH/colors          # load color vars
source $RCPATH/aliases         # load aliases 
source $RCPATH/sh_functions    # load sh functions
if [[ -e $RCPATH/my_aliases ]] source $RCPATH/my_aliases # if 'mysql' file exists, source it.


