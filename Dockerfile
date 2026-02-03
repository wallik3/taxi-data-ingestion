# ---- Base image ----
FROM python:3.11-slim

# ---- System deps (for pandas, psycopg2, gzip, etc.) ----
RUN apt-get update && apt-get install -y \
    gcc \
    build-essential \
    libpq-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# ---- Set working directory ----
WORKDIR /app

# ---- Copy dependency metadata ----
COPY pyproject.toml ./
COPY .env .env

# ---- Install dependencies ----
# If using uv (recommended)
RUN pip install --no-cache-dir uv \
    && uv pip install --system -e .

# ---- Copy source code ----
COPY src ./src

# ---- Set entrypoint ----
ENV PYTHONPATH=.
ENTRYPOINT ["python", "src/pipelines/ingest.py"]