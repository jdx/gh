if not set -q GH_BASE_DIR
    set GH_BASE_DIR $HOME/src
end

function gh -d "manage git repos"
  set git_host github.com
  set -l repo ""

  if [ (count $argv) -eq 1 ]
    set repo $argv[1]
  else if [ (count $argv) -eq 2 ]
    set repo $argv[1]/$argv[2]
  else
    echo "USAGE: gh [user] [repo]"
    return -1
  end

  set -l path $GH_BASE_DIR/$git_host/$repo
  if not test -d $path
    git clone git@$git_host:$repo.git $path
    cd $path; and git branch --set-upstream-to=origin/master master
  end

  cd $path
end
