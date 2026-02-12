FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY libs/kb_core /app/libs/kb_core
COPY services/worker /app/services/worker

RUN python -m pip install --upgrade pip && \
    python -m pip install /app/libs/kb_core /app/services/worker

CMD ["kb-worker", "--help"]
