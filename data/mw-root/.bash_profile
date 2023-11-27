
RC=`echo ${PATH} | grep "root/bin" | grep -v grep | wc -l`

if [ $RC -eq 0 ]; then
    export PATH=/root/bin:$PATH
fi

export VISUAL=vi

# -----------------------------------------------------------------------------

alias a=alias
alias m=less
alias h=history

alias d=dirs
alias po=popd
alias pd=pushd

# -----------------------------------------------------------------------------

alias vip='vi ~/.bash_profile; . ~/.bash_profile'


# -----------------------------------------------------------------------------

