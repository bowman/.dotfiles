
The idea to keep your .dotfiles in your $HOME where they belong,
but making the check-out-ness of your $HOME something you toggle.

Bootstrap a new machine:

    source <( \
     curl -L https://raw.github.com/bowman/.dotfiles/master/.dotfiles/setup.sh \
    )

    source <( curl -L http://tinyurl.com/bsbdotfiles )

vi .dotfiles/repo.git/info/exclude # usually not distributed
vi ~/.gitignore # dangerous, others see it
# git config core.excludesfile # global

Want this distributed but don't want a ~/.gitignore used by other files
ln -s $HOME/.dotfiles/gitignore-dots $HOME/.dotfiles/repo.git/info/exclude

Check against /usr/share/git-core/templates/info/exclude ?

Fancy Alternative:
https://github.com/RichiH/vcsh


Dirty Updates
=============

How to to a dangerous checkout to a dirty directory, into a $HOME
that has existing files, possibly with conflicts.

Note that this may end up trashing files, including untracked ones.
I have no idea if this is anywhere close to safe and I suspect that
if something goes wrong you could be left with quite a mess.

These instructions assume that you have no new local changes
(it doesn't do a rebase).

git fetch # download FETCH_HEAD

# Check HEAD is an ancestor of FETCH_HEAD
cmp <( git rev-parse HEAD ) <( git merge-base HEAD FETCH_HEAD ) \
    || echo "merge-base is not HEAD, not fast forward"

# merge FETCH_HEAD into HEAD in index (2 tree merge is ff, no local changes)
# (no -u means the work tree is not updated)
git read-tree -v -m  HEAD FETCH_HEAD # --trivial ?
# index now merged with FETCH_HEAD

# set HEAD to be FETCH_HEAD with dereferencing
git update-ref HEAD FETCH_HEAD

# update work tree without overwriting existing files (not forced)
git checkout-index -a

# can now check diffs for conflicts add either commit/edit/checkout
git diff --stat

git pull -v # should be a no-op

# Information
git rev-parse HEAD FETCH_HEAD   # what do they point to
git diff --stat HEAD FETCH_HEAD # differences
git merge-base HEAD FETCH_HEAD  # common ancestor
for r in HEAD FETCH_HEAD; do echo $r ; git log --oneline $r | head -1; done
git name-rev $( git merge-base HEAD FETCH_HEAD )

# peek at index
git ls-files --directory --exclude-standard --stage

git diff-index --cached FETCH_HEAD # see "local changes" carried forward
