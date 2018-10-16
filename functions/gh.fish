if not set -q GH_BASE_DIR
    set GH_BASE_DIR $HOME/src
end

function __gh_add_upstream_remote --argument repo
    set -l url https://api.github.com/repos/$repo
    set -l parent_repo (curl -s $url | jq -r 'select(.parent != null) | .parent | .full_name')
    if test -n "$parent_repo"
        git remote add upstream git@github.com:$parent_repo.git
    end
end

function gh -d "manage git repos"
    set git_host github.com
    set -l repo ""

    if [ (count $argv) -eq 1 ]
        set repo $argv[1]
    else if [ (count $argv) -eq 2 ]
        set repo $argv[1]/$argv[2]
    else
        echo "USAGE: gh [user] [repo]"
        return -1
    end

    set -l path $GH_BASE_DIR/$git_host/$repo
    if not test -d $path
        git clone git@$git_host:$repo.git $path
        cd $path
        and git branch --set-upstream-to=origin/master master
        and __gh_add_upstream_remote $repo
    end

    cd $path
end
