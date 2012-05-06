# set a fancy prompt
# PS1='\u@\h:\w\$ '

type -t has > /dev/null || . .bash.d/available/func.has


if [ `id -u` = 0 ]; then
    # root gets a red prompt
    export PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\w # '

elif has __git_ps1 ; then
    # http://zerokspot.com/weblog/2008/12/04/git-branches-and-ps1/
    export PS1="[\$(date +%H:%M) \W"'$(__git_ps1 " (%s)")]$ '

else
    export PS1="[\$(date +%H:%M) \W]$ "
fi

# vim: syntax=sh :
