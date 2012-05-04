
The idea to keep your .dotfiles in your $HOME where they belong,
but making the check-out-ness of your $HOME something you toggle.

Bootstrap a new machine:

    source <( \
     curl -q https://raw.github.com/bowman/.dotfiles/master/.dotfiles/setup.sh \
    )

vi .dotfiles/repo.git/info/exclude # usually not distributed
vi ~/.gitignore # dangerous, others see it
# git config core.excludesfile # global

Want this distributed but don't want a ~/.gitignore used by other files
ln -s $HOME/.dotfiles/gitignore-dots $HOME/.dotfiles/repo.git/info/exclude

Check against /usr/share/git-core/templates/info/exclude ?

Fancy Alternative:
https://github.com/RichiH/vcsh
