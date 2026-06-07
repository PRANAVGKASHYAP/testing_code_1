#!/usr/bin/env bash
set -euo pipefail

REPO_NAME="GITHUB_TESTING"
DESCRIPTION="Repository created via AI assistant"
VISIBILITY="public"

command -v gh >/dev/null 2>&1 || {
  cat <<EOF
Error: GitHub CLI (gh) is not installed.
Install it from https://cli.github.com/ or use the curl example below.
Curl example (requires a PAT with repo scope):
  curl -H "Authorization: token YOUR_PAT" \\
    -d '{"name":"'"$REPO_NAME"'","description":"'"$DESCRIPTION"'","private":false}' \\
    https://api.github.com/user/repos
EOF
  exit 1
}

# Check auth
if ! gh auth status >/dev/null 2>&1; then
  echo "You are not authenticated with gh. Run: gh auth login"
  exit 1
fi

# Create the repository
echo "Creating repository: $REPO_NAME"
gh repo create "$REPO_NAME" --"$VISIBILITY" --description "$DESCRIPTION" --confirm

echo "Repository created. You can now clone or push to it:"
echo "  git clone git@github.com:\$(gh api user --jq .login)/$REPO_NAME.git"