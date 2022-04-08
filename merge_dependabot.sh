#!/bin/sh

gh pr merge --auto --rebase "$PR_URL"

if [ $? -ne 0 ]
then
    echo 'if you want github to automatically merge pull requests from dependabot, you need to create a'
    echo 'personal access token (public_repo) and assign it to settings -> secrets -> dependabot -> GH_ACTION_TOKEN'
fi
