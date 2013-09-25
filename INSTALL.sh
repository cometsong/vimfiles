#!/bin/bash

read -p "
  ==============================================================
  IMPORTANT!!!
   This file will REMOVE the vim files in your home dir (~) 
   and create softlinks to the vimfiles replacements.
  ==============================================================
   Please enter the path in which the rcfiles repository is stored.
   [default is $HOME/code/vimfiles]:" \
     -r vim_path
VIMPATH=${vim_path:=$HOME/code/vimfiles} #default value assigned if none entered


# List of rcfiles for ln from git repo dir to home dir:
lnkRCs=( vimrc gvimrc vim )

for LName in ${lnkRCs[@]} ; do {
  if (test -d $LName)                             # if it's a dir
    then  rm -rf $HOME/.$LName ;                  # rm ~/dir
          ln -sf $VIMPATH/$LName $HOME/.$LName    # create new link to dir
  else 
    if (test -e $LName);                              # if file exists
        then  rm -f $HOME/.$LName ;                   # rm ~/link
              ln -sf $VIMPATH/$LName $HOME/.$LName    # create new link to file
    fi
  fi
  echo "    Link to $LName....   $VIMPATH/$LName"
  };
done

# link all files in $VIMPATH/bin to $HOME/bin
#   create dir if does not exist
if [[ ! -d $HOME/bin ]] ; then
    mkdir $HOME/bin
fi

BINS=$(ls -1 $VIMPATH/bin)
for B in $BINS; do
    echo "    Removing $HOME/bin/$B if exists"
    (test -a $HOME/.$B || test -h $HOME/.$B) && rm -f $HOME/.$B

    echo "    Link to $HOME/bin/$B"
    ln -sf $VIMPATH/bin/$B $HOME/bin/$B               # create new link to rcfile
done


#"Done"

