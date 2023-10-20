#!/bin/bash

# Name the files added/copied/modified to the git index
FILES=$(git diff --cached --name-only --diff-filter=ACM)

PATTERNS=(
    "AKIA[0-9A-Z]{16}"
    "Bearer [0-9a-fA-F]{40}"
    "[0-9a-fA-F]{32}"
    "[0-9a-fA-F]{64}"
    "-----BEGIN [A-Z]+ PRIVATE KEY-----"
    "-----BEGIN PGP PRIVATE KEY BLOCK-----"
    "client_id=[0-9a-zA-Z]{32}"
    "client_secret=[0-9a-zA-Z]{32}"
    "mongodb+srv://"
    "postgres://"
    "mysql://"
    "sk_live_[0-9a-zA-Z]{24}"
    "pk_live_[0-9a-zA-Z]{24}"
    "password="
    "pwd="
    "passwd="
    "xox[bp]-[0-9a-zA-Z]{10,48}"
    "SG\.[0-9a-zA-Z]{16,48}"
)

echo "Processing secrets security check..."

for file in $FILES
do
    for pattern in "${PATTERNS[@]}"
    do
        if grep -qE "$pattern" -- "$file"; then
            echo "Warning! Found pattern '$pattern' in $file"
            exit 1
        fi
    done
done

exit 0