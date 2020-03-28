alias c='git commit -m '
alias s='git status'
alias co='git checkout'
alias gd='git diff'
alias gdc='git diff --cached'
alias amend='git commit --amend'

function ,gp {
    git log --since="${@}" --oneline|tail -1|awk '{ print $1 }'|xargs git --no-pager diff --stat
}

function ,git_delete_merged_branches {
    git branch --merged | grep -v "master" | xargs -n 1 git branch -d
}

function ,git-find-source {
    git log -S $1 --source --all ${@:2}
}

function ,git-find-regexp-source {
    git log -G $1 --source --all ${@:2}
}

function ,git-show-stash {
    # ${1:-'0'} -- first argument, default to '0'
    # stash@{<whatever>} -- stash number <whatever>
    git stash show -p stash@{${1:-'0'}}
}

alias ,git-rename-branch='git branch -m'

function ,git-revert-merge {
    echo "git reset --merge <commit-hash-right-before-the-merge>"
    echo "or"
    echo "git revert -m 1 <commit-hash-right-before-the-merge>"
    echo "The second one will create a 'reverted' commit, and keep"
    echo "all the information about merge in the tree"
    echo "The first one will just regular reset"
}

function ,git-rebase-solve-conflict-feature {
    git ls-files --unmerged | perl -n -e'/\t(.*)/ && print "$1\n"' | uniq | xargs -r git checkout --ours --
}

function ,git-rebase-solve-conflict-master {
    git ls-files --unmerged | perl -n -e'/\t(.*)/ && print "$1\n"' | uniq | xargs -r git checkout --theirs --
}
