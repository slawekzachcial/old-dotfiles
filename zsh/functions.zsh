
#
# Common functions
#

function c {
    cd ~/Workspace/$1
}

function svndiff {
    svn diff "${@}" | colordiff | less
}

#
# Linux functions
#

function ssh {
    # The commands in "if" create a new shell, detached from its parent (nohup + parenthesis) and then exit the current terminal

    if [[ $# -eq 1 ]] && [[ $1 =~ '-pro-' ]]; then
        #(nohup urxvt -bg "[50]#C00000" -e sh -c "TERM=xterm /usr/bin/ssh $1" &) ; exit
        urxvt -bg "#6C0000" -e sh -c "TERM=xterm /usr/bin/ssh $1" &
    elif [[ $# -eq 1 ]] && [[ $1 =~ '-itg-' ]]; then
        #(nohup urxvt -bg "[50]#4472C4" -e sh -c "TERM=xterm /usr/bin/ssh $1" &) ; exit
        urxvt -bg "#1F314B" -e sh -c "TERM=xterm /usr/bin/ssh $1" &
    else
        TERM=xterm /usr/bin/ssh "$@"
    fi


#    ([[ $# -eq 1 ]] && [[ $1 =~ '-pro-' ]] && urxvt -bg "[50]#C00000" -e sh -c "TERM=xterm /usr/bin/ssh $1") || \
#    ([[ $# -eq 1 ]] && [[ $1 =~ '-itg-' ]] && urxvt -bg "[50]#4472C4" -e sh -c "TERM=xterm /usr/bin/ssh $1") || \
#    TERM=xterm /usr/bin/ssh "$@"
}


function start-ssh-agent {
    export SSH_AUTH_SOCK=/tmp/.ssh-$USERNAME-socket

    # ssh-agent automated start
    ssh-add -l &>/dev/null

    if [[ $? = 2 ]]; then

        # Delete the socket file in case the agent was not shutdown correctly
        rm -f $SSH_AUTH_SOCK

        # Exit status 2 means couldn't connect to ssh-agent; start one now
        ssh-agent -a $SSH_AUTH_SOCK >/tmp/.ssh-$USERNAME-script
        . /tmp/.ssh-$USERNAME-script
        echo $SSH_AGENT_PID >/tmp/.ssh-$USERNAME-agent-pid

        # Add my private key
        #ssh-add ${HOME}/.ssh/DCC-PrivateKey-OpenSSH
        ssh-add ${HOME}/.ssh/id_rsa
    fi
}

function kill-ssh-agent {
    pid=$(cat /tmp/.ssh-$USERNAME-agent-pid)
    kill $pid
}

function leinrepl {
    breakchars="(){}[],^%$#@\"\";:''|\\"
    CLOJURE_JAR="$HOME/.m2/repository/org/clojure/clojure/1.4.0/clojure-1.4.0.jar"
    JAVA_EXE="$JAVA_HOME/bin/java"
    rlwrap --remember -c -b "$breakchars" -f "$HOME"/.clj_completions lein repl
}

function bc3 {
    bcompare "$@" &
}

