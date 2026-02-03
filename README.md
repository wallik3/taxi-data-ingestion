## Taxi Data Ingestion
- This project demonstrates how to build a ready-to-serve data ingestion pipeline that downloads taxi data from the internet and loads it into a PostgreSQL database using Docker, with pgAdmin provided as a user-friendly UI for inspecting the database.

- The focus is on clean architecture, containerization, and practical data engineering best practices.

## Project Overview
- The pipeline ingests taxi data for a given year and month, processes it, and uploads it into a Postgres database.

- The project consists of three main components:

    1. Ingestion Pipeline
        - Logic in a Python script `src/pipelines/ingest.py`
        - Responsible for downloading, processing, and loading data into Postgres
        - Primarily accepts input arguments such as year and month
    
    2. PostgreSQL
        - The target database store the processed taxi data
        - Stores the processed taxi data

    3. pgAdmin
        - A web-based UI for inspecting and managing the Postgres database

## Purpose
- The goal of this project is to:

    - Learn how to build a production-style ingestion pipeline
    - Understand multi-container setups using Docker
    - Separate long-running services from one-off batch jobs
    - Practice common data engineering conventions


## Next Release
- We will add airflow job to automate trigger the ingest-pipeline every month
- Demonstrate upload to Google Cloud