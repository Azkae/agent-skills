#!/usr/bin/env bash
# install.sh — Symlink skills into ~/.claude and ~/.agents for global discovery.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SRC="$SCRIPT_DIR/skills"

CLAUDE_SKILLS_DIR="$HOME/.claude/skills"
AGENTS_SKILLS_DIR="$HOME/.agents/skills"

mkdir -p "$CLAUDE_SKILLS_DIR" "$AGENTS_SKILLS_DIR"

for skill in "$SKILLS_SRC"/*/; do
    name="$(basename "$skill")"

    # Claude Code
    ln -sfn "$skill" "$CLAUDE_SKILLS_DIR/$name"
    echo "Linked ~/.claude/skills/$name -> $skill"

    # Codex / Agent Skills
    ln -sfn "$skill" "$AGENTS_SKILLS_DIR/$name"
    echo "Linked ~/.agents/skills/$name -> $skill"
done

echo "Done."
