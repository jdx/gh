if not set -q GH_BASE_DIR
    set GH_BASE_DIR $HOME/src
end

function __gh_remote_cache_clear --argument user
  set -e GH_REPOS_CACHE_$user
end

function __gh_remote_repos --argument user
  type -q jq; or return -1
  set -l repos_url https://api.github.com/users/$user/repos
  curl -s $repos_url | jq -r '.[] | "\(.name)"'
end

function __gh_remote_repos_cached --argument user
  set -l cache_path GH_REPOS_CACHE_$user
  if not set -q $cache_path
    set -g $cache_path (__gh_remote_repos $user)
  end
  string join \n $$cache_path
end

function __gh_local_repos --argument user
  set -l path $GH_BASE_DIR/github.com/$user
  test -d $path; and command ls -L $path
end

function __gh_user_completion
  command ls -L $GH_BASE_DIR/github.com
end

function __gh_repo_completion
  set -l cmd (commandline -o)
  set -l user $cmd[2]
  set -l repos (__gh_local_repos $user) (__gh_remote_repos_cached $user)
  string join \n $repos | sort | uniq -du
end

complete -c gh -n '__fish_is_token_n 2' --arguments '(__gh_user_completion)' --no-files
complete -c gh -n '__fish_is_token_n 3' --arguments '(__gh_repo_completion)' --no-files
