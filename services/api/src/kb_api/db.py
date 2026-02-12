"""Database connection placeholders for future API data access logic."""

from collections.abc import Iterator
from contextlib import contextmanager
from typing import Any

import psycopg

from kb_api.config import get_settings


def get_database_url() -> str:
    """Return the configured database connection URL."""

    return get_settings().database_url


@contextmanager
def open_connection() -> Iterator[psycopg.Connection[Any]]:
    """Open a database connection.

    This helper is intentionally minimal for Milestone 0 and provides
    a stable integration point for future repository/data-layer logic.
    """

    connection = psycopg.connect(get_database_url())
    try:
        yield connection
    finally:
        connection.close()
