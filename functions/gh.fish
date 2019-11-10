if not set -q GH_BASE_DIR
    set GH_BASE_DIR $HOME/src
end
# Resolve minor bug in issue #44.
## https://github.com/jdxcode/gh/issues/44
if test "/" = (string sub --start -1 --length 1 $GH_BASE_DIR)
  set -l length (string length $GH_BASE_DIR)
  set -l length (math -- $length - 1)
  set -x GH_BASE_DIR (string sub --length $length $GH_BASE_DIR)
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
    git clone --recursive git@$git_host:$repo.git $path
    cd $path; and git branch --set-upstream-to=origin/master master
  end

  cd $path
end
