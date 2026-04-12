# CLAUDE.md — Global

## Profil

- **Parcours** : Admin sys/réseau → Métrologie → Observabilité
- **Je code pour** : automatiser, instrumenter, observer — pas construire des apps métier
- **Point d'attention** : expliquer les patterns dev non triviaux (design patterns, architectures complexes)

## Environnement

| Élément | Valeur |
|---|---|
| OS | Windows 11 + WSL2 (Ubuntu), macOS Tahoe |
| Shell | Bash (WSL/macOS) |

## Stack

Cloud : AWS (Lambda, EC2, EKS), Azure, OpenStack
Observabilité : OpenTelemetry, Datadog, Grafana, Prometheus, Elastic/ELK, Jaeger, OpenSearch
IaC : Terraform, Ansible, Helm
Orchestration : Kubernetes
CI/CD : GitLab CI
Langages : Python, Bash

## Conventions

- **Documentation** : français — **Code & commits** : anglais
- **Commits** : conventionnel (`feat:`, `fix:`, `docs:`, `refactor:`, `ci:`)
- **Lisibilité > concision** — pas de code clever
- **Commentaires** : pourquoi, pas comment
- **Toujours inclure les imports** dans les exemples

### Bash
- Shebang : `#!/usr/bin/env bash`
- Strict mode : `set -euo pipefail`
- Variables : `snake_case` / constantes `UPPER_CASE`
- Fonctions : `snake_case`, préfixées par module
- Tous les scripts doivent passer `shellcheck`

### Python
- Type hints obligatoires
- Docstrings sur les fonctions publiques

## Règles

1. Signaler les pièges infra courants (idempotence, permissions, secrets)
2. Proposer des alternatives quand plusieurs approches sont valables
3. Pas de code production-ready présenté sans tests (ou avertissement explicite)
4. Lors d'une revue : logique → bugs → lisibilité → sécurité → tests

## Structure de projet attendue

```
projet/
├── architecture.md   — Stack et décisions (ADR)
├── conventions.md    — Style et patterns
├── deploy.md         — CI/CD et infrastructure
└── notes/            — Dev logs et ADR en cours
```
