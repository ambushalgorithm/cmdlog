#!/usr/bin/env bats
# Unit tests for cmdlog filter matching

@test "filter matching - basic patterns" {
    # Simulate filter matching logic
    cmd="wget http://example.com"
    filter="wget"
    
    # Simple substring match
    [[ "$cmd" == *"$filter"* ]]
}

@test "filter matching - regex patterns" {
    cmd="curl --disable http://169.254.169.254/metadata"
    filter="169\.254\.169\.254"
    
    [[ "$cmd" =~ $filter ]]
}

@test "filter matching - full command match" {
    cmd="git status --porcelain"
    filter="^git status --porcelain$"
    
    [[ "$cmd" =~ $filter ]]
}

@test "filter matching - multiple filters" {
    cmd="head -n 1"
    filters=("head" "tail" "grep")
    
    matched=0
    for f in "${filters[@]}"; do
        if [[ "$cmd" == *"$f"* ]]; then
            matched=1
            break
        fi
    done
    
    [ "$matched" -eq 1 ]
}

@test "filter NOT matching" {
    cmd="git push origin main"
    filter="^wget"
    
    [[ ! "$cmd" =~ $filter ]]
}

@test "filter matching - awk patterns" {
    cmd="awk BEGIN { print 'test' }"
    filter="^awk BEGIN"
    
    [[ "$cmd" =~ $filter ]]
}

@test "filter matching - proc filesystem" {
    cmd="ls /proc/1234/fd"
    filter="/proc/[0-9]+/fd"
    
    [[ "$cmd" =~ $filter ]]
}

@test "filter matching - cloud metadata" {
    cmd="curl -s http://169.254.169.254/latest/meta-data/"
    filter="169\.254\.169\.254"
    
    [[ "$cmd" =~ $filter ]]
}

@test "filter matching - nvm paths" {
    cmd="/home/user/.nvm/versions/node/v18.0.0/bin/node"
    filter="\.nvm/versions"
    
    [[ "$cmd" =~ $filter ]]
}

@test "filter matching - exit codes" {
    cmd="exit 0"
    filter="^exit [0-9]+"
    
    [[ "$cmd" =~ $filter ]]
}
