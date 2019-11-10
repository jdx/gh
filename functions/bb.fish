if not set -q BB_BASE_DIR
    set BB_BASE_DIR $HOME/src
end
# Resolve minor bug in issue #44.
## https://github.com/jdxcode/gh/issues/44
if test "/" = (string sub --start -1 --length 1 $BB_BASE_DIR)
  set -l length (string length $BB_BASE_DIR)
  set -l length (math -- $length - 1)
  set -x BB_BASE_DIR (string sub --length $length $BB_BASE_DIR)
end


function bb
  set git_host bitbucket.org
  set -l repo ""

  if [ (count $argv) -ne 2 ]
    echo "USAGE: bb [user] [repo]"
    return -1
  end

  set user $argv[1]
  set repo $argv[2]

  set -l path $BB_BASE_DIR/$git_host/$user/$repo
  if not test -d $path
    git clone --recursive git@$git_host:$user/$repo.git $path
  end

  cd $path
end
