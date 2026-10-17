---
name: agent-shell
description: 'This skill should be used when the user asks to spawn a new agent (or agent-shell). It creates an isolated git worktree for the new agent, runs any repository setup, and launches the agent.'
tools: Bash
---

# Create a new agent-shell

Spawn a new agent-shell when the user asks to. The new agent runs inside Emacs via [agent-shell](https://github.com/xenodium/agent-shell) and works on an isolated git worktree.

## Steps

### 1. Determine the parameters

- **Prompt**: What task should the new agent work on? Use the user's request, or ask if unclear.
- **Name**: A short, kebab-case worktree name based on the task (e.g., `refactor-auth`, `fix-login-bug`, `add-dark-mode`).
- **Agent**: Which agent to use (e.g., `claude`, `codex`, `opencode`). Use the same agent as the one currently running this skill, unless the user specifies otherwise.

### 2. Create the worktree

Create a git worktree inside `.agent-shell/worktrees/` within the current repository, on a new branch named `agent/<name>`:

```sh
git worktree add -b "agent/<name>" ".agent-shell/worktrees/<name>"
```

### 3. Run repository setup

Check the worktree for setup instructions and run them. Look for:

- `CLAUDE.md`, `AGENTS.md`, `README.md` — setup/build/install commands
- `Makefile` — `make setup` or `make install`
- `package.json` — `npm install` / `npm ci` / `pnpm install` / `yarn install`
- `pyproject.toml` / `requirements.txt` — `uv sync` / `pip install -e .`
- `Gemfile` — `bundle install`
- `Cargo.toml` — `cargo fetch`
- `.env.example` — copy to `.env`

Run setup commands inside the worktree directory:

```sh
cd ".agent-shell/worktrees/<name>" && <setup-command>
```

### 4. Launch the agent in Emacs

Call `emacsclient` to start the new agent shell:

```sh
emacsclient -e '(my/agent-shell-make
   :prompt "<task description>"
   :name "<worktree-name>"
   :agent "<agent>"
   :directory "<absolute-path-to-worktree>")'
```

Example:

```sh
emacsclient -e '(my/agent-shell-make
   :prompt "Refactor the auth to use async/await. See @..."
   :name "refactor-auth"
   :agent "claude"
   :directory "/Users/me/projects/my-app/.agent-shell/worktrees/refactor-auth")'
```

Use the absolute path for `:directory`.

### 5. Report to the user

Tell the user:
- The worktree path and branch name
- What setup was run (or that no setup was needed)
- That the new agent has been launched in Emacs

## Rules

- Always create the worktree inside `.agent-shell/worktrees/` within the current repository.
- Always create a new branch named `agent/<name>` for the worktree.
- Always use absolute paths for `:directory`.
- Use the same `:agent` as the one currently running this skill, unless the user specifies otherwise.
- Run all commands via the Bash tool.
- If Emacs is not running or `emacsclient` fails, report the error to the user along with the manual command to run.
