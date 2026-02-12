# Decision Log

## 2026-02-12 — Milestone 0 Bootstrap Baseline
- **Decision**: Scaffold repository with local-first Docker Compose stack, PostgreSQL + pgvector schema placeholders, FastAPI API skeleton, Typer worker skeleton, minimal UI stub, and deterministic quality gates (`format`, `lint`, `test`, CI).
- **Reason**: Establish a stable foundation before implementing ingestion/search/entity features.
- **Impact**: Team can run, lint, type-check, and test the project consistently on local machines and in CI without external secrets or cloud dependencies.
- **Constraints reaffirmed**: Keep architecture simple, avoid microservices/queues/Kubernetes, and keep all external integrations optional.
