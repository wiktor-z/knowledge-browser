# ADR 0001: Choose PostgreSQL + pgvector as Core Data Platform

- Status: Accepted
- Date: 2026-02-12

## Context
Knowledge Browser needs a single local-first datastore capable of:
- transactional metadata storage
- full-text search
- vector similarity search for embeddings
- easy local operation via Docker Compose

## Decision
Use PostgreSQL as the source-of-truth database and enable pgvector for embedding storage/query support.

## Rationale
- PostgreSQL is mature, reliable, and well understood.
- Full-text search is available natively.
- pgvector adds vector indexing/query capabilities without introducing another storage system.
- Single datastore keeps Milestone 0 operational complexity low.

## Alternatives Considered
1. **PostgreSQL + external vector database**
   - Rejected for Milestone 0 due to additional operational complexity.
2. **Elasticsearch/OpenSearch-first**
   - Rejected because transactional data and schema evolution become less straightforward.
3. **SQLite + local vector extension**
   - Rejected for production-targeted scalability and concurrency limitations.

## Consequences
- Schema must include both relational and vector-aware structures.
- Performance tuning for full-text/vector indexes will be needed as data volume grows.
- Future migrations should preserve deterministic processing and explainability requirements.
