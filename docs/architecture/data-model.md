# Data Model (Placeholder)

## Core Tables
- `kb.source_documents`: canonical source metadata for imported content
- `kb.chunks`: deterministic document chunks with optional embeddings and full-text index
- `kb.entities`: extracted entities scoped to source documents
- `kb.chunk_entity_links`: evidence-backed entity mentions per chunk

## Relationship Summary
- One `source_document` has many `chunks`
- One `source_document` has many `entities`
- Many-to-many between `chunks` and `entities` through `chunk_entity_links`

## Indexing Strategy (Initial)
- Full-text search: `chunks.search_vector` GIN index
- Vector search: `chunks.embedding` ivfflat index (pgvector)
- Entity lookup: trigram index on `entities.canonical_name`

## Notes
This model is intentionally minimal and may evolve through ADRs as ingestion and linking logic is implemented.
