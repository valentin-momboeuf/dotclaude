# dotclaude

My personal [Claude Code](https://claude.ai/code) setup — global context, plugins, and statusline. This repo presents and tracks the tools I use.

## Layout

```
dotclaude/
├── CLAUDE.md              — Global context loaded in every Claude Code session
├── settings.json          — Plugins, statusline, hooks, permissions
├── hooks/
│   └── fin-de-session.sh  — UserPromptSubmit hook: end-of-session workflow
└── ccstatusline/
    └── settings.json      — Statusline layout (model, context, git, usage)
```

## Plugins

Sourced from four marketplaces.

### [claude-plugins-official](https://github.com/anthropics/claude-plugins-official)

| Plugin | Purpose |
|---|---|
| superpowers | Workflow skills (brainstorming, planning, TDD, debugging) |
| feature-dev | Guided feature development |
| code-review | Pull request reviews |
| code-simplifier | Refactor and simplify changed code |
| frontend-design | Production-grade UI components |
| context7 | Fetch up-to-date library documentation |
| github | GitHub integration |
| skill-creator | Create and edit custom skills |
| commit-commands | Git commit workflow helpers |
| claude-code-setup | Claude Code setup and configuration helpers |
| pr-review-toolkit | Pull request review toolkit |
| gopls-lsp | Go language server integration |

### [kepano/obsidian-skills](https://github.com/kepano/obsidian-skills)

| Plugin | Purpose |
|---|---|
| obsidian | Work with Obsidian vault files (.md, .base, .canvas) |

### [thedotmack/claude-mem](https://github.com/thedotmack/claude-mem)

| Plugin | Purpose |
|---|---|
| claude-mem | Cross-session memory and timeline reports |

### [elastic/agent-skills](https://github.com/elastic/agent-skills)

| Plugin | Purpose |
|---|---|
| elastic-cloud | Manage Elastic Cloud Serverless projects |
| elastic-elasticsearch | Authn/authz, audit, ingest, ES\|QL |
| elastic-kibana | Dashboards, alerting rules, connectors, audit |
| elastic-observability | Logs search, SLOs, EDOT instrumentation, LLM obs |
| elastic-security | Detection rules, alert triage, case management |

## Statusline

Uses [ccstatusline](https://github.com/sirmalloc/ccstatusline) via `npx -y ccstatusline@latest`.

Two lines:
- **Line 1**: model · context % · session cost · session clock
- **Line 2**: git branch · git worktree · reset timer · weekly cost · weekly reset timer

## Hooks

- **`fin-de-session.sh`** — `UserPromptSubmit` hook. When the prompt contains "fin de session", injects a system reminder that runs the end-of-session workflow: update memory, write an Obsidian note if relevant, commit/push the current project, then sync `dotclaude` and `dotclaude-private`.
