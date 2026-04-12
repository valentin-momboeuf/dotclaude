# install.ps1 — Deploy dotclaude config to Claude config directory
# Supports: Windows (native PowerShell)
# On Linux/macOS/WSL, run install.sh instead

$ErrorActionPreference = "Stop"

$RepoDir   = Split-Path -Parent $MyInvocation.MyCommand.Path
$ClaudeDir = Join-Path $env:APPDATA "Claude"

# ── Colors ────────────────────────────────────────────────────────────────────
function Log-Ok   { param($msg) Write-Host "  [OK]  $msg" -ForegroundColor Green }
function Log-Warn { param($msg) Write-Host "  [!]   $msg" -ForegroundColor Yellow }
function Log-Err  { param($msg) Write-Host "  [ERR] $msg" -ForegroundColor Red }

Write-Host ""
Write-Host "dotclaude installer"
Write-Host "OS: Windows (native)"
Write-Host "Target: $ClaudeDir"
Write-Host ""

# ── Create Claude dir if needed ───────────────────────────────────────────────
New-Item -ItemType Directory -Force -Path $ClaudeDir | Out-Null
New-Item -ItemType Directory -Force -Path "$ClaudeDir\skills" | Out-Null

# ── Helper: symlink with backup ───────────────────────────────────────────────
function Link-File {
    param($Src, $Dest)

    if ((Test-Path $Dest) -and -not (Get-Item $Dest).LinkType) {
        Move-Item -Force $Dest "$Dest.bak"
        Log-Warn "Backed up existing $(Split-Path -Leaf $Dest)"
    }

    New-Item -ItemType SymbolicLink -Force -Path $Dest -Target $Src | Out-Null
    Log-Ok "Linked $(Split-Path -Leaf $Src)"
}

# ── Deploy files ──────────────────────────────────────────────────────────────
# Note: creating symlinks on Windows requires admin rights or Developer Mode enabled
Link-File "$RepoDir\CLAUDE.md"     "$ClaudeDir\CLAUDE.md"
Link-File "$RepoDir\settings.json" "$ClaudeDir\settings.json"

# Link skills
$SkillsDir = Join-Path $RepoDir "skills"
if (Test-Path $SkillsDir) {
    Get-ChildItem "$SkillsDir\*.md" | ForEach-Object {
        Link-File $_.FullName "$ClaudeDir\skills\$($_.Name)"
    }
}

Write-Host ""
Log-Ok "dotclaude installed successfully."
Write-Host ""
Write-Host "  Restart Claude Code to apply changes."
Write-Host ""
