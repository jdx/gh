#Github repo switcher

#Requires hub to download github repositories that are not already cloned

function gh () {
  typeset +x account=$GITHUB
  typeset +x repo=""
      arr=( foo bar baz)
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
    hub clone -p $account/$repo $directory
    if [[ ! -a $directory ]]; then
      return 127
    fi
  fi

  cd $directory
}