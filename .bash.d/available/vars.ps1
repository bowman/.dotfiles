# set a fancy prompt
# PS1='\u@\h:\w\$ '

type -t has > /dev/null || . .bash.d/available/func.has

# export PROMPT_DIRTRIM=2

if [ `id -u` = 0 ]; then
    # root gets a red prompt
    export PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\w # '

else

    if [ "z$SSH_CONNECTION" != "z" ] ; then
        PS1='[\u@\h:\W'
    else
        PS1='[$(date +%H:%M) \W'
    fi

    if has __git_ps1 ; then
        # http://zerokspot.com/weblog/2008/12/04/git-branches-and-ps1/
        PS1=$PS1'$(__git_ps1 " (%s)")'
    fi

    export PS1=$PS1']$ '
fi

# vim: syntax=sh :
