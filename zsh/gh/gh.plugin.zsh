#Github repo switcher

function gh () {
  typeset +x account=$GITHUB[user]
  typeset +x repo=""

  if (( ${+argv[2]} )); then
    repo=$argv[2]
    account=$argv[1]
  elif (( ${+argv[1]} )); then
    repo=$argv[1]
  else
    echo "USAGE: gh [user] [repo]"
    return 127
  fi

  typeset +x directory=$HOME/src/github.com/$account/$repo
  if [[ ! -a $directory ]]; then
    git clone git@github.com:$account/$repo $directory
    if [[ ! -a $directory ]]; then
      return 127
    fi
  fi

  cd $directory
}
