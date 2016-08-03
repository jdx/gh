function gh
  set -l repo ""

  if [ (count $argv) -ne 2 ]
    echo "USAGE: gh [user] [repo]"
    return -1
  end

  set user $argv[1]
  set repo $argv[2]

  set -l path $HOME/src/github.com/$user/$repo
  if not test -d $path
    git clone git@github.com:$user/$repo.git $path
  end

  cd $path
end
