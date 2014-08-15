function __gh_user_completion
  ls $HOME/src/github.com
end

function __gh_repo_completion
  set -l cmd (commandline -o)
  set -l user $cmd[2]
  ls $HOME/src/github.com/$user
end

complete -c gh -n '__fish_is_token_n 2' --arguments '(__gh_user_completion)' --no-files
complete -c gh -n '__fish_is_token_n 3' --arguments '(__gh_repo_completion)' --no-files
