# Add this to your .bashrc
_complete_gl ()
{
        COMPREPLY=()
        if [[ $COMP_CWORD -eq 1 ]]; then
          comp_arr=$(ls $HOME/src/gitlab.com;\
            ls $HOME/src/gitlab.com/$GITHUB)
        elif [[ $COMP_CWORD -eq 2 ]]; then
          local user=${COMP_WORDS[COMP_CWORD-1]}
          comp_arr=$(ls $HOME/src/gitlab.com/$user)
        else
          return 0
        fi
        cur="${COMP_WORDS[COMP_CWORD]}"
        COMPREPLY=( $(compgen -W "${comp_arr}" -- $cur))
        return 0
}
complete -F _complete_gl gl
