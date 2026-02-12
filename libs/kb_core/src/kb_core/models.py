"""Shared Pydantic models used across services."""

from datetime import datetime
from typing import Any

from pydantic import BaseModel, Field


class SourceDocument(BaseModel):
    """Represents an ingested content source."""

    id: int | None = None
    external_id: str
    title: str
    source_type: str
    source_uri: str | None = None
    metadata: dict[str, Any] = Field(default_factory=dict)
    created_at: datetime | None = None


class Chunk(BaseModel):
    """Represents a deterministic chunk extracted from a source document."""

    id: int | None = None
    document_id: int
    chunk_index: int
    content: str
    token_count: int = 0
    metadata: dict[str, Any] = Field(default_factory=dict)


class Entity(BaseModel):
    """Represents a normalized entity detected in source content."""

    id: int | None = None
    document_id: int
    canonical_name: str
    entity_type: str
    metadata: dict[str, Any] = Field(default_factory=dict)
