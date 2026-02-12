# Knowledge Browser

Knowledge Browser is a local-first repository for building an explorable knowledge base from long-form content.

Milestone 0 provides foundational scaffolding only:
- Docker Compose runtime (`postgres`, `api`, `ui`, optional `worker` profile)
- PostgreSQL + pgvector setup and schema placeholders
- FastAPI API skeleton with `/healthz`
- Typer worker CLI skeleton (`kb-worker ping`)
- Shared Pydantic core models placeholder
- Deterministic quality gates (Ruff, Mypy, Pytest) and CI workflow

## Quickstart

1. Bootstrap Python development environment:
```bash
make bootstrap
```

2. Start local services:
```bash
make compose-up
```

3. Verify API health:
```bash
make smoke
```

4. Run quality gates:
```bash
make check
```

5. Stop services:
```bash
make compose-down
```

## Developer Workflow

- Use editable local packages under `libs/` and `services/`.
- Keep changes small and run checks before opening a PR:
```bash
make format
make lint
make test
```

Or run all checks with:
```bash
make check
```

## Service Endpoints

- API: `http://localhost:8000/healthz`
- UI: `http://localhost:3000`
- Postgres: `localhost:5432`

## Repository Layout

- `infra/`: Docker Compose, DB init scripts, and automation scripts
- `services/api/`: FastAPI service skeleton
- `services/worker/`: Typer CLI worker skeleton
- `services/ui/`: minimal UI placeholder service
- `libs/kb_core/`: shared Pydantic models and interfaces
- `docs/`: architecture docs, ADRs, runbooks, decision log

## Notes

- No secrets are committed. Copy `.env.example` to `.env` if you need custom local values.
- Core business logic (ingestion, embeddings, entity extraction, linking) is intentionally deferred.
