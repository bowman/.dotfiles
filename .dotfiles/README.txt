
mkdir ~/.dotfiles
GIT_DIR=.dotfiles/repo.git GIT_WORK_TREE=~ git init

. .dotfiles/on
. .dotfiles/off

git config core.bare
false
git config core.worktree
$HOME

vi .dotfiles/repo.git/info/exclude # usually not distributed
vi ~/.gitignore # dangerous, others see it
# git config core.excludesfile # global

Want this distributed but don't want a ~/.gitignore used by other files
ln -s $HOME/.dotfiles/gitignore-dots $HOME/.dotfiles/repo.git/info/exclude

