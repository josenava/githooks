#!/bin/bash
# Waiting till pylint --under-score gets released.

greaterThan() {
    # awk comes to rescue when using floats
    awk -v n1="$1" -v n2="$2" 'BEGIN {print (n1>=n2)}'
}

pylintScore() {
    py_files=$2
    target_score=$1
    score=$(pylint $py_files | sed -n -e 's/^Your code has been rated at \([0-9]\{1,2\}\.[0-9]\{1,2\}\).*/\1/p')
    is_ok=$(greaterThan $score $target_score)

    if [ "$is_ok" -eq "0" ]; then
        echo "expected score: ${target_score}, got: ${score}"
        return 1
    else
        echo "score ${score}"
        return 0
    fi
}
