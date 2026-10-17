# agent-skills

Skills for Emacs agent integration, compatible with Claude Code, Codex, and other [Agent Plugins](https://agent-plugins.org) clients.

## Skills

### /create-new-agent

Spawn a new agent in Emacs (an "eagent") when the user asks to. Creates an isolated git worktree for the new agent, runs any repository setup, and launches the agent in Emacs via `emacsclient`.

- **Worktree isolation**: Each new agent works in its own git worktree under `.agent-shell/worktrees/` on a dedicated `agent/<name>` branch.
- **Automatic setup**: Detects and runs repository setup (npm, pip, cargo, bundle, make, etc.) inside the new worktree.
- **Emacs integration**: Launches the agent via `emacsclient -e '(my/agent-shell-make :prompt "..." :name "..." :agent "claude" :directory "...")'`.

## Requirements

- Emacs running a server (`M-x server-start` or `(server-start)` in your init file)
- `emacsclient` available on `$PATH`
- `my/agent-shell-make` function defined in your Emacs config (typically wraps [agent-shell](https://github.com/xenodium/agent-shell))
- Git repository for worktree creation

## Install

Run the install script to symlink skills into `~/.claude/skills` and `~/.agents/skills`:

```sh
./install.sh
```

This makes the skills available globally to Claude Code and Codex (and other Agent Skills-compatible clients).

## Structure

```
agent-skills/
├── .claude-plugin/
│   └── plugin.json          # Claude Code manifest
├── plugin.json              # Agent Plugins manifest (Codex, Cursor, Copilot, ...)
├── skills/
│   └── create-new-agent/
│       └── SKILL.md         # shared by all clients
└── README.md
```

## Credits

Inspired by [xenodium/emacs-skills](https://github.com/xenodium/emacs-skills).
