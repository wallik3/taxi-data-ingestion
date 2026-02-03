## About This Project

- This project is a taxi data ingestion pipeline designed as a manual batch job that loads data into a PostgreSQL database.

### Version 1

#### Step 1 : Set up Postgres & PGAdmin
- Start the required services by running:

```sh
docker-compose up
```

- This will spin up the Postgres and pgAdmin containers.

#### Step 2 : Build the ingestion image
- Build the Docker image for the data ingestion pipeline: 

```sh
docker build -t taxi_ingest:v001 .
```

#### Ingesting Data
- To ingest data, run the ingestion container with the desired year and month as arguments (eg. year=2021, month=2) :

```
docker run -it \
  --network=pg-network \
  taxi_ingest:v001 \
    --year=2021 \
    --month=2 \
```

#### Verify the Result
- After the ingestion completes, open pgAdmin and confirm that the data has been successfully inserted into the Postgres database.

#### Good Q&A
**Q** : Is a multi-container application the same as a volume?
**A** : No. A multi-container application refers to an architecture where multiple containers work together (often defined with Docker Compose). A volume is a filesystem-based storage mechanism used by containers to persist or share data. They solve different problems.

**Q** : Why don’t multi-container applications share the same volume by default?
**A** : Because containers are isolated by design. Sharing a volume is an explicit decision; without it, each container has its own filesystem. This prevents unintended file conflicts (e.g., multiple containers writing `file.csv` and overwriting each other).

**Q** : Can we specify a volume as object storage (GCS, AWS S3)?
**A** : No. Docker volumes are filesystem-based storage managed by the Docker engine. Object storage is accessed via APIs (SDKs or HTTP), so applications must connect to it in code or through libraries, not via Docker volume definitions.

```yaml
services:
  app:
    image: my-app
    environment:
      S3_BUCKET: my-bucket
```
