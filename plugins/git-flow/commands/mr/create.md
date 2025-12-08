---
allowed-tools: Bash(glab mr:*), Bash(git add:*), Bash(git status:*), Bash(git commit:*)
description: Create a Merge Request
---

## Context

- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -10`
- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`
- Existing Merge Requests: !`glab mr list`

## Your task

You are a senior engineer. Please create a branch, generate commits, and create a Merge Request (MR) using `glab` based on code changes.

Required description document structure:

## Title

Concisely describe the core content of this MR (e.g., "Fix parameter validation error in user registration API")

## Background

Explain why this change is needed, which may include:

- Issues / bugs encountered
- New requirements / business scenarios
- Existing limitations in the current code

## Changes

List the main modifications in this MR using bullet points:

- ✏️ Which modules or files were modified
- 🧠 New logic or optimization points introduced
- ❌ Content deleted or refactored

## Test Plan

Describe what tests you performed to verify the correctness of the changes:

- ✅ Unit tests (covering which functionalities)
- 👀 Manual verification (which pages or interfaces)
- 🧪 Whether CI/CD pipeline passes

## Risk & Impact

List potential risk points and whether additional attention is needed:

- Which users or functionalities will be affected
- Whether database migration / cache clearing / configuration changes are needed
- Rollback strategy (if applicable)

## Additional Notes (Optional)

- Whether this MR depends on other PRs / MRs
- Whether documentation changes are included
