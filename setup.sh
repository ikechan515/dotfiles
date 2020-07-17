 #!/bin/bash

  DOT_FILES=(.tmux.conf .tmux.conf.mac .zshrc .vimrc .tigrc)

 for file in ${DOT_FILES[@]}
 do
     ln -s $HOME/dotfiles/$file $HOME/$file
 done
