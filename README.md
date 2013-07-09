## To use this 'rcfiles' project:

-----------------------------------------------------------------  
> **It can be installed via an included shell script: INSTALL.sh**  

-----------------------------------------------------------------  
Simply clone the git repository to wherever you'd like to keep it.
Then run the included INSTALL.sh script to have it create the links
and to modify the primary rc starters.



**OR.........................................**  
If you prefer *Manual Installation* mode...
Just follow these old vague directions:

        ln -s ~/[rcfiles.git.dir]/zshrc ~/.zshrc
        ln -s ~/[rcfiles.git.dir]/bash_profile ~/.bash_profile
        ln -s ~/[rcfiles.git.dir]/vimrc ~/.vimrc
        ln -s ~/[rcfiles.git.dir]/vim ~/.vim
        for each and every file that you want there

Of course replacing "`[rcfiles.git.dir]`" with the actual directory you've cloned
this git repo into if you haven't just moved it to your home dir straight out.

**OR.........................................**  
If your prefer actual files instead of links, then just copy the desired files
to your `$HOME` directory.


One note: there's a file named '`my_aliases`' referring to a file with mysql db
connection shortcuts which includes the passwords, hosts, etc. and thus the file
won't exist for you as it's not part of this repo of files.

Sooooo... either delete the reference to it, or create your own file in its
places or not.

-Jamin-

