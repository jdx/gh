#Bitbucket repo switcher

GH_BASE_DIR=${GH_BASE_DIR:-$HOME/src}
GH_PROTO=${GH_PROTO:-"ssh"}
function bb () {
  typeset +x account=$BITBUCKET[user]
  typeset +x repo=""

  if (( ${+argv[2]} )); then
    repo=$argv[2]
    account=$argv[1]
  elif (( ${+argv[1]} )); then
    repo=$argv[1]
  else
    echo "USAGE: bb [user] [repo]"
    return 127
  fi
  typeset +x directory=$GH_BASE_DIR/bitbucket.org/$account/$repo
  if [[ ! -a $directory ]]; then
   if [[ $GH_PROTO == "ssh" ]]; then 
      git clone git@bitbucket.org:$account/$repo.git $directory
     else
      echo "GH_PROTO must be set to ssh"
    fi
    if [[ ! -a $directory ]]; then
      return 127
    fi
  fi

  cd $directory
}
