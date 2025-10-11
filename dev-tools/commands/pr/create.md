---
allowed-tools: Bash(gh pr:*), Bash(git add:*), Bash(git status:*), Bash(git commit:*)
description: Create a Pull Request
---

## Context

- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -10`
- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`
- Existing Pull Requests: !`gh pr list`

## Your task

Create a Pull Request based on the code changes.

1. Create a new branch based on the code changes
2. Generate commit information
3. Push the code to the remote repository
4. Create a Pull Request. If an upstream branch exists, create the Pull Request based on the upstream branch; otherwise, create it based on the origin branch
