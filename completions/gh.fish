if not set -q GH_BASE_DIR
    set GH_BASE_DIR $HOME/src
end

function __gh_user_completion
  command ls -L $GH_BASE_DIR/github.com
end

function __gh_repo_completion
  set -l cmd (commandline -o)
  set -l user $cmd[2]
  set -l cache_path GH_REPOS_CACHE_$user
  set -l repo_dir $GH_BASE_DIR/github.com/$user
  set -l repos ""

  if test -d $repo_dir
    set repos (command ls -L $repo_dir)
  end

  # if 'jq' is available and remote repository cache is not set yet
  if type -q jq; and not set -q $cache_path
    set -l repos_url https://api.github.com/users/$user/repos
    set -xU $cache_path (curl --silent $repos_url | jq -r '.[] | "\(.name)"')
  end
  printf "%s\n%s\n" $$cache_path $repos | sort | uniq -du
end

complete -c gh -n '__fish_is_token_n 2' --arguments '(__gh_user_completion)' --no-files
complete -c gh -n '__fish_is_token_n 3' --arguments '(__gh_repo_completion)' --no-files
