GH_BASE_DIR=${GH_BASE_DIR:-$HOME/src}
function gh() {
  if [[ $# -ne 2 ]]; then
    echo "USAGE: gh [user] [repo]"
    return
  fi

  user=$1
  repo=$2

  user_path=$GH_BASE_DIR/$user
  local_path=$user_path/$repo

  if [[ ! -d $local_path ]]; then
    git clone git@github.com:$user/$repo.git $local_path ||
    git clone https://github.com/$user/$repo.git $local_path
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
