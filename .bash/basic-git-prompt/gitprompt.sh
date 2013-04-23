function setGitPrompt {
    local dir=. head
    until [ "$dir" -ef / ]; do
        if [ -f "$dir/.git/HEAD" ]; then
            head=$(< "$dir/.git/HEAD")
            if [[ $head == ref:\ refs/heads/* ]]; then
                git_branch=" [${head#*/*/}]"
            elif [[ $head != '' ]]; then
                git_branch=' [(detached)]'
            else
                git_branch=' [(unknown)]'
            fi
            echo "$git_branch";
            return
        fi
        dir="../$dir"
    done
    git_branch=''
    echo "$git_branch";
}
