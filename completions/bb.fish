if not set -q BB_BASE_DIR
    set BB_BASE_DIR $HOME/src
end

function __bb_remote_cache_clear --argument user
  set -e BB_REPOS_CACHE_$user
end

function __bb_remote_repos --argument user
  type -q jq; or return -1
  set -l repos_url https://api.bitbucket.org/2.0/repositories/$user
  curl -s $repos_url | jq -r '.values[] | select(.scm=="git") | .name'
end

function __bb_remote_repos_cached --argument user
  set -l cache_path BB_REPOS_CACHE_$user
  if not set -q $cache_path
    set -g $cache_path (__bb_remote_repos $user)
  end
  string join \n $$cache_path
end

function __bb_local_repos --argument user
  set -l path $BB_BASE_DIR/bitbucket.org/$user
  test -d $path; and command ls -L $path
end

function __bb_user_completion
  command ls -L $BB_BASE_DIR/bitbucket.org
end

function __bb_repo_completion
  set -l cmd (commandline -o)
  set -l user $cmd[2]
  set -l repos (__bb_local_repos $user) (__bb_remote_repos_cached $user)
  string join \n $repos | sort | uniq -du
end

complete -c bb -n '__fish_is_token_n 2' --arguments '(__bb_user_completion)' --no-files
complete -c bb -n '__fish_is_token_n 3' --arguments '(__bb_repo_completion)' --no-files
