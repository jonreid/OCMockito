#!/usr/bin/env bash
set -euo pipefail

GH_TOKEN="$GITHUB_TOKEN" gh pr merge --auto --rebase "$PR_URL"
