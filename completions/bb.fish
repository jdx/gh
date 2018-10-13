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
  set -l cache_path BB_REPOS_CACHE_$user
  set -l repo_dir $BB_BASE_DIR/$GIT_HOST/$user
  set -l repos ""

  if test -d $repo_dir
    set repos (command ls -L $repo_dir)
  end
  # if 'jq' is available and remote repository cache is not set yet
  if type -q jq; and not set -q $cache_path
    set -l repos_url https://api.bitbucket.org/2.0/repositories/$user
    set -xU $cache_path (curl --silent $repos_url | jq -r '.values[] | select(.scm=="git") | .name')
  end
  printf "%s\n%s\n" $$cache_path $repos | sort | uniq -du
end

complete -c bb -n '__fish_is_token_n 2' --arguments '(__bb_user_completion)' --no-files
complete -c bb -n '__fish_is_token_n 3' --arguments '(__bb_repo_completion)' --no-files
