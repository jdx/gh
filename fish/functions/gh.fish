function gh
  set -l user $GITHUB
  set -l repo ""

  switch (count $argv)
  case 0
    cd $HOME/src/github.com/$user
    return
  case 1
    set repo $argv[1]
  case 2
    set user $argv[1]
    set repo $argv[2]
  case '*'
    echo "USAGE: g [user] [repo]"
    return 127
  end

  set -l path $HOME/src/github.com/$user/$repo
  if not test -d $path
    hub clone -p $user/$repo $path
  end

  cd $path
end
