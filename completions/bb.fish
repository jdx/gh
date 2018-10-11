set GIT_HOST bitbucket.org
if not set -q BB_BASE_DIR
    set BB_BASE_DIR $HOME/src
end

function __bb_user_completion
  command ls -L $BB_BASE_DIR/$GIT_HOST
end

function __bb_repo_completion
  set -l cmd (commandline -o)
  set -l user $cmd[2]
  command ls -L $BB_BASE_DIR/$GIT_HOST/$user
end

complete -c bb -n '__fish_is_token_n 2' --arguments '(__bb_user_completion)' --no-files
complete -c bb -n '__fish_is_token_n 3' --arguments '(__bb_repo_completion)' --no-files
