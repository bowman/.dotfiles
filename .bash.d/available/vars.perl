
export PERL5LIB="$HOME/perl5/lib/perl5:$HOME/japh"

# local::lib
if [ -d "$HOME/perl5" ]; then
    export PERL_LOCAL_LIB_ROOT="$HOME/perl5";
    export PERL_MB_OPT="--install_base $HOME/perl5";
    export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5";
    export PERL5LIB="$HOME/perl5/lib/perl5/x86_64-linux-gnu-thread-multi:$HOME/perl5/lib/perl5:$PERL5LIB";
    export PATH="$HOME/perl5/bin:$PATH";

    # not included in local::lib, but handy
    export MANPATH="$HOME/perl5/man:$MANPATH";
fi

# vim: syntax=sh :
