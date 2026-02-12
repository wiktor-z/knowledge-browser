"""FastAPI application entrypoint."""

from fastapi import FastAPI

from kb_api.config import get_settings

app = FastAPI(title="Knowledge Browser API", version="0.1.0")


@app.get("/healthz", tags=["system"])
def healthz() -> dict[str, str]:
    """Lightweight service health endpoint."""

    settings = get_settings()
    return {"status": "ok", "service": settings.app_name}
