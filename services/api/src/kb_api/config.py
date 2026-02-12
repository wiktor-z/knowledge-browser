"""Runtime configuration for the API service."""

from functools import lru_cache

from pydantic import Field
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """Application settings loaded from environment variables."""

    app_name: str = "knowledge-browser-api"
    environment: str = "development"
    database_url: str = Field(
        default="postgresql://kb:kb@localhost:5432/knowledge_browser",
        alias="DATABASE_URL",
    )

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        extra="ignore",
        populate_by_name=True,
    )


@lru_cache
def get_settings() -> Settings:
    """Return cached settings for process-wide reuse."""

    return Settings()
