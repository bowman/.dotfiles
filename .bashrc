# ~/.bashrc: executed by bash(1) for non-login shells (login via .bash_profile)
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)

# If running interactively, then:
if [ "$PS1" ]; then

    . ~/.bash.d/available/func.has # aliases need
    . ~/.bash.d/available/complete.core # vars.ps1 needs

    . ~/.bash.d/available/stty
    . ~/.bash.d/available/set.core
    . ~/.bash.d/available/shopt.core
    . ~/.bash.d/available/func.core
    . ~/.bash.d/available/func.misc
    . ~/.bash.d/available/func.cd
    . ~/.bash.d/available/vars.path
    . ~/.bash.d/available/vars.core
    . ~/.bash.d/available/vars.ps1
    . ~/.bash.d/available/vars.perl
    . ~/.bash.d/available/vars.misc
    . ~/.bash.d/available/alias.core
    . ~/.bash.d/available/alias.git
    . ~/.bash.d/available/alias.misc
    . ~/.bash.d/available/alias.node

    srcif ~/.bash.d/identity/debian

    # custom for a given user (shared accounts)
    srcif ~/.bashrc.${USER}
    # tweaks for a given machine
    srcif ~/.bashrc.${USER}_local

    # echo 'echo "Appointment 12:30" | write '$USER | at 12:00 tomorrow
    # echo 'notify-send "Appointment 12:30"' | at 12:00 tomorrow
    # echo 'notify-send -u critical -t 1000000 "THING"' | at 8:31

    # If this is an xterm set the title to user@host:dir
    case $TERM in
    xterm*|rxvt*) # breaks 'bw' compiz rule |screen)
       export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
        # export PROMPT_COMMAND='echo -ne "\033]0;bw\007"'
        ;;
    *)
        ;;
    esac

fi

# not used
if [ -d "$HOME/.bash.d/enabled" ]; then
  for i in $HOME/.bash.d/enabled/*; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi
