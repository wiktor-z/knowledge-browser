# Architecture Overview

## Purpose
Knowledge Browser is a local-first system for ingesting long-form content and exposing a structured knowledge base for exploration.

## Milestone 0 Scope
Milestone 0 establishes a production-quality scaffold with deterministic developer tooling and a minimal runnable stack:
- PostgreSQL with pgvector and schema placeholders
- FastAPI API skeleton with `/healthz`
- Typer worker CLI skeleton
- UI placeholder service
- Lint/type/test and CI quality gates

No business logic (ingestion, embedding generation, entity extraction, linking, search ranking) is implemented yet.

## Runtime Topology
- `postgres`: source-of-truth datastore with full-text and vector-ready schema
- `api`: read-serving layer placeholder using FastAPI
- `ui`: minimal web placeholder
- `worker` (manual profile): offline task runner placeholder using Typer

All services run via Docker Compose on a single local node.

## Planned Milestones
1. **Milestone 1**: deterministic ingestion pipeline and chunking
2. **Milestone 2**: embeddings persistence and similarity search endpoints
3. **Milestone 3**: entity extraction and evidence-backed linking
4. **Milestone 4**: exploration UX and optional RAG/chat interface

## Design Constraints
- Keep external services optional
- Preserve deterministic behavior in data processing
- Ensure explainability for derived relations and entities
- Keep architecture simple (no queues, no distributed orchestration)
