DOTFILES_DIR="dotfiles"
DOTFILES_REPOS="git@github.com:kabostime/dotfiles.git"

[[ -e ~/$DOTFILES_DIR ]] || git clone $DOTFILES_REPOS ~/$DOTFILES_DIR
pushd ~/$DOTFILES_DIR
 
git submodule init
git submodule update

for i in `ls -a`
do
  [ $i = "." ] && continue
  [ $i = ".." ] && continue
  [ $i = ".git" ] && continue
  [ $i = "README.md" ] && continue
  [ $i = ".oh-my-zsh.zsh" ] && continue
  ln -s -f ~/$DOTFILES_DIR/$i ~/
done

ln -s -f ~/$DOTFILES_DIR/.zshrc ~/.oh-my-zsh/custom/my.zsh
ln -s -f ~/$DOTFILES_DIR/.zshrc ~/my.zsh
ln -s -f ~/$DOTFILES_DIR/.oh-my-zsh.zsh ~/.zshrc

vim -c ':BundleInstall!' -c ':q!' -c ':q!'
 
popd
