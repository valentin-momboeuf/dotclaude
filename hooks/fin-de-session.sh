#!/usr/bin/env bash
# UserPromptSubmit hook: when the user's prompt contains "fin de session"
# (case-insensitive), inject a system reminder that tells Claude to run
# the end-of-session workflow: memory, Obsidian note, commit + push on
# the current project AND on the dotclaude / dotclaude-private repos.
set -euo pipefail

input="$(cat)"
prompt="$(echo "$input" | jq -r '.prompt // empty')"

if ! echo "$prompt" | grep -qi 'fin de session'; then
  exit 0
fi

jq -n '{
  hookSpecificOutput: {
    hookEventName: "UserPromptSubmit",
    additionalContext: "Workflow fin de session déclenché par le prompt utilisateur. Exécuter dans cet ordre:\n\n1. Analyser la session en cours pour identifier ce qui mérite d'\''être retenu (bugs trouvés, décisions, préférences utilisateur, apprentissages non dérivables de la lecture du code).\n2. Mettre à jour le système de mémoire (memory/) si pertinent — suivre les règles de CLAUDE.md global (types: user/feedback/project/reference). Ne pas dupliquer de mémoire existante.\n3. Créer une note Obsidian dans le dossier du projet si des éléments substantiels ont été découverts (debug log, décisions architecturales, session log). Chemin Obsidian: consulter memory/reference_obsidian_paths.md pour localiser le dossier projet. Si le chemin n'\''est pas connu en mémoire, demander à l'\''utilisateur.\n4. Commit les changements git restants du projet courant avec des messages conventionnels (feat/fix/docs/refactor/ci/test). Respecter les règles du CLAUDE.md du projet (ex. pas de Co-Authored-By si interdit). Push vers origin sur la branche courante.\n5. Synchroniser les repos Claude dotfiles:\n   - /Users/valentin/projets/dotclaude (public: CLAUDE.md global, settings.json, hooks/, etc.) — git status; si des changements, commit avec message conventionnel (ex. chore:, feat(hooks):) et push vers origin.\n   - /Users/valentin/projets/dotclaude-private (privé: CLAUDE.md + memory/ via symlinks) — git status; si des changements, commit (ex. memory: ajout X, memory: mise à jour Y) et push vers origin.\n\nRègles importantes:\n- Si rien à commit sur un repo, ne pas créer de commit vide — passer au suivant.\n- Si rien de substantiel appris, ne pas forcer la création d'\''une note Obsidian ou d'\''une mémoire.\n- Séparer les commits logiquement (un par changement cohérent) plutôt qu'\''un commit fourre-tout.\n- Les specs/notes/ADR vont dans Obsidian, pas dans le repo public (règle feedback_specs_obsidian).\n- Ordre des repos: projet courant → dotclaude → dotclaude-private (mémoire en dernier pour refléter tous les apprentissages de la session)."
  }
}'
