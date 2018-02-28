# Add this to your .bashrc
_complete_gh ()
{
        COMPREPLY=()
        if [[ $COMP_CWORD -eq 1 ]]; then
          comp_arr=$(ls $GH_BASE_DIR/github.com;\
            ls $GH_BASE_DIR/github.com/$GITHUB)
        elif [[ $COMP_CWORD -eq 2 ]]; then
          local user=${COMP_WORDS[COMP_CWORD-1]}
          comp_arr=$(ls $GH_BASE_DIR/github.com/$user)
        else
          return 0
        fi
        cur="${COMP_WORDS[COMP_CWORD]}"
        COMPREPLY=( $(compgen -W "${comp_arr}" -- $cur))
        return 0
}
complete -F _complete_gh gh
