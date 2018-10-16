if not set -q BB_BASE_DIR
    set BB_BASE_DIR $HOME/src
end

function __bb_add_upstream_remote --argument repo
    set -l url https://api.bitbucket.org/2.0/repositories/$repo
    set -l parent_repo (curl -s $url | jq -r 'select(.parent != null) | .parent | .full_name')
    if test -n "$parent_repo"
        git remote add upstream git@bitbucket.org:$parent_repo.git
    end
end

function bb -d "manage git repos"
    set git_host bitbucket.org
    set -l repo ""

    if [ (count $argv) -eq 1 ]
        set repo $argv[1]
    else if [ (count $argv) -eq 2 ]
        set repo $argv[1]/$argv[2]
    else
        echo "USAGE: bb [user] [repo]"
        return -1
    end

    set -l path $BB_BASE_DIR/$git_host/$repo
    if not test -d $path
        git clone git@$git_host:$repo.git $path
        cd $path
        and git branch --set-upstream-to=origin/master master
        and __bb_add_upstream_remote $repo
    end

    cd $path
end
