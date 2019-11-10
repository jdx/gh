if not set -q GL_BASE_DIR
    set GL_BASE_DIR $HOME/src
end
# Resolve minor bug in issue #44.
## https://github.com/jdxcode/gh/issues/44
if test "/" = (string sub --start -1 --length 1 $GL_BASE_DIR)
  set -l length (string length $GL_BASE_DIR)
  set -l length (math -- $length - 1)
  set -x GL_BASE_DIR (string sub --length $length $GL_BASE_DIR)
end


function gl
  set git_host gitlab.com
  set -l repo ""

  if [ (count $argv) -ne 2 ]
    echo "USAGE: gl [user] [repo]"
    return -1
  end

  set user $argv[1]
  set repo $argv[2]

  set -l path $GL_BASE_DIR/$git_host/$user/$repo
  if not test -d $path
    git clone --recursive git@$git_host:$user/$repo.git $path
  end

  cd $path
end
