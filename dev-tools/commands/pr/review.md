---
allowed-tools: Bash(gh pr:*), Bash(git branch:*), Bash(git log:*)
description: Review Pull Request
---

## Context

- Current PR status: !`gh pr view $ARGUMENTS --json state -q '.state'`
- Current PR diff: !`gh pr diff $ARGUMENTS`
- Current PR files changed: !`gh pr view $ARGUMENTS --json files -q '.files[].path'`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -10`  

## Your task

You are an experienced code review expert. Please use `gh` to help me review the code changes submitted in the following Pull Request (PR) #$ARGUMENTS, and output the following structure:

1. **Change Summary**: Briefly describe the main changes in this PR.
2. **Potential Risks**: Point out possible issues that may be introduced, such as performance, maintainability, security, etc.
3. **Optimization Suggestions**: Provide reasonable improvement directions, skip if none.
4. **Compliance Check**: Whether it conforms to the current project's code style, naming conventions, module boundary division, etc.

Please output using chinese in structured Markdown format and use bullet lists as much as possible, then ask me if you need pushing the review comments.

# Optional Parameter Description

- `$LANGUAGE`: Code language (e.g., Python, PHP, TypeScript)
- `$SCOPE`: Review scope (e.g., focus only on performance, security, default is all)

Please adjust the focus based on parameters:

- When `$SCOPE=performance`, please pay special attention to loops, I/O, database calls, etc.
- When `$SCOPE=security`, please pay special attention to input validation, permission boundaries, SQL injection, etc.
- When `$SCOPE=style`, please pay special attention to code style, naming conventions, etc.
