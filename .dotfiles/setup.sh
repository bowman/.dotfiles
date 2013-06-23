# quickstart
cd ~ # go HOME
git clone --bare -n git://github.com/$(git config github.user || echo bowman)/.dotfiles.git ~/.dotfiles/repo.git
git config -f .dotfiles/repo.git/config core.bare false
git config -f .dotfiles/repo.git/config core.logallrefupdates true
git config -f .dotfiles/repo.git/config core.worktree $HOME
export GIT_DIR=~/.dotfiles/repo.git ;  export GIT_WORK_TREE=~
git read-tree -v HEAD
git checkout-index -a # all files without overwriting
source ~/.dotfiles/on
git status
ln -sf $HOME/.dotfiles/gitignore-dots $HOME/.dotfiles/repo.git/info/exclude
git status
echo ". .dotfiles/on # to enter dotfiles edit mode"
