#!/usr/bin/env bash
# install.sh — Deploy dotclaude config to ~/.claude/
# Supports: Linux, WSL, macOS
# On Windows (native), run install.ps1 instead
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${HOME}/.claude"

# ── Colors ────────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_ok()   { echo -e "${GREEN}  ✔${NC}  $*"; }
log_warn() { echo -e "${YELLOW}  !${NC}  $*"; }
log_err()  { echo -e "${RED}  ✘${NC}  $*"; }

# ── OS detection ──────────────────────────────────────────────────────────────
detect_os() {
    case "$(uname -s)" in
        Linux*)
            if grep -qi microsoft /proc/version 2>/dev/null; then
                echo "wsl"
            else
                echo "linux"
            fi
            ;;
        Darwin*) echo "macos" ;;
        *)        echo "unknown" ;;
    esac
}

OS=$(detect_os)
echo ""
echo "dotclaude installer"
echo "OS detected: ${OS}"
echo "Target: ${CLAUDE_DIR}"
echo ""

if [[ "${OS}" == "unknown" ]]; then
    log_err "Unsupported OS. On Windows (native), run install.ps1 instead."
    exit 1
fi

# ── Create ~/.claude if needed ────────────────────────────────────────────────
mkdir -p "${CLAUDE_DIR}"
mkdir -p "${CLAUDE_DIR}/skills"

# ── Helper: symlink with backup ───────────────────────────────────────────────
link_file() {
    local src="$1"
    local dest="$2"

    if [[ -e "${dest}" && ! -L "${dest}" ]]; then
        mv "${dest}" "${dest}.bak"
        log_warn "Backed up existing $(basename "${dest}") → $(basename "${dest}").bak"
    fi

    ln -sf "${src}" "${dest}"
    log_ok "Linked $(basename "${src}")"
}

# ── Deploy files ──────────────────────────────────────────────────────────────
link_file "${REPO_DIR}/CLAUDE.md"     "${CLAUDE_DIR}/CLAUDE.md"
link_file "${REPO_DIR}/settings.json" "${CLAUDE_DIR}/settings.json"

# Link skills
if [[ -d "${REPO_DIR}/skills" ]]; then
    for skill_file in "${REPO_DIR}/skills"/*.md; do
        [[ -e "${skill_file}" ]] || continue
        skill_name="$(basename "${skill_file}")"
        link_file "${skill_file}" "${CLAUDE_DIR}/skills/${skill_name}"
    done
fi

echo ""
log_ok "dotclaude installed successfully."
echo ""
echo "  Restart Claude Code to apply changes."
echo ""
