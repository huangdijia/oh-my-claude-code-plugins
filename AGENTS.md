# Repository Guidelines

## Project Structure & Module Organization

- `README.md` / `README_CN.md` describe usage; `CLAUDE.md` provides in-depth Claude Code workflows; `AGENTS.md` contains development guidelines.
- `.claude-plugin/marketplace.json` is the single source for plugin metadata; keep file paths in sync before publishing.
- `plugins/subagents/agents/*.md` define AI agents; `plugins/git/commands/*.md` handle Git Flow branches; `plugins/git-flow/commands/**` cover PR/MR automation, commit creation, and status; `plugins/git-flow/hooks/*.json` add optional git hooks; `plugins/mcp/.mcp.json` lists MCP servers; `plugins/skills/*/` contains specialized development skills.
- Keep new assets within the relevant plugin folder and use kebab-case filenames (e.g., `new-agent.md`).

## Build, Test, and Development Commands

- Content-only repo—no compile step.
- Validate manifest syntax: `jq . .claude-plugin/marketplace.json`.
- Spot path/name drift for hooks and commands: `rg --files plugins/git-flow plugins/skills | sort`.
- Dry-run install in Claude Code: `claude plugin marketplace add huangdijia/oh-my-claude-code-plugins` then `claude plugin install subagents@oh-my-claude-code-plugins` (repeat for `git`, `git-flow`, `mcp`, `skills`).

## Coding Style & Naming Conventions

- Markdown files start with YAML front matter; common sections are `Context` and `Your task` with ordered steps.
- Use sentence-case headings, two-space list indents, and fenced code blocks with language hints (e.g., ```bash```).
- Keep `allowed-tools` scoped and minimal; prefer kebab-case filenames and hyphenated keys in JSON.
- Write concise, action-focused instructions; English preferred, Chinese acceptable when mirroring existing tone.

## Testing Guidelines

- No automated suite; rely on manual checks.
- Validate JSON/YAML with `jq` or `yq eval .`.
- After edits, install the updated plugin in Claude Code and run a representative command (e.g., `/git:flow-status`, `/git-flow:pr:create`, `Use the feature-dev skill to help me`, `Use the code-review skill to review my changes`) to confirm prompts and tool scopes.
- Note manual test steps and outcomes in PRs.

## Commit & Pull Request Guidelines

- Commit messages are short summaries (English or Chinese), e.g., `Fix marketplace hook path` or `更新 git-flow hooks 路径`.
- One logical change per commit; keep diffs focused.
- PRs should state which plugin(s) changed, the intent, and validation steps; link related issues when present. Screenshots are optional and only needed when output formatting changes.

## Security & Configuration Tips

- Never include tokens, SSH remotes, or personal identifiers in examples.
- Keep `allowed-tools` entries limited to required git/gh commands to reduce risk.
- Confirm hook filenames and manifest references match exactly to avoid broken marketplace installs.
- Skills inherit the tool permissions of the agent using them - ensure appropriate agent selection for sensitive operations.
