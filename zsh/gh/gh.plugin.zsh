#Github repo switcher

GH_BASE_DIR=${GH_BASE_DIR:-$HOME/src}
GH_PROTO=${GH_PROTO:-"ssh"}
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
  typeset +x directory=$GH_BASE_DIR/github.com/$account/$repo
  if [[ ! -a $directory ]]; then
   if [[ $GH_PROTO == "ssh" ]]; then 
      git clone --recursive git@github.com:$account/$repo.git $directory
     elif [[ $GH_PROTO == "https" ]]; then
      git clone --recursive https://github.com/$account/$repo.git $directory
     else
      echo "GH_PROTO must be set to ssh or https"
    fi
    if [[ ! -a $directory ]]; then
      return 127
    fi
  fi

  cd $directory
}
