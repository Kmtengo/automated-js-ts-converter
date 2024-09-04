#!/bin/bash

echo "====================="

# Git configuration commands
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${GITHUB_ACTOR}"@localhost

# Git command for ensuring we can run workflows
git config --global --add safe.directory /github/workspace

# switching to the source branch of the pull request that triggered the GitHub Actions workflow.
git checkout "${GITHUB_HEAD_REF}"

# Run JavaScript to TypeScript conversion
yes | npx ts-migrate-full src --sources="./src/**/*"

# Check if any TypeScript files were generated
if [ "$(ls -A src/**/*.ts 2>/dev/null)" ]; then
  # Run tests
  npm test
else
  echo "No TypeScript files were generated. Exiting..."
  exit 1
fi

git add -A && git commit -m "Converted JS files to TS"
git push --set-upstream origin ${{ github.head_ref }}

# Comment on PR
# This assumes that you have the `gh` tool installed and authenticated
gh auth login --with-token ${{ secrets.GITHUB_TOKEN }}
gh pr comment ${{ github.event.number }} --body "JS files have been converted to TS and tests have been run successfully. Please review the changes."

# Assign reviewer
gh pr review --assignee 'Paul-Sanga'

echo "====================="
