GH_BASE_DIR=${GH_BASE_DIR:-$HOME/src}
function bb
  set git_host bitbucket.org
  set -l repo ""

  if [ (count $argv) -ne 2 ]
    echo "USAGE: bb [user] [repo]"
    return -1
  end

  set user $argv[1]
  set repo $argv[2]

  set -l path $GH_BASE_DIR/$git_host/$user/$repo
  if not test -d $path
    git clone git@$git_host:$user/$repo.git $path
  end

  cd $path
end
