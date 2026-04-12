# dotclaude

My personal [Claude Code](https://claude.ai/code) configuration — plugins, global context, and skills.

## Contents

```
dotclaude/
├── CLAUDE.md              — Global context loaded in every Claude Code session
├── settings.json          — Plugins and statusline config
├── ccstatusline/
│   └── settings.json      — Statusline layout (model, context, git, usage)
├── skills/                — Custom skills (coming)
├── install.sh             — Installer for Linux / macOS / WSL
└── install.ps1            — Installer for Windows (native)
```

## Install

**Linux / macOS / WSL**
```bash
git clone https://github.com/valentin-momboeuf/dotclaude ~/.dotclaude
cd ~/.dotclaude
chmod +x install.sh
./install.sh
```

**Windows (native PowerShell — requires Developer Mode or admin)**
```powershell
git clone https://github.com/valentin-momboeuf/dotclaude $HOME\.dotclaude
cd $HOME\.dotclaude
.\install.ps1
```

The installer symlinks `CLAUDE.md` and `settings.json` into `~/.claude/` (or `%APPDATA%\Claude\` on Windows native). Existing files are backed up with a `.bak` extension.

## Plugins

Installed from [claude-plugins-official](https://github.com/anthropics/claude-plugins-official) and [kepano/obsidian-skills](https://github.com/kepano/obsidian-skills):

| Plugin | Purpose |
|---|---|
| superpowers | Workflow skills (brainstorming, planning, TDD, debugging) |
| feature-dev | Guided feature development |
| code-review | Pull request reviews |
| code-simplifier | Refactor and simplify changed code |
| frontend-design | Production-grade UI components |
| context7 | Fetch up-to-date library documentation |
| github | GitHub integration |
| obsidian | Work with Obsidian vault files (.md, .base, .canvas) |
| skill-creator | Create and edit custom skills |
| commit-commands | Git commit workflow helpers |
| claude-code-setup | Claude Code setup and configuration helpers |
| pr-review-toolkit | Pull request review toolkit |

## Statusline

Uses [ccstatusline](https://github.com/sirmalloc/ccstatusline) via `npx -y ccstatusline@latest`.

Two lines:
- **Line 1**: model · context % · session cost · session clock
- **Line 2**: git branch · git worktree · reset timer · weekly cost · weekly reset timer
