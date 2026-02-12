# Local Development Runbook

## Prerequisites
- Python 3.12+
- Docker and Docker Compose
- GNU Make

## 1. Bootstrap Development Environment
```bash
make bootstrap
```

## 2. Start Local Stack
```bash
make compose-up
```

## 3. Run Quality Gates
```bash
make check
```

## 4. Run API Locally (outside Docker)
```bash
source .venv/bin/activate
uvicorn kb_api.main:app --reload --host 0.0.0.0 --port 8000
```

## 5. Run Worker Locally
```bash
source .venv/bin/activate
kb-worker --help
kb-worker ping
```

## 6. Stop Local Stack
```bash
make compose-down
```

## Troubleshooting
- Reset containers and volumes:
```bash
make compose-reset
```
- Open database shell:
```bash
make db-shell
```
