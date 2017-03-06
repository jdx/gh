GH_BASE_DIR=${GH_BASE_DIR:-$HOME/src}
GH_PROTO=${GH_PROTO:-"ssh"}
function gl() {
  if [[ $# -ne 2 ]]; then
    echo "USAGE: gl [user] [repo]"
    return
  fi

  user=$1
  repo=$2

  user_path=$GH_BASE_DIR/gitlab.com/$user
  local_path=$user_path/$repo

  if [[ ! -d $local_path ]]; then
     if [[ $GH_PROTO == "ssh" ]]; then 
      git clone git@gitlab.com:$user/$repo.git $local_path
     elif [[ $GH_PROTO == "https" ]]; then
      git clone https://gitlab.com/$user/$repo.git $local_path
     else
      echo "GH_PROTO must be set to ssh or https"
    fi
  fi

  # If git exited uncleanly, clean up the created user directory (if exists)
  # and don't try to `cd` into it.

  if [[ $? -ne 0 ]]; then
    if [[ -d $user_path ]]; then
      rm -d $user_path
    fi
  else
    cd $local_path
  fi
}
