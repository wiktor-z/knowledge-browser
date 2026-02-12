# AGENTS.md — Knowledge Browser Project (v2 medium)

## 0. Project Identity

This repository builds a **local-first knowledge exploration system** for long-form content (podcasts, transcripts, documents).

Primary goal:

> Create a structured, explorable knowledge base with search, embeddings, entities and cross-links.

Secondary goal:

> Enable optional chat/RAG on top of structured knowledge.

This is **not** a chatbot-first project.  
Chat is an interface layer, not the core.

---

# 1. Core Engineering Principles

### 1.1 Local-First

The system must run fully locally via Docker Compose.

External APIs, cloud services or hosted models:

- must be optional
- must be configurable
- must never be required for core functionality

### 1.2 Simplicity First

Prefer the simplest architecture that works.

Avoid introducing:

- microservices
- message brokers
- distributed queues
- kubernetes
- complex orchestration

unless explicitly required.

Default architecture:

> single-node, docker-compose, postgres-first

### 1.3 Deterministic Pipelines

All ingestion and processing must be reproducible.

- Stable chunking
- Stable IDs
- No hidden randomness
- Explicit versioning of derived artifacts

### 1.4 Explainability

All derived knowledge must be traceable.

If the system claims:

- two episodes are related
- an entity exists
- a topic is linked

it must include:

> WHY (evidence)

---

# 2. Multi-Agent Collaboration Protocol

This repository is designed for parallel development with AI agents.

All agents must follow these rules.

## 2.1 One Agent = One Worktree

Each agent must work in its own branch and worktree.

Example:
git worktree add ../kb-wt-api -b feat/api-search
git worktree add ../kb-wt-worker -b feat/worker-ingest

Never commit directly to main.

---

## 2.2 Ownership Zones

To minimize merge conflicts:

| Path                 | Owner                          |
| -------------------- | ------------------------------ |
| infra/\*\*           | infra agent                    |
| services/api/\*\*    | backend agent                  |
| services/worker/\*\* | pipeline agent                 |
| services/ui/\*\*     | ui agent                       |
| libs/\*\*            | shared/core (coordinate first) |
| docs/\*\*            | maintainer/ADR owner           |

If editing outside your zone:

- document it
- keep changes minimal

---

## 2.3 Definition of Done (mandatory)

Before any commit or PR:

make format
make lint
make test

If docker or runtime affected:

make compose-up
make smoke

No PR is valid if checks fail.

---

## 2.4 Small PR Rule

Prefer atomic, small changes.

Bad:

> implement entire ingestion system

Good:

> add chunking module  
> add embeddings table  
> add search endpoint

Small PRs reduce conflicts and improve reviewability.

---

## 2.5 Rebase Strategy

Agents must frequently rebase on main.
git fetch origin
git rebase origin/main
Avoid long-lived divergent branches.

---

## 2.6 Contract-First Integration

When multiple components interact (API/UI/worker):

1. Define JSON/data contract
2. Document in `docs/architecture`
3. Then implement

Never silently change response formats.

# Remote vs Local Execution Policy

This project supports two execution modes:

- Local development (Mac/laptop, Docker Compose)
- Remote agent work (GitHub PRs, CI validation)

## When to use REMOTE (GitHub PR workflow)

Use REMOTE execution when ALL conditions are met:

1. The task can be validated by CI alone:
   - `make bootstrap`
   - `make check`
   - (optional) `make smoke` if it does not require local-only setup
2. The task does NOT require local secrets, private files, or interactive debugging.
3. The task is isolated to a small ownership zone (e.g., only `services/api/**`).
4. The expected change is deterministic and testable (unit/integration tests included).

REMOTE is preferred for:

- docs updates
- lint/test/CI improvements
- API endpoints + tests
- worker commands + unit tests
- DB schema migrations (if migrations are automated and tested)
- UI pages that can be validated with build/lint/tests

## When to use LOCAL (worktree on the laptop)

Use LOCAL execution when ANY condition is true:

- Requires manual verification (UI behavior, local performance, DB inspection).
- Requires large refactor across many zones (>3 ownership zones).
- Requires rapid interactive debugging (e.g., Docker networking issues).
- Requires heavy local resources (large files, large models, benchmarking).
- Involves secrets or private datasets.
- Introduces a new runtime subsystem (e.g., adding OpenSearch/Neo4j) or major architectural shift.

LOCAL is preferred for:

- first-time setup of new subsystems
- debugging compose/runtime issues
- performance tuning
- anything touching secrets or private data

## PR Requirements (both modes)

- Every PR must satisfy: `make check`
- If runtime changes are included, add/update `make smoke` accordingly
- Update decision log for meaningful changes
- Add ADR for architectural changes

## Model Selection Guideline (Codex)

- Use codex-5.3 for: multi-file tasks, schema/migrations, architecture docs, refactors.
- Use a cheaper model for: small isolated changes, tests, docs formatting.
  Rule of thumb: if task touches >3 files or multiple zones -> use 5.3.

---

# 3. Architecture Principles

## 3.1 Default Stack

- PostgreSQL (source of truth)
- pgvector (embeddings)
- Python services (API + worker)
- Lightweight UI
- Docker Compose runtime

## 3.2 Separation of Responsibilities

Worker:

> ingestion, chunking, embeddings, entity extraction, linking

API:

> read-only serving layer

UI:

> exploration interface

Core logic:

> lives in libs/

---

## 3.3 Data First

Database schema is a first-class artifact.

Changes to:

- schema
- pipeline
- storage model
- entity model

require ADR.

---

# 4. Coding Standards

## 4.1 Language

All code, comments, docs and commits must be in English.

Polish allowed only in chat with user.

## 4.2 Python

- Type hints required
- Pydantic for boundaries
- Ruff for lint/format
- Mypy for types
- Pytest for tests

Follow:

- DRY
- KISS
- YAGNI
- explicit over implicit

## 4.3 Configuration

Never hardcode:

- secrets
- paths
- ports
- models

Use env/config.

---

# 5. Testing Requirements

## 5.1 Unit tests required for

- chunking
- normalization
- entity extraction
- link scoring
- DB logic

## 5.2 Integration tests required for

- ingest → db
- API search
- similarity queries

## 5.3 Deterministic fixtures

Use small test transcripts in:
tests/fixtures/

Avoid random data.

---

# 6. Documentation Protocol

## 6.1 Decision Log (mandatory)

File:
docs/decisions/decision-log.md

Every meaningful change must append:

- date
- decision
- reason
- impact

---

## 6.2 ADR Required For

Create ADR in `docs/adr/` if changing:

- architecture
- schema
- storage
- pipeline logic
- major dependency

Keep concise.

---

## 6.3 Architecture Docs

Keep updated:
docs/architecture/overview.md
docs/architecture/data-model.md

Focus on clarity over length.

---

# 7. Security & Privacy

Treat all data as sensitive.

Rules:

- no telemetry
- no hidden external calls
- no secret commits
- configurable external access only

Document threat model in:
docs/architecture/threat-model.md

---

# 8. Observability (Minimal but Required)

- structured logs
- clear error messages
- no silent failures
- deterministic exits

Future metrics optional.

---

# 9. Anti-Overengineering Rule

Do not introduce:

- Kafka
- Redis (unless justified)
- Celery
- microservices
- service mesh
- kubernetes

unless explicitly requested.

Start simple.
Evolve when needed.

---

# 10. Priority Order

Agents must follow instructions in this order:

1. Safety & security
2. AGENTS.md
3. ADR decisions
4. Repository docs
5. Task prompt

If unclear:

> ask before implementing
